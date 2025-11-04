import 'package:flutter/material.dart';
import 'chat.dart';
import 'contacts.dart';

class TrackingPage extends StatelessWidget {
  const TrackingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            // Back button
            Padding(
              padding: const EdgeInsets.only(left: 16.0, top: 16.0, right: 16.0, bottom: 16.0),
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
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: [
                    // Top info card
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        border: Border.all(
                          color: const Color(0xFFDCFF00),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Row(
                        children: [
                          // Profile image placeholder with text overlay
                          Stack(
                            children: [
                              Container(
                                width: 104,
                                height: 137,
                                decoration: const BoxDecoration(
                                  color: Color(0xFF7F7F7F),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(18),
                                    bottomLeft: Radius.circular(18),
                                  ),
                                ),
                              ),
                              // Name and time positioned over the grey area
                              Positioned(
                                left: 12,
                                top: 12,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Hajoon Lee',
                                      style: TextStyle(
                                        color: Color(0xFFDCFF00),
                                        fontSize: 14,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    const Text(
                                      '28 min ago',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 11,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          // Info section
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  // Info details
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      // Labels
                                      const Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Hiker ID',
                                            style: TextStyle(
                                              color: Color(0xFF7F7F7F),
                                              fontSize: 12,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w600,
                                              height: 2,
                                            ),
                                          ),
                                          Text(
                                            'Report time',
                                            style: TextStyle(
                                              color: Color(0xFF7F7F7F),
                                              fontSize: 12,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w600,
                                              height: 2,
                                            ),
                                          ),
                                          Text(
                                            'Condition',
                                            style: TextStyle(
                                              color: Color(0xFF7F7F7F),
                                              fontSize: 12,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w600,
                                              height: 2,
                                            ),
                                          ),
                                          Text(
                                            'Report type',
                                            style: TextStyle(
                                              color: Color(0xFF7F7F7F),
                                              fontSize: 12,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w600,
                                              height: 2,
                                            ),
                                          ),
                                        ],
                                      ),

                                      const SizedBox(width: 16),

                                      // Values
                                      const Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'HK-2024-1547',
                                              style: TextStyle(
                                                color: Color(0xFFDCFF00),
                                                fontSize: 12,
                                                fontFamily: 'Poppins',
                                                fontWeight: FontWeight.w600,
                                                height: 2,
                                              ),
                                            ),
                                            Text(
                                              '14:23 KST',
                                              style: TextStyle(
                                                color: Color(0xFFDCFF00),
                                                fontSize: 12,
                                                fontFamily: 'Poppins',
                                                fontWeight: FontWeight.w600,
                                                height: 2,
                                              ),
                                            ),
                                            Text(
                                              'CRITICAL',
                                              style: TextStyle(
                                                color: Color(0xFFF72D2D),
                                                fontSize: 12,
                                                fontFamily: 'Poppins',
                                                fontWeight: FontWeight.w600,
                                                height: 2,
                                              ),
                                            ),
                                            Text(
                                              'Fall injury',
                                              style: TextStyle(
                                                color: Color(0xFFDCFF00),
                                                fontSize: 12,
                                                fontFamily: 'Poppins',
                                                fontWeight: FontWeight.w600,
                                                height: 2,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Map section using SVG
                    Container(
                      width: double.infinity,
                      height: 350, // Fixed height for the map
                      decoration: BoxDecoration(
                        color: const Color(0xFF7F7F7F),
                        borderRadius: BorderRadius.circular(37),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(37),
                        child: Image.asset(
                          'assets/rescuehike.png',
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Golden Hour progress
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: const Color(0xFF464646),
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Column(
                        children: [
                          const Text(
                            'Golden Hour',
                            style: TextStyle(
                              color: Color(0xFFA4A4A4),
                              fontSize: 14,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                '48min',
                                style: TextStyle(
                                  color: Color(0xFFF72D2D),
                                  fontSize: 14,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const Text(
                                'remaining',
                                style: TextStyle(
                                  color: Color(0xFFA4A4A4),
                                  fontSize: 14,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          // Progress bar
                          Container(
                            width: double.infinity,
                            height: 6,
                            decoration: BoxDecoration(
                              color: const Color(0xFFA4A4A4),
                              borderRadius: BorderRadius.circular(3),
                            ),
                            child: FractionallySizedBox(
                              alignment: Alignment.centerLeft,
                              widthFactor: 0.6, // 48min remaining out of ~80min total
                              child: Container(
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF72D2D),
                                  borderRadius: BorderRadius.circular(3),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),
                    ],
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