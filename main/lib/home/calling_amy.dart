import 'package:flutter/material.dart';

class CallingAmyPage extends StatelessWidget {
  final String contactName;
  final String contactImage;
  final String avatarImage;

  const CallingAmyPage({
    super.key,
    required this.contactName,
    required this.contactImage,
    required this.avatarImage,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Background image (full screen)
          Positioned.fill(
            child: Image.asset(
              contactImage,
              fit: BoxFit.cover,
            ),
          ),

          // Dark overlay
          Positioned.fill(
            child: Container(
              color: Colors.black.withValues(alpha: 0.3),
            ),
          ),

          // Content
          Column(
            children: [
              SafeArea(
                child: Column(
                  children: [
                    const SizedBox(height: 60),

                    // Profile picture and name at top
                    Padding(
                      padding: const EdgeInsets.only(left: 24),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          // Small circular profile picture
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 2),
                              image: DecorationImage(
                                image: AssetImage(avatarImage),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),

                          // Name and status
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                contactName,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 28,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const Text(
                                'connecting...',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 16,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const Spacer(),

              // Bottom controls with opaque background
              Container(
                width: double.infinity,
                padding: const EdgeInsets.only(top: 30, left: 20, right: 20, bottom: 50),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.5),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Mute button
                    _buildCallButton(
                      icon: Icons.mic_off,
                      onTap: () {},
                    ),

                    // Video off button
                    _buildCallButton(
                      icon: Icons.videocam_off,
                      onTap: () {},
                    ),

                    // Camera flip button
                    _buildCallButton(
                      icon: Icons.cameraswitch,
                      onTap: () {},
                    ),

                    // End call button (red)
                    _buildCallButton(
                      icon: Icons.call_end,
                      onTap: () {
                        Navigator.pop(context);
                      },
                      backgroundColor: const Color(0xFFF72D2D),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCallButton({
    required IconData icon,
    required VoidCallback onTap,
    Color backgroundColor = const Color(0xFF464646),
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: backgroundColor,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: Colors.white,
          size: 28,
        ),
      ),
    );
  }
}
