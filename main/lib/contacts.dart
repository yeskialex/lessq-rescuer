import 'package:flutter/material.dart';

class ContactsPage extends StatelessWidget {
  const ContactsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Contacts',
          style: TextStyle(
            color: Color(0xFFDCFF00),
            fontSize: 34,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),

            // Special numbers section
            Text(
              'Special numbers',
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.75),
                fontSize: 15,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 15),

            // Emergency contacts
            _buildEmergencyContact('119', Icons.local_hospital),
            const SizedBox(height: 16),
            _buildEmergencyContact('Fire', Icons.local_fire_department),
            const SizedBox(height: 16),
            _buildEmergencyContact('Mountain Ranger', Icons.terrain),

            const SizedBox(height: 40),

            // Hiker in need section
            Text(
              'Hiker in need',
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.75),
                fontSize: 15,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 15),

            // Amy Adams contact
            _buildHikerContact('Amy Adams'),
          ],
        ),
      ),
    );
  }

  Widget _buildEmergencyContact(String title, IconData icon) {
    return Container(
      width: double.infinity,
      height: 52,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            width: 1,
            color: Color(0xFFF72D2D),
          ),
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      child: Row(
        children: [
          const SizedBox(width: 17),
          Container(
            width: 34,
            height: 34,
            decoration: ShapeDecoration(
              color: const Color(0xFF464646),
              shape: OvalBorder(
                side: const BorderSide(
                  width: 1,
                  color: Color(0xFFF72D2D),
                ),
              ),
            ),
            child: Icon(
              icon,
              color: const Color(0xFFF72D2D),
              size: 20,
            ),
          ),
          const SizedBox(width: 19),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                color: Color(0xFFF72D2D),
                fontSize: 14,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              // Handle call action
            },
            icon: const Icon(
              Icons.call,
              color: Color(0xFFF72D2D),
              size: 24,
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
    );
  }

  Widget _buildHikerContact(String name) {
    return Container(
      width: double.infinity,
      height: 52,
      decoration: ShapeDecoration(
        color: const Color(0xFFDCFF00),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      child: Row(
        children: [
          const SizedBox(width: 17),
          Container(
            width: 34,
            height: 34,
            decoration: ShapeDecoration(
              color: Colors.grey[300],
              shape: const OvalBorder(
                side: BorderSide(
                  width: 1,
                  color: Color(0xFF464646),
                ),
              ),
            ),
            child: ClipOval(
              child: Container(
                color: Colors.grey[400],
                child: const Icon(
                  Icons.person,
                  color: Colors.grey,
                  size: 20,
                ),
              ),
            ),
          ),
          const SizedBox(width: 19),
          Expanded(
            child: Text(
              name,
              style: const TextStyle(
                color: Color(0xFF464646),
                fontSize: 14,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              // Handle call action
            },
            icon: const Icon(
              Icons.call,
              color: Color(0xFF464646),
              size: 24,
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
    );
  }
}