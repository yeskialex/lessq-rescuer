import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'locations.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  Future<void> requestNotificationPermission() async {
    try {
      final status = await Permission.notification.request();
      debugPrint('Notification permission status: $status');

      if (!mounted) return;

      String message;
      Color backgroundColor;

      if (status.isGranted) {
        message = 'Notifications enabled! You\'ll receive emergency alerts.';
        backgroundColor = Colors.green;
      } else if (status.isDenied) {
        message = 'Notifications denied. You may miss important alerts.';
        backgroundColor = Colors.orange;
      } else if (status.isPermanentlyDenied) {
        message = 'Notifications permanently denied. Enable in Settings > Notifications';
        backgroundColor = Colors.red;
      } else {
        message = 'Notification permission status: $status';
        backgroundColor = Colors.blue;
      }

      // Navigate to locations page immediately after permission response
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const LocationsPage()),
      );
    } catch (e) {
      debugPrint('Error requesting notification permission: $e');
      if (mounted) {
        // Navigate to locations page even if there's an error
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const LocationsPage()),
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
                'Notifications',
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
                'Allow to send you notifications',
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
                onTap: requestNotificationPermission,
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
                    MaterialPageRoute(builder: (context) => const LocationsPage()),
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