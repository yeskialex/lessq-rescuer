import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'chat.dart';
import 'contacts.dart';

class MissionSuccessPage extends StatelessWidget {
  const MissionSuccessPage({super.key});

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
                        // Eyes emoji
                        const Text(
                          '👀',
                          style: TextStyle(fontSize: 80),
                        ),
                        // Confetti GIF overlay
                        Image.asset(
                          'assets/confetti.gif',
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
                        'assets/leftwing.png',
                        width: 30,
                        height: 30,
                        color: Colors.white,
                        errorBuilder: (context, error, stackTrace) {
                          return const SizedBox(width: 30, height: 30);
                        },
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'NIGHTWATCH',
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
                        'assets/rightwing.png',
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
                      'Congratulations. The rescue was successful. Your performance has been recognized, and you have become a ranger of the LessQ team. Your sticker badge is now ready for collection.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                        height: 1.5,
                      ),
                    ),
                  ),

                  const SizedBox(height: 60),
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
              _buildNavItem(context, 0, 'Rescue', Icons.people, true),
              _buildNavItem(context, 1, 'Chat', Icons.chat_bubble_outline, false),
              _buildNavItem(context, 2, 'Contacts', Icons.contact_page_outlined, false),
              _buildNavItem(context, 3, 'Profile', Icons.person_outline, false),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, int index, String label, IconData icon, bool isSelected) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          if (index == 1) { // Chat tab
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ChatPage(),
              ),
            );
          } else if (index == 2) { // Contacts tab
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ContactsPage(),
              ),
            );
          }
          // Add other navigation cases here as needed
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isSelected ? const Color(0xFFDCFF00) : Colors.grey,
              size: 24,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontFamily: 'Poppins',
                color: isSelected ? const Color(0xFFDCFF00) : Colors.grey,
                fontSize: 12,
                fontWeight: FontWeight.w600,
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