import 'package:flutter/material.dart';
import 'sos_clicked.dart';

class SosPage extends StatefulWidget {
  const SosPage({super.key});

  @override
  State<SosPage> createState() => _SosPageState();
}

class _SosPageState extends State<SosPage> {
  bool isPredefinedMessageEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              const SizedBox(height: 24),

              // Header with greeting and notification
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Hey!',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                          height: 1.57,
                        ),
                      ),
                      const Text(
                        'Kim Ha-Joon',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w700,
                          height: 1.40,
                        ),
                      ),
                    ],
                  ),
                  Stack(
                    children: [
                      const Icon(
                        Icons.notifications_outlined,
                        color: Colors.white,
                        size: 24,
                      ),
                      Positioned(
                        right: 0,
                        top: 0,
                        child: Container(
                          width: 10,
                          height: 10,
                          decoration: const BoxDecoration(
                            color: Color(0xFFF72D2D),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 120),

              // Help text
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22),
                child: Text.rich(
                  TextSpan(
                    children: [
                      const TextSpan(
                        text: 'Help is just a click away!\nClick ',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                          height: 1.14,
                        ),
                      ),
                      const TextSpan(
                        text: 'SOS button',
                        style: TextStyle(
                          color: Color(0xFFF72D2D),
                          fontSize: 14,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w700,
                          height: 1.14,
                        ),
                      ),
                      const TextSpan(
                        text: ' to call the help.',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                          height: 1.14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // SOS Button with concentric circles
              Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Outermost circle
                    Container(
                      width: 317,
                      height: 317,
                      decoration: const BoxDecoration(
                        color: Color(0x16FF7969),
                        shape: BoxShape.circle,
                      ),
                    ),
                    // Second circle
                    Container(
                      width: 293,
                      height: 293,
                      decoration: const BoxDecoration(
                        color: Color(0x99F72D2D),
                        shape: BoxShape.circle,
                      ),
                    ),
                    // Third circle
                    Container(
                      width: 267,
                      height: 267,
                      decoration: const BoxDecoration(
                        color: Color(0xA3F72D2D),
                        shape: BoxShape.circle,
                      ),
                    ),
                    // Inner SOS button
                    GestureDetector(
                      onTap: () {
                        // Navigate to SOS clicked page
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SosClickedPage(),
                          ),
                        );
                      },
                      child: Container(
                        width: 241,
                        height: 241,
                        decoration: const BoxDecoration(
                          color: Color(0xFFF72D2D),
                          shape: BoxShape.circle,
                        ),
                        child: const Center(
                          child: Text(
                            'SOS',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 36,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w700,
                              letterSpacing: -0.90,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40),

              // Pre-defined message toggle
              GestureDetector(
                onTap: () {
                  setState(() {
                    isPredefinedMessageEnabled = !isPredefinedMessageEnabled;
                  });
                },
                child: Container(
                  width: double.infinity,
                  height: 52,
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color(0xFFF72D2D),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Pre-defined message',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                            height: 1.17,
                          ),
                        ),
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          width: 44,
                          height: 24,
                          decoration: BoxDecoration(
                            color: isPredefinedMessageEnabled
                                ? const Color(0xFFF72D2D)
                                : const Color(0xFF666666),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: AnimatedAlign(
                            duration: const Duration(milliseconds: 200),
                            alignment: isPredefinedMessageEnabled
                                ? Alignment.centerRight
                                : Alignment.centerLeft,
                            child: Container(
                              width: 20,
                              height: 20,
                              margin: const EdgeInsets.symmetric(horizontal: 2),
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 100), // Space for bottom navigation
              ],
            ),
          ),
        ),
      ),
    );
  }
}