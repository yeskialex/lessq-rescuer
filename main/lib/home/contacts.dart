import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:permission_handler/permission_handler.dart';
import 'calling_amy.dart';
import 'calling_emergency.dart';

class ContactsPage extends StatefulWidget {
  const ContactsPage({super.key});

  @override
  State<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  List<String> emergencyContacts = [
    'Amy Adams',
    'John Atwood',
  ];

  Future<void> addNewContact() async {
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),

              // Title
              Center(
                child: Text(
                  'Contacts',
                  style: TextStyle(
                    color: const Color(0xFFDCFF00),
                    fontSize: 34,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700,
                    height: 1.32,
                  ),
                ),
              ),

              const SizedBox(height: 48),

              // Special numbers section
              Text(
                'Special numbers',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.75),
                  fontSize: 15,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                  height: 1.60,
                ),
              ),

              const SizedBox(height: 16),

              // Emergency number (119)
              GestureDetector(
                onTap: () {
                  // Navigate to calling page with black background
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CallingEmergencyPage(),
                    ),
                  );
                },
                child: Container(
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
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                              width: 1,
                              color: Color(0xFFF72D2D),
                            ),
                            borderRadius: BorderRadius.circular(17),
                          ),
                        ),
                        child: const Icon(
                          Icons.local_hospital,
                          color: Color(0xFFF72D2D),
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 19),
                      const Text(
                        '119',
                        style: TextStyle(
                          color: Color(0xFFF72D2D),
                          fontSize: 14,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                          height: 1.71,
                        ),
                      ),
                      const Spacer(),
                      const Icon(
                        Icons.phone,
                        color: Color(0xFFF72D2D),
                        size: 20,
                      ),
                      const SizedBox(width: 17),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 32),

              // Emergency contacts section
              Text(
                'Your emergency contacts',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.75),
                  fontSize: 15,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                  height: 1.60,
                ),
              ),

              const SizedBox(height: 16),

              // Emergency contacts list
              Expanded(
                child: ListView.builder(
                  itemCount: emergencyContacts.length,
                  itemBuilder: (context, index) {
                    String contactName = emergencyContacts[index];
                    String contactImage = contactName == 'Amy Adams'
                        ? 'assets/images/amy.png'
                        : 'assets/images/john.png';
                    String avatarImage = contactName == 'Amy Adams'
                        ? 'assets/images/amyavatar.png'
                        : 'assets/images/johnavatar2.png';

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: GestureDetector(
                        onTap: () {
                          // Navigate to calling page
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CallingAmyPage(
                                contactName: contactName,
                                contactImage: contactImage,
                                avatarImage: avatarImage,
                              ),
                            ),
                          );
                        },
                        child: Container(
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
                                decoration: const ShapeDecoration(
                                  color: Colors.black,
                                  shape: OvalBorder(),
                                ),
                                child: const Icon(
                                  Icons.person,
                                  color: Color(0xFFDCFF00),
                                  size: 20,
                                ),
                              ),
                              const SizedBox(width: 19),
                              Text(
                                contactName,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400,
                                  height: 1.71,
                                ),
                              ),
                              const Spacer(),
                              IconButton(
                                onPressed: () {
                                  // Navigate to calling page
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => CallingAmyPage(
                                        contactName: contactName,
                                        contactImage: contactImage,
                                        avatarImage: avatarImage,
                                      ),
                                    ),
                                  );
                                },
                                icon: const Icon(
                                  Icons.phone,
                                  color: Colors.black,
                                  size: 20,
                                ),
                              ),
                              const SizedBox(width: 8),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 100), // Space for bottom navigation
            ],
          ),
        ),
      ),
      floatingActionButton: Container(
        width: 54,
        height: 54,
        decoration: const ShapeDecoration(
          color: Color(0xFFDCFF00),
          shape: OvalBorder(),
        ),
        child: FloatingActionButton(
          onPressed: addNewContact,
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: const Icon(
            Icons.add,
            color: Colors.black,
            size: 24,
          ),
        ),
      ),
    );
  }
}