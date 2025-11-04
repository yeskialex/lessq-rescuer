import 'package:flutter/material.dart';
import 'chat.dart';
import 'contacts.dart';
import 'tracking.dart';

class RescuePage extends StatefulWidget {
  const RescuePage({super.key});

  @override
  State<RescuePage> createState() => _RescuePageState();
}

class _RescuePageState extends State<RescuePage> {
  bool isCardSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              // Location indicator
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: const Color(0xFFDCFF00),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.location_on, color: Colors.black, size: 18),
                        SizedBox(width: 8),
                        Text(
                          'Seoul',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 40),

              // Emergency contact card
              GestureDetector(
                onTap: () {
                  setState(() {
                    isCardSelected = !isCardSelected;
                  });
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: isCardSelected ? const Color(0xFFDCFF00) : const Color(0xFF8A8A8A),
                    borderRadius: BorderRadius.circular(20),
                  ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.access_time,
                              color: Colors.black,
                              size: 16,
                            ),
                            const SizedBox(width: 6),
                            const Text(
                              '12 min ago',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        const Icon(
                          Icons.arrow_forward,
                          color: Colors.black,
                          size: 20,
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    const Text(
                      'Hajoon Lee',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const SizedBox(height: 16),

                    const Align(
                      alignment: Alignment.bottomRight,
                      child: Text(
                        '37.667, 127.3996',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    ],
                  ),
                ),
              ),

              const Spacer(),

              // Track button
              Container(
                width: double.infinity,
                height: 48,
                margin: const EdgeInsets.only(bottom: 20),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const TrackingPage(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isCardSelected ? const Color(0xFFDCFF00) : const Color(0xFF8A8A8A),
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Track',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
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
              _buildNavItem(0, 'Rescue', Icons.people, true),
              _buildNavItem(1, 'Chat', Icons.chat_bubble_outline, false),
              _buildNavItem(2, 'Contacts', Icons.contact_page_outlined, false),
              _buildNavItem(3, 'Profile', Icons.person_outline, false),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, String label, IconData icon, bool isSelected) {
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