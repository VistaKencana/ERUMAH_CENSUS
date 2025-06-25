package com.pppa.bancian;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugins.GeneratedPluginRegistrant;
import io.flutter.plugin.common.MethodChannel;

import androidx.annotation.NonNull;
import androidx.localbroadcastmanager.content.LocalBroadcastManager;

import android.bluetooth.BluetoothAdapter;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.hardware.usb.UsbDevice;
import android.hardware.usb.UsbManager;
import android.os.Handler;
import android.os.Looper;
import android.util.Log;
import android.widget.Toast;
import android.os.Bundle;

import com.example.mykad_sdk.AsyncTaskExecutorService;
import com.example.mykad_sdk.FingerPrintManager;
import com.example.mykad_sdk.ReadCard;
import com.example.mykad_sdk.ReaderStatus;
import com.example.mykad_sdk.SDKResponse;
import com.example.mykad_sdk.TaskCanceler;
import com.example.mykad_sdk.fpswitch.DeviceFilterImpl;
import com.example.mykad_sdk.fpswitch.DeviceInfo;
import com.example.mykad_sdk.fpswitch.ReadFingerprint;
import com.securemetric.reader.myid.MyID;
import com.securemetric.reader.myid.MyIDException;
import com.securemetric.reader.myid.MyIDListener;
import com.securemetric.reader.myid.MyIDPermissionListener;
import com.securemetric.reader.myid.MyIDReaderStatus;

import java.util.List;
import java.util.Map;

public class MainActivity extends FlutterActivity implements MyIDListener, MyIDPermissionListener {
    private final String CHANNEL = "com.myKad/fingerprint";
    private LocalBroadcastManager mLocalBCManager;
    private MyID mReaderManager;
    private static final String TAG = "MyKAD_SDK";
    private Runnable mMyIDInfoActivityStartup;
    private final Handler mHandlerTask = new Handler(Looper.getMainLooper());
    public MethodChannel methodChannel;
    private final DeviceFilterImpl mDeviceFilter = new DeviceFilterImpl();
    public boolean usingFP = false;
    FingerPrintManager fpManager = FingerPrintManager.getInstance();

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        // Catch unhandled exceptions
        Thread.setDefaultUncaughtExceptionHandler((thread, throwable) -> {
            Log.e("APP_CRASH", "Uncaught exception in thread " + thread.getName(), throwable);
        });
    }
    
    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine);
        methodChannel = new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL);
        methodChannel.setMethodCallHandler(
                (call, result) -> {
                    final String req = call.method;
                    switch (req) {
                        case "myKadSDK":
                            Boolean args = call.argument("usingFP");
                            usingFP = (args != null) ? args : false;
                            String lesen = call.argument("license");
                            startMyKadSDK(lesen);
                            result.success(null);
                            break;
                        case "turnOnFP": {
                            Boolean data = turnOnFP();
                            result.success(data);
                            break;
                        }
                        case "turnOffFP": {
                            Boolean data = turnOffFP();
                            result.success(data);
                            break;
                        }
                        case "connectScanner": {
                            Boolean data = fpManager.connectFPDevice(getApplicationContext());
                            result.success(data);
                            break;
                        }
                        case "disconnectScanner": {
                            Boolean data = fpManager.disconnectFPDevice();
                            result.success(data);
                            break;
                        }
                        case "getFPDeviceList": {
                            String data = getFPDeviceList();
                            result.success(data);
                            break;
                        }
                        case "readFingerprint": {
                            SDKResponse res = new SDKResponse("VERIFY_FP", "Verifying Fingerprint", "");
                            methodChannel.invokeMethod("VERIFY_FP", res.toJson().toString());
                            runOnUiThread(() -> {
                                try {
                                    mTask = new ReadFingerprint(mReaderManager, getApplicationContext(), methodChannel);
                                    mTask.execute(pluggedReader);
                                    if (mTaskCanceler != null && mHandlerTask != null)
                                        mHandlerTask.removeCallbacks(mTaskCanceler);
                                    mTaskCanceler = new TaskCanceler(mTask, 0xFF);
                                    mHandlerTask.postDelayed(mTaskCanceler, 200 * 1000L);
                                } catch (Exception e) {
                                    Toast.makeText(getApplicationContext(), "Read fingerprint error", Toast.LENGTH_SHORT).show();
                                }
                            });
                            break;
                        }
                        case "dispose":
                            onDispose();
                            result.success(null);
                            break;
                        default:
                            result.notImplemented();
                            break;
                    }
                }
        );
    }


    private boolean turnOnFP() {
        try {
            fpManager.initFPConnector(getApplicationContext());
            return true;
        } catch (Exception e) {
            Log.e(TAG, e.toString());
            return false;
        }
    }

    private String getFPDeviceList() {
        try {
            Log.d(TAG, "Attempting to get FP device list");
            final List<DeviceInfo> data = fpManager.getFPDeviceList(getApplicationContext());
            String result = data != null ? DeviceInfo.listToJson(data).toString() : "-";
            Log.d(TAG, "FP device list size: " + result);
            return result;
        } catch (UnsupportedOperationException e) {
            Log.e(TAG, "UnsupportedOperationException: " + e.toString());
            return "Failed to get List: Unsupported operation: " + e;
        } catch (Exception e) {
            Log.e(TAG, "Exception: " + e.toString());
            return "Failed to get List: " + e;
        }
    }


    private boolean turnOffFP() {
        try {
            fpManager.turnOffSwitch(getApplicationContext());
            return true;
        } catch (Exception e) {
            Log.e(TAG, e.toString());
            return false;
        }
    }

    private void startMyKadSDK(String lesen) {
        if (mReaderManager != null) {
            String msg = "MyKad Already Initialize";
            Log.d(TAG, msg);
            return;
        }
        Log.d(TAG, "Initialize SDK");
        mLocalBCManager = LocalBroadcastManager.getInstance(getApplicationContext());
        mReaderManager = new MyID();
        mReaderManager.setOnReaderStatusChanged(this);
        mReaderManager.setOnPermissionListener(this);
        // Set implementation of device filter to filter out devices.
        mReaderManager.setDeviceFilter(mDeviceFilter);
        try {
//            String license = "eyJ2ZXJzaW9uIjoyLCJjb2RlIjoxMDF9.eyJpYXQiOjE3Mzg2Mjk0MTYsImNoYWxsYW5nZV9jb2RlIjoiYm43dDZrVmFCSCIsImNpcGhlciI6IlltSCtmSnhVckYvMUxHaVZ4Z2c3ZzQrUDhxVXJRUTN2Y3Z4aXQ3WXRneTFzUzY5QmF3U2RBN0lGRHNHeDVaRFcrQWFOUVBnTnU2c1Q0WVdTZTNJS3ZlRG1oQ1QvRWt0NDc5dWFGOXl0ckx6cVd2WlNJdlNWV05SclRSOFppWjlzbGpVTW05MmNFejBXNUVWYXFVa0c3ZWRoSndrN1BROENlZHJuQkNkaCsrS1RpWVM0cm5IMFRPY1B6ZkxjRDYwSUJ3cHBnc3pnbHFITWtQREdIZzJKY0FnTlRaMFYyaUw4THNQVHl4ZGdFbGk3czh6QjFnTE5JZS9ZVVlrWnYva284QkliYStueW1OTG1hU1FGdWRVaW0rVDYreVVicnNYWGlnVCtxM3FQMTR2bVpSOEZnampKc052a0hqTFVpaTU2eTV6QllybmRIRS93N0VDd0JXWTNEbTVncFdOWGVXT01KUWNBaTFObGxZdWE2N2RPZkozazRQdEc4NmVJcGVOZHptUnRtT1lURmFkRWJWQm9VOHV2SlE3anRMYnkva3VBanprUitmd1dNUkVXUDdjTEpGR0tVb1RESTZhQ0doUXI4S1FjendaNWRLdEZ4YWNOMktTMFkvb2hiajJvaGdqMHJZUFhhT1p5TlQ5OVF4M2lDbFFEQVBiNGtMN21YTnduNXJyS3ZsNkk3NFdJcFZzVkFlR2owMmhvK0wyeFhWN3BUdWQ2bitKREhkNlVGRWw4V1ZJZy8rYS9neWFMbURXUFpGS3FQa2p3dVlZWm5MN1JhSGJScVZZRGJSTzdtcXZvbDJuR0pkNG51eDdRQXRhTHhLbjZHT29YeVVlLytscnhKNzc1clJaWWhXNk5adG1WTzRCNEIxQ3pocGt3TVR5Yi9GcHhjYk45MlZVPSJ9.MEYCIQC-GaeUfBIT9LbQgeilaPZ1ge5_mV0E09s108jnUtqVhQIhAPCKaouiqTzTJbILyoAyp1beuH0vbh48q3y3NdlkGJR_";
            // Original License
           String lisin = "eyJ2ZXJzaW9uIjoxLCJwYXlsb2FkIjoiNlVDaG5rVHZoZkt6b1FvZUVoWmIzUnEvaWVqak5ydUM5VmdmZ2VjdVFTejc5TXRtQ1VGS1pHZWJ2OXVmZnQ2MnJ3L1R4eWNVd0d1UTJVMXNwYW13WWxCSGQwVG9yS0I3dHE2UlVaQU5RMGo0d2NuMVhNSXBNaW1kNXc5WGlLWGtjU0FRT3RCdEZJMFdkek1KTm9xZlRKaVVNbjJlU3d0Yy9sUFdHYlY1cHN0UWhGM1l4bWxWZlRPWXQ1MWpZSE5NIiwic2lnbmF0dXJlIjoiTUVVQ0lRQ3R6UmRMc2tWcUdDYTBJVTdYdjBjNDIyRFV2U25rOXVwalk4QVorUi9kRWdJZ1IwSVRWOVVzV29yUTZOMGxOOHp3bTZ6anM2c2lwSXVnejBUL0kxdzdaSms9IiwiY2hhbGxhbmdlX2NvZGUiOiJuRGFsTFhsYzlLIn0=";
           String license =(lesen!= null)?lesen:lisin;
            mReaderManager.init(getApplicationContext(), true, license);
        } catch (MyIDException e) {
            Log.d(TAG, "Error on initiate");
            Log.e(TAG, Log.getStackTraceString(e));
            Toast.makeText(this, e.getMessage(), Toast.LENGTH_SHORT).show();
        }
        Toast.makeText(getApplicationContext(), "MySDK has initialize", Toast.LENGTH_SHORT).show();
    }

    SDKResponse sdkResponse;
    private String pluggedReader = "";
    private AsyncTaskExecutorService<String, String, String> mTask = null;
    private TaskCanceler mTaskCanceler;

    @Override
    public void onCardStatusChange(String readerName, short status) {
        if (mMyIDInfoActivityStartup != null && mHandlerTask != null) {
            mHandlerTask.removeCallbacks(mMyIDInfoActivityStartup);
            mMyIDInfoActivityStartup = null;
        }
        if (status == MyIDReaderStatus.READER_INSERTED) {
            String method = ReaderStatus.READER_INSERTED.name();
            sdkResponse = new SDKResponse(method, "Insert SmartCard ...", "");
            methodChannel.invokeMethod(method, sdkResponse.toJson());
        } else if (status == MyIDReaderStatus.CARD_INSERTED) {
            String method = ReaderStatus.CARD_INSERTED.name();
            sdkResponse = new SDKResponse(method, "Retrieve data ...", "");
            methodChannel.invokeMethod(method, sdkResponse.toJson());
            runOnUiThread(() -> {
                pluggedReader = readerName;
                //CHECK FINGERPRINT SCANNER
                //TODO : CHECK FINGERPRINT
                //READING CARD
                mTask = new ReadCard(mReaderManager, methodChannel, readerName, usingFP, getApplicationContext());
                mTask.execute(readerName);
                if (mTaskCanceler != null && mHandlerTask != null)
                    mHandlerTask.removeCallbacks(mTaskCanceler);
                mTaskCanceler = new TaskCanceler(mTask, 0xFF);
                mHandlerTask.postDelayed(mTaskCanceler, 200 * 1000L);
            });
        } else if (status == MyIDReaderStatus.CARD_REMOVE) {
            String method = ReaderStatus.CARD_REMOVE.name();
            sdkResponse = new SDKResponse(method, "Insert SmartCard ...", "");
            methodChannel.invokeMethod(method, sdkResponse.toJson());
        } else if (status == MyIDReaderStatus.READER_REMOVED) {
            String method = ReaderStatus.READER_REMOVED.name();
            sdkResponse = new SDKResponse(method, "Reader Detach", "");
            methodChannel.invokeMethod(method, sdkResponse.toJson());
        }
    }

    @Override
    public void onRequestUsbPermission(UsbDevice usbDevice) {

    }

    @Override
    public void onRequestBluetoothEnable(BluetoothAdapter bluetoothAdapter) {

    }


    protected void onDispose() {
        if (mReaderManager != null) {
            mReaderManager.setOnUsbPermissionListener(null);
            mReaderManager.setOnReaderStatusChanged(null);
            mReaderManager.disconnectReader();
            mReaderManager.destroy();
            mReaderManager = null;
        }
    }
}