import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'bottom_navigation.dart';

class HikeAwards extends StatelessWidget {
  const HikeAwards({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF464646),
      body: SafeArea(
        child: Column(
          children: [
            // Back button
            Padding(
              padding: const EdgeInsets.only(left: 16.0, top: 16.0, right: 16.0, bottom: 0.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white, size: 28),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ),

            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // Award illustration with confetti and rays
                  SizedBox(
                    height: 300,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // Gray rays background
                        CustomPaint(
                          size: const Size(300, 300),
                          painter: RaysPainter(),
                        ),
                        // Cheetah/Award illustration
                        Container(
                          width: 180,
                          height: 180,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/elements.png'),
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        // Confetti GIF overlay
                        Image.asset(
                          'assets/images/confetti.gif',
                          width: 600,
                          height: 600,
                          fit: BoxFit.contain,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Award title with wings
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/icons/leftwing.png',
                        width: 30,
                        height: 30,
                        color: Colors.white,
                        errorBuilder: (context, error, stackTrace) {
                          return const SizedBox(width: 30, height: 30);
                        },
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'NEW RECORD',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.2,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Image.asset(
                        'assets/icons/rightwing.png',
                        width: 30,
                        height: 30,
                        color: Colors.white,
                        errorBuilder: (context, error, stackTrace) {
                          return const SizedBox(width: 30, height: 30);
                        },
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Description text
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    child: Text(
                      'You\'ve set a new record!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                        height: 1.5,
                      ),
                    ),
                  ),

                  const SizedBox(height: 60),

                  // Share button
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 100),
                    child: SizedBox(
                      width: double.infinity,
                      height: 45,
                      child: ElevatedButton(
                        onPressed: () {
                          // Handle share action
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFDCFF00),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 0,
                        ),
                        child: const Text(
                          'Share',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
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
              Expanded(child: _buildNavItem(context, 0, 'Hike', Icons.hiking, true)),
              Expanded(child: _buildNavItem(context, 1, 'SOS', Icons.emergency, false)),
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

// Custom painter for the gray rays background
class RaysPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    const numRays = 16;
    const rayLength = 150.0;

    for (int i = 0; i < numRays; i++) {
      final angle = (i * 2 * math.pi) / numRays;
      final path = Path();
      path.moveTo(center.dx, center.dy);

      // Calculate the two outer points of the ray triangle
      final angle1 = angle - 0.1;
      final angle2 = angle + 0.1;

      final outerPoint1 = Offset(
        center.dx + rayLength * math.cos(angle1),
        center.dy + rayLength * math.sin(angle1),
      );
      final outerPoint2 = Offset(
        center.dx + rayLength * math.cos(angle2),
        center.dy + rayLength * math.sin(angle2),
      );

      path.lineTo(outerPoint1.dx, outerPoint1.dy);
      path.lineTo(outerPoint2.dx, outerPoint2.dy);
      path.close();

      // Create gradient shader from center (bright) to edge (transparent)
      final paint = Paint()
        ..shader = RadialGradient(
          center: Alignment.center,
          radius: 0.5,
          colors: [
            const Color(0xFFD0D0D0), // Very bright gray in center
            const Color(0xFF9A9A9A).withOpacity(0.7), // Mid opacity
            const Color(0xFF5A5A5A).withOpacity(0.0), // Transparent at edges
          ],
          stops: const [0.0, 0.5, 1.0],
        ).createShader(Rect.fromCenter(
          center: center,
          width: rayLength * 2,
          height: rayLength * 2,
        ))
        ..style = PaintingStyle.fill;

      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
