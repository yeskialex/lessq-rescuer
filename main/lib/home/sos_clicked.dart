import 'package:flutter/material.dart';
import 'package:main/home/calling_emergency.dart';
import '../services/native_alert_service.dart';
import 'bottom_navigation.dart';

class SosClickedPage extends StatefulWidget {
  const SosClickedPage({super.key});

  @override
  State<SosClickedPage> createState() => _SosClickedPageState();
}

class _SosClickedPageState extends State<SosClickedPage> {
  @override
  void initState() {
    super.initState();
    // Show the alert after the page is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showAccidentReport();
    });
  }

  Future<void> _showAccidentReport() async {
    final result = await NativeAlertService.showActionSheet(
      title: 'Accident report',
      message: 'You reported an accident.\nPlease confirm your status.\nOnly select \'Urgent Help Needed\' if immediate assistance is critical.',
      buttons: [
        'Urgent Help Needed',
        'Not Urgent Case',
      ],
      cancelButtonText: 'Cancel',
    );

    if (mounted) {
      if (result == '0') {
        // User selected Urgent Help Needed (first button)
        // Navigate back to SOS tab or handle urgent case
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const CallingEmergencyPage(),
          ),
        );
      } else if (result == '1') {
        // User selected Not Urgent Case (second button)
        // Navigate back to SOS tab
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const CallingEmergencyPage(),
          ),
        );
      } else if (result == 'cancel') {
        // User cancelled
        // Navigate back to SOS tab
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeBottomNavigation(currentIndex: 1),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF72D2D), // Full red background
      body: const SizedBox.expand(), // Expands to fill the entire screen
      bottomNavigationBar: Container(
        height: 88,
        decoration: const BoxDecoration(
          color: Colors.black,
        ),
        child: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(child: _buildNavItem(context, 0, 'Hike', Icons.hiking, false)),
              Expanded(child: _buildNavItem(context, 1, 'SOS', Icons.emergency, true)),
              Expanded(child: _buildNavItem(context, 2, 'Contacts', Icons.contacts, false)),
              Expanded(child: _buildNavItem(context, 3, 'Profile', Icons.person, false)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, int index, String label, IconData icon, bool isSelected) {
    return GestureDetector(
      onTap: () {
        if (!isSelected) {
          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) => HomeBottomNavigation(currentIndex: index),
              transitionDuration: Duration.zero,
              reverseTransitionDuration: Duration.zero,
            ),
          );
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isSelected ? const Color(0xFFDCFF00) : Colors.grey,
              size: 20,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? const Color(0xFFDCFF00) : Colors.grey,
                fontSize: 10,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
