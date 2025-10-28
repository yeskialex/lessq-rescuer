import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'hike_active.dart';
import 'bottom_navigation.dart';
import '../services/native_alert_service.dart';

class HikeConfirmPage extends StatefulWidget {
  final String trailTitle;
  final String distance;
  final String time;
  final String difficulty;

  const HikeConfirmPage({
    super.key,
    required this.trailTitle,
    required this.distance,
    required this.time,
    required this.difficulty,
  });

  @override
  State<HikeConfirmPage> createState() => _HikeConfirmPageState();
}

class _HikeConfirmPageState extends State<HikeConfirmPage> {
  Future<void> _showDownloadConfirmation() async {
    final result = await NativeAlertService.showWarningAlert(
      title: 'Download image to gallery?',
      message: '',
      pauseButtonText: 'Yes',
      cancelButtonText: 'Cancel',
    );

    if (result == 'pause') {
      _showDownloadSuccess();
    }
  }

  Future<void> _showDownloadSuccess() async {
    await NativeAlertService.showWarningAlert(
      title: 'Downloaded',
      message: '',
      pauseButtonText: 'Start Hiking',
      cancelButtonText: 'Close',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 20),

                          // Greeting text
                          const Text(
                            'Kim Ha-Joon,\nare you ready to start the hike?',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w700,
                              height: 1.41,
                            ),
                          ),
                          const SizedBox(height: 20),

                          // Large title
                          const Text(
                            'Let\'s start the hike!',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFFDCFF00),
                              fontSize: 34,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w700,
                              height: 1.32,
                            ),
                          ),
                          const SizedBox(height: 24),
                        ],
                      ),
                    ),

                    // Trail map (full width, no padding)
                    SizedBox(
                      width: double.infinity,
                      height: 464,
                      child: Stack(
                        children: [
                          // Trail map SVG
                          Center(
                            child: SvgPicture.asset(
                              'assets/images/map.svg',
                              width: double.infinity,
                              height: 464,
                              fit: BoxFit.contain,
                            ),
                          ),

                          // Download button (bottom right)
                          Positioned(
                            right: 50,
                            bottom: 16,
                            child: GestureDetector(
                              onTap: _showDownloadConfirmation,
                              child: Container(
                                width: 46,
                                height: 46,
                                decoration: const ShapeDecoration(
                                  color: Colors.black,
                                  shape: OvalBorder(),
                                ),
                                child: const Icon(
                                  Icons.download,
                                  color: Colors.white,
                                  size: 24,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),

            // Bottom Start button
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HikeActivePage(
                        trailTitle: widget.trailTitle,
                        totalDistance: widget.distance,
                        estimatedTime: widget.time,
                      ),
                    ),
                  );
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  decoration: ShapeDecoration(
                    color: const Color(0xFFDCFF00),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    'Start',
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
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 88,
        decoration: const BoxDecoration(
          color: Colors.black,
        ),
        child: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(child: _buildNavItem(context, 0, 'Hike', Icons.hiking)),
              Expanded(child: _buildNavItem(context, 1, 'SOS', Icons.emergency)),
              Expanded(child: _buildNavItem(context, 2, 'Contacts', Icons.contacts)),
              Expanded(child: _buildNavItem(context, 3, 'Profile', Icons.person)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, int index, String label, IconData icon) {
    final bool isSelected = index == 0; // Hike is selected on this page

    return GestureDetector(
      onTap: () {
        if (!isSelected) {
          // Navigate to the respective page without animation
          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                HomeBottomNavigation(currentIndex: index),
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
