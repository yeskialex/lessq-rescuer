import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'dart:io';
import 'notifications.dart';

class SmartWatchPage extends StatefulWidget {
  const SmartWatchPage({super.key});

  @override
  State<SmartWatchPage> createState() => _SmartWatchPageState();
}

class _SmartWatchPageState extends State<SmartWatchPage> {
  Future<void> requestBluetoothPermission() async {
    try {
      if (Platform.isIOS) {
        // On iOS, we need to actually use Bluetooth APIs to trigger the permission dialog
        debugPrint('Requesting Bluetooth access on iOS...');

        // Check if Bluetooth is supported
        if (await FlutterBluePlus.isSupported == false) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Bluetooth not supported on this device'),
                backgroundColor: Colors.red,
                duration: Duration(seconds: 3),
              ),
            );
          }
          return;
        }

        // Turn on Bluetooth adapter (this triggers the permission dialog)
        await FlutterBluePlus.turnOn();

        // Check adapter state
        final adapterState = await FlutterBluePlus.adapterState.first;
        // debugPrint('Bluetooth adapter state: $adapterState');

        if (!mounted) return;

        String message;
        Color backgroundColor;

        switch (adapterState) {
          case BluetoothAdapterState.on:
            message = 'Bluetooth enabled! Smart watch connectivity ready.';
            backgroundColor = Colors.green;

            // Start scanning briefly to ensure permission is triggered
            try {
              await FlutterBluePlus.startScan(timeout: const Duration(seconds: 1));
              await FlutterBluePlus.stopScan();
            } catch (e) {
              debugPrint('Scan error (expected): $e');
            }
            break;
          case BluetoothAdapterState.off:
            message = 'Bluetooth is turned off. Please enable Bluetooth.';
            backgroundColor = Colors.orange;
            break;
          case BluetoothAdapterState.unavailable:
            message = 'Bluetooth unavailable on this device.';
            backgroundColor = Colors.red;
            break;
          case BluetoothAdapterState.unauthorized:
            message = 'Bluetooth access denied. Enable in Settings > Privacy & Security > Bluetooth';
            backgroundColor = Colors.red;
            break;
          default:
            message = 'Bluetooth status: $adapterState';
            backgroundColor = Colors.blue;
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(message),
            backgroundColor: backgroundColor,
            duration: const Duration(seconds: 2),
          ),
        );

        // Navigate to notifications page immediately after permission response
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const NotificationsPage()),
        );
      } else {
        // Android or other platforms
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Bluetooth permission handling for this platform'),
            backgroundColor: Colors.blue,
            duration: Duration(seconds: 2),
          ),
        );

        // Navigate to notifications page immediately
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const NotificationsPage()),
        );
      }
    } catch (e) {
      debugPrint('Error requesting bluetooth permission: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Bluetooth access requested'),
            backgroundColor: Colors.blue,
            duration: const Duration(seconds: 2),
          ),
        );

        // Navigate to notifications page immediately even if there's an error
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const NotificationsPage()),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 40),

              // Title
              Text(
                'Smart Watch',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: const Color(0xFFDCFF00),
                  fontSize: 32,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700,
                  height: 1.32,
                ),
              ),

              const SizedBox(height: 40),

              // Description
              Text(
                'Allow your smart watch to access the data about health',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                  height: 1.50,
                ),
              ),

              // Spacer to push content to bottom
              const Spacer(),

              // Allow button
              GestureDetector(
                onTap: requestBluetoothPermission,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  decoration: ShapeDecoration(
                    color: const Color(0xFFDCFF00),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Text(
                    'Allow',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                      height: 1.50,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Skip for now
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const NotificationsPage()),
                  );
                },
                child: Text(
                  'Skip for now',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                    height: 1.50,
                  ),
                ),
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}