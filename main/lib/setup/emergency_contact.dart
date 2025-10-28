import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:contacts_service/contacts_service.dart';
import 'predefined_message.dart';

class EmergencyContactPage extends StatefulWidget {
  const EmergencyContactPage({super.key});

  @override
  State<EmergencyContactPage> createState() => _EmergencyContactPageState();
}

class _EmergencyContactPageState extends State<EmergencyContactPage> {
  List<String> emergencyContacts = [];
  final ScrollController _scrollController = ScrollController();
  bool _showScrollIndicator = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    setState(() {
      _showScrollIndicator = true;
    });

    // Hide scroll indicator after scrolling stops
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _showScrollIndicator = false;
        });
      }
    });
  }

  Future<void> pickContact() async {
    try {
      final permissionStatus = await Permission.contacts.request();

      if (permissionStatus.isGranted) {
        final Contact? contact = await ContactsService.openDeviceContactPicker();

        if (!mounted) return;

        if (contact != null && contact.displayName != null) {
          // Check if contact already exists
          if (!emergencyContacts.contains(contact.displayName!)) {
            setState(() {
              emergencyContacts.add(contact.displayName!);
            });
            debugPrint('Selected contact: ${contact.displayName}');
          } else {
            debugPrint('Contact already exists: ${contact.displayName}');
          }
        }
      }
    } catch (e) {
      debugPrint('Error picking contact: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 40),

              // Title
              Text(
                'Emergency contact',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: const Color(0xFFDCFF00),
                  fontSize: 32,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700,
                  height: 1.32,
                ),
              ),

              const SizedBox(height: 32),

              // Subtitle
              Text(
                emergencyContacts.isEmpty ? 'Select your emergency contact' : 'Confirm your contact(s)?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.75),
                  fontSize: 16,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                  height: 1.50,
                ),
              ),

              const SizedBox(height: 32),

              // Emergency contacts list (scrollable)
              Expanded(
                child: emergencyContacts.isEmpty
                    ? const SizedBox.shrink()
                    : Stack(
                        children: [
                          ListView.builder(
                            controller: _scrollController,
                            itemCount: emergencyContacts.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 16),
                                child: Container(
                                  width: double.infinity,
                                  height: 57,
                                  decoration: ShapeDecoration(
                                    color: const Color(0xFFDCFF00),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 37.51,
                                        height: 37.51,
                                        margin: const EdgeInsets.only(left: 16),
                                        decoration: const ShapeDecoration(
                                          color: Colors.black,
                                          shape: OvalBorder(),
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      Expanded(
                                        child: Text(
                                          emergencyContacts[index],
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w400,
                                            height: 1.50,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                          // List indicator (scrollbar) - only shows when scrolling
                          if (_showScrollIndicator && emergencyContacts.length > 3)
                            Positioned(
                              right: -5,
                              top: 0,
                              bottom: 16,
                              child: AnimatedOpacity(
                                opacity: _showScrollIndicator ? 1.0 : 0.0,
                                duration: const Duration(milliseconds: 300),
                                child: Container(
                                  width: 6,
                                  decoration: BoxDecoration(
                                    color: Colors.white.withValues(alpha: 0.8),
                                    borderRadius: BorderRadius.circular(3),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
              ),

              // Add new contact button
              GestureDetector(
                onTap: pickContact,
                child: Container(
                  width: double.infinity,
                  height: 57,
                  decoration: ShapeDecoration(
                    color: const Color(0xFF464646),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 60),
                          child: Text(
                            'Add new contact?',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.75),
                              fontSize: 16,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                              height: 1.50,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 37.51,
                        height: 37.51,
                        margin: const EdgeInsets.only(right: 16),
                        decoration: const ShapeDecoration(
                          color: Color(0xFFDCFF00),
                          shape: OvalBorder(),
                        ),
                        child: const Icon(
                          Icons.add,
                          color: Colors.black,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 40),

              // Save button
              GestureDetector(
                onTap: emergencyContacts.isNotEmpty ? () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const PredefinedMessagePage()),
                  );
                } : null,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  decoration: ShapeDecoration(
                    color: emergencyContacts.isNotEmpty ? const Color(0xFFDCFF00) : const Color(0xFF888888),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Text(
                    'Save',
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

              const SizedBox(height: 24),

              // Skip for now
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const PredefinedMessagePage()),
                  );
                },
                child: Text(
                  'Skip for now',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                    height: 1.50,
                  ),
                ),
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}