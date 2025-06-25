package com.pppa.bancian.usb;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.hardware.usb.UsbDevice;
import android.hardware.usb.UsbManager;
import android.util.Log;
import android.widget.Toast;

import com.example.mykad_sdk.FingerPrintManager;

public class UsbReceiver extends BroadcastReceiver {
    private static final String TAG = "UsbReceiver";

    @Override
    public void onReceive(Context context, Intent intent) {
        if (intent == null || intent.getAction() == null) return;

        String action = intent.getAction();
        UsbDevice usbDevice = intent.getParcelableExtra(UsbManager.EXTRA_DEVICE);
        if (usbDevice == null) return;

        switch (action) {
            case UsbManager.ACTION_USB_DEVICE_ATTACHED:
                Log.d(TAG, "USB Attached: " + usbDevice.getDeviceName());
                Toast.makeText(context, "USB Attached: " + usbDevice.getDeviceName(), Toast.LENGTH_SHORT).show();

                try {
                    // Initialize and connect the fingerprint scanner
                    FingerPrintManager.getInstance().initFPConnector(context);
                    FingerPrintManager.getInstance().connectFPDevice(context);
                    Log.d(TAG, "Fingerprint device initialized on attach.");
                } catch (Exception e) {
                    Log.e(TAG, "Error initializing fingerprint device on attach", e);
                }
                break;

            case UsbManager.ACTION_USB_DEVICE_DETACHED:
                Log.d(TAG, "USB Detached: " + usbDevice.getDeviceName());
                Toast.makeText(context, "USB Detached: " + usbDevice.getDeviceName(), Toast.LENGTH_SHORT).show();

                try {
                    // Clean up
                    FingerPrintManager.getInstance().disconnectFPDevice();
                    FingerPrintManager.getInstance().turnOffSwitch(context);
                    Log.d(TAG, "Fingerprint device cleanup on detach.");
                } catch (Exception e) {
                    Log.e(TAG, "Error disconnecting fingerprint device on detach", e);
                }
                break;

            default:
                Log.w(TAG, "Unhandled USB event: " + action);
        }
    }
}
