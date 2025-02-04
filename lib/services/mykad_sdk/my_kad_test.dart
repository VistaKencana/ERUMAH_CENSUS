import 'package:eperumahan_bancian/services/app_info.dart';
import 'package:eperumahan_bancian/services/mykad_sdk/my_kad_reader.dart';
import 'package:flutter/material.dart';

class MyKadTest extends StatefulWidget {
  const MyKadTest({super.key});

  @override
  State<MyKadTest> createState() => _MyKadTestState();
}

class _MyKadTestState extends State<MyKadTest> {
  Future addDelay({int milisec = 1500}) =>
      Future.delayed(Duration(milliseconds: milisec));
  void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2), // Adjust duration as needed
      ),
    );
  }

  bool isInitialize = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("MyKad Debugger"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _button(
                onPressed: () async {
                  debugPrint("Packahe name: ${AppInfo().packageName}");
                  if (isInitialize) {
                    showSnackBar(context, "Please dispose");
                    return;
                  }
                  await MyKadReader.callSDK(
                      license:
                          "eyJ2ZXJzaW9uIjoyLCJjb2RlIjoxMDF9.eyJpYXQiOjE3Mzg2Mjk0MTYsImNoYWxsYW5nZV9jb2RlIjoiYm43dDZrVmFCSCIsImNpcGhlciI6IlltSCtmSnhVckYvMUxHaVZ4Z2c3ZzQrUDhxVXJRUTN2Y3Z4aXQ3WXRneTFzUzY5QmF3U2RBN0lGRHNHeDVaRFcrQWFOUVBnTnU2c1Q0WVdTZTNJS3ZlRG1oQ1QvRWt0NDc5dWFGOXl0ckx6cVd2WlNJdlNWV05SclRSOFppWjlzbGpVTW05MmNFejBXNUVWYXFVa0c3ZWRoSndrN1BROENlZHJuQkNkaCsrS1RpWVM0cm5IMFRPY1B6ZkxjRDYwSUJ3cHBnc3pnbHFITWtQREdIZzJKY0FnTlRaMFYyaUw4THNQVHl4ZGdFbGk3czh6QjFnTE5JZS9ZVVlrWnYva284QkliYStueW1OTG1hU1FGdWRVaW0rVDYreVVicnNYWGlnVCtxM3FQMTR2bVpSOEZnampKc052a0hqTFVpaTU2eTV6QllybmRIRS93N0VDd0JXWTNEbTVncFdOWGVXT01KUWNBaTFObGxZdWE2N2RPZkozazRQdEc4NmVJcGVOZHptUnRtT1lURmFkRWJWQm9VOHV2SlE3anRMYnkva3VBanprUitmd1dNUkVXUDdjTEpGR0tVb1RESTZhQ0doUXI4S1FjendaNWRLdEZ4YWNOMktTMFkvb2hiajJvaGdqMHJZUFhhT1p5TlQ5OVF4M2lDbFFEQVBiNGtMN21YTnduNXJyS3ZsNkk3NFdJcFZzVkFlR2owMmhvK0wyeFhWN3BUdWQ2bitKREhkNlVGRWw4V1ZJZy8rYS9neWFMbURXUFpGS3FQa2p3dVlZWm5MN1JhSGJScVZZRGJSTzdtcXZvbDJuR0pkNG51eDdRQXRhTHhLbjZHT29YeVVlLytscnhKNzc1clJaWWhXNk5adG1WTzRCNEIxQ3pocGt3TVR5Yi9GcHhjYk45MlZVPSJ9.MEYCIQC-GaeUfBIT9LbQgeilaPZ1ge5_mV0E09s108jnUtqVhQIhAPCKaouiqTzTJbILyoAyp1beuH0vbh48q3y3NdlkGJR_");
                  // license:
                  //     "eyJ2ZXJzaW9uIjoyLCJjb2RlIjoxMDF9.eyJpYXQiOjE3Mzg2Mjk1MzksImNoYWxsYW5nZV9jb2RlIjoid0lCWkVtUldvRSIsImNpcGhlciI6Ik5sLythN1FsRERIeHZrbU5zaTF3TkgzS3FVZmN6R1FJRFBBbUo1eThWaG1RWW9sUTUyWUNZK3RqQ1dTb3cvSW5rMUpZMHZGUFhHRHdybVl3blN0dE9tbWFFSjVFT0haRU9HTWx0d25heUJwN2V6bGFTUVFpL0tsU0JhclNmc1k1b05wUGsyVys5elFqbzRVd29XakU3TE5PbzRseUNhc2J4QXRqM0JzU3lEY2VwTUVUVHhURkZvVEdYZUxQNHl5cDNna1YySDEreWlyVkR3Z2hBWGkrREptY2hUVkJaR3RRZHp3YmNWMkNCQlVIclA3M0xUanFrbENtU3R4T1NLSTZzbS9EVHNmaFhNVTF1RGRKYTZzb1RwZyszNUFKOWwrSzBnbTBKSjE2aUJPa1pET1ZUVkJKSFR1RTFJdkFXUWliOEg5dE4vWUdnNGpYVWFINzlBcXVmVnRlaHM1Q2t6NVFKUkRSY2xTMXhNdVVndzlHOUZmVUM3QkNaWWM3MkdUZmJpdGRndDFnZDRRazM2MnJhTFY5Y29zbjNmVjdlY0NjK2g3RkR4NEdPZHp5dzlHem1Ja0VodU9NcjhiTEVKSnJGV0lRUEdZQllaeGtXVjRoZjRueGxVUUNuUlNKRitZby9XbU13TWo4eU9vUnI3M3hWakUwKzN3OXcxVGRUNlZLb2JNUFhSR1VUVEdDRzBQaVdsS2E4SmlWMThVS0w4ZXFWbFNDc3lDTDNDWnl1UTMxNW5qaHNTd2FDV3ZXSjluS3NtOTlpRkpwaDRkYmlIR0M5T0d2QkVuQ2V0UnNiRUV4ZE04VmFNVk40bzcrY1JncTNVbkU0ZXpNWE9GdTNKY2VEVEVoSzJ2Q0xJOWFwRVgwaDVQVzFHeFhRd2tLZGwwZlRmTDU3Q3N3N1FRPSJ9.MEUCIQD783vTo8jltbTE_Glsn-ETaidHbovjZAy7n2QHMqg6bAIgUbt4PRULVhwi8MPDoxIvy10euIRs5jiIou9yrakvdcE");
                  setState(() => isInitialize = true);
                },
                title: "Initiate SDK"),
            _button(
                onPressed: () async {
                  if (!isInitialize) {
                    showSnackBar(context, "Please Initialize");
                    return;
                  }
                  await MyKadReader.disconnectFPScanner();
                  await addDelay();
                  await MyKadReader.turnOffFP();
                  await addDelay();
                  await MyKadReader.disposeListener();
                  setState(() => isInitialize = false);
                },
                title: "Dispose SDK"),
            // _button(onPressed: () async {}, title: "title"),
            // _button(onPressed: () async {}, title: "title"),
            // _button(onPressed: () async {}, title: "title"),
            // _button(onPressed: () async {}, title: "title"),
          ],
        ),
      ),
    );
  }

  _button({required void Function()? onPressed, required String title}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: ElevatedButton(onPressed: onPressed, child: Text(title)),
    );
  }
}
