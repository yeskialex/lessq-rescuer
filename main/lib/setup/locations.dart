import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'welcome.dart';

class LocationsPage extends StatefulWidget {
  const LocationsPage({super.key});

  @override
  State<LocationsPage> createState() => _LocationsPageState();
}

class _LocationsPageState extends State<LocationsPage> {
  Future<void> requestLocationPermission() async {
    try {
      // Request multiple location permissions to ensure iOS dialog appears
      await [
        Permission.location,
        Permission.locationWhenInUse,
        Permission.locationAlways,
      ].request();

      // Check the main location permission status
      final status = await Permission.location.status;
      debugPrint('Location permission status: $status');

      if (!mounted) return;

      // Navigate to welcome page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const WelcomePage()),
      );
    } catch (e) {
      debugPrint('Error requesting location permission: $e');
      if (mounted) {
        // Navigate to welcome page even if there's an error
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const WelcomePage()),
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
                'Location',
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
                'Allow to access the GPS location',
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
                onTap: requestLocationPermission,
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
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const WelcomePage()),
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