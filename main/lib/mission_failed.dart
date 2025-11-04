import 'package:flutter/material.dart';
import 'chat.dart';
import 'contacts.dart';

class MissionFailedPage extends StatelessWidget {
  const MissionFailedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF464646),
      appBar: AppBar(
        backgroundColor: const Color(0xFF464646),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Crying emoji
            const Text(
              '😢',
              style: TextStyle(fontSize: 120),
            ),
            const SizedBox(height: 40),
            // Mission Failed title
            const Text(
              'MISSION FAILED',
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            ),
            const SizedBox(height: 32),
            // Description text
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                'The golden hour has passed. This is the difficult reality for real rescuers. We hope this experience helps you understand the immense pressure they face and why our LessQ service is so vital in the real world. Thank you for playing.',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
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