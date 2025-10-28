import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileEditPage extends StatefulWidget {
  const ProfileEditPage({super.key});

  @override
  State<ProfileEditPage> createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  String selectedGender = 'Male'; // Pre-filled
  String selectedBloodType = 'A+'; // Pre-filled

  // Form field values - pre-filled with existing data
  String fullName = 'Kim Ha-Joon';
  String phoneNumber = '010-8204-3952';
  String email = 'kimhajoon@gmail.com';
  String age = '31';
  String residentNumber = '950115-1234567';
  String height = '175';
  String weight = '80';
  String diseases = 'None';
  String address = '217, Teheran-ro, Gangnam-gu';

  // Get the correct white icon path (handle diseases typo)
  String getWhiteIconPath(String grayIconPath) {
    String whitePath = grayIconPath.replaceAll('app_icons_gray', 'app_icons_white');
    // Handle the typo in diseases filename
    if (whitePath.contains('diseases.svg')) {
      whitePath = whitePath.replaceAll('diseases.svg', 'disesease.svg');
    }
    return whitePath;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 24),

              // Back button (left aligned)
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white, size: 28),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),

              const SizedBox(height: 0),

              // Profile picture with green background
              Container(
                width: 100,
                height: 100,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFDCFF00),
                ),
                padding: const EdgeInsets.all(8),
                child: Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage('assets/images/face.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Name in green
              const Text(
                'Kim Ha-Joon',
                style: TextStyle(
                  color: Color(0xFFDCFF00),
                  fontSize: 20,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 32),

              // Full Name Field
              _buildTappableInputField(
                'Full Name*',
                fullName,
                'assets/icons/app_icons_gray/fullname.svg',
                () {},
                true,
              ),
              const SizedBox(height: 16),

              // Phone Number Field
              _buildTappableInputField(
                'Phone number*',
                phoneNumber,
                'assets/icons/app_icons_gray/phonenumber.svg',
                () {},
                true,
              ),
              const SizedBox(height: 16),

              // Email Field
              _buildTappableInputField(
                'Email address*',
                email,
                'assets/icons/app_icons_gray/email.svg',
                () {},
                true,
              ),
              const SizedBox(height: 16),

              // Age Field
              _buildTappableInputFieldWithIcon(
                'Age*',
                age,
                Icons.cake,
                () {},
                true,
              ),
              const SizedBox(height: 16),

              // Gender Section
              _buildGenderSection(),
              const SizedBox(height: 16),

              // Resident Registration Number Field
              _buildTappableInputField(
                'Resident registration number*',
                residentNumber,
                'assets/icons/app_icons_gray/residentregisnumber.svg',
                () {},
                true,
              ),
              const SizedBox(height: 16),

              // Height Field
              _buildTappableInputFieldWithCustomIcon(
                'Your height',
                height,
                'assets/icons/app_icons_gray/height.svg',
                () {},
                true,
                iconWidth: 18,
                iconHeight: 18,
              ),
              const SizedBox(height: 16),

              // Weight Field
              _buildTappableInputField(
                'Your weight',
                weight,
                'assets/icons/app_icons_gray/weight.svg',
                () {},
                true,
              ),
              const SizedBox(height: 16),

              // Blood Type Section
              _buildBloodTypeSection(),
              const SizedBox(height: 16),

              // Diseases Field
              _buildTappableInputField(
                'Diseases',
                diseases,
                'assets/icons/app_icons_gray/diseases.svg',
                () {},
                true,
              ),
              const SizedBox(height: 16),

              // Address Field
              _buildTappableInputField(
                'Address',
                address,
                'assets/icons/app_icons_gray/address.svg',
                () {},
                true,
              ),
              const SizedBox(height: 40),

              // Save Button
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  decoration: ShapeDecoration(
                    color: const Color(0xFFDCFF00),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
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
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTappableInputField(String label, String text, String? iconPath, VoidCallback onTap, bool hasValue, {bool isItalic = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w400,
            height: 1.50,
          ),
        ),
        const SizedBox(height: 6),
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: ShapeDecoration(
              color: Colors.black,
              shape: RoundedRectangleBorder(
                side: const BorderSide(width: 1, color: Colors.white),
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: Row(
              children: [
                iconPath != null
                    ? SvgPicture.asset(
                        hasValue
                          ? getWhiteIconPath(iconPath)
                          : iconPath,
                        width: 24,
                        height: 24,
                        colorFilter: hasValue
                          ? null
                          : const ColorFilter.mode(
                              Color(0xFF464646),
                              BlendMode.srcIn,
                            ),
                      )
                    : Container(
                        width: 24,
                        height: 24,
                        decoration: const BoxDecoration(color: Color(0xFFD9D9D9)),
                      ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    text,
                    style: TextStyle(
                      color: hasValue ? Colors.white : const Color(0xFF464646),
                      fontSize: 16,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                      fontStyle: isItalic && !hasValue ? FontStyle.italic : FontStyle.normal,
                      height: 1.50,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTappableInputFieldWithIcon(String label, String text, IconData iconData, VoidCallback onTap, bool hasValue, {bool isItalic = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w400,
            height: 1.50,
          ),
        ),
        const SizedBox(height: 6),
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: ShapeDecoration(
              color: Colors.black,
              shape: RoundedRectangleBorder(
                side: const BorderSide(width: 1, color: Colors.white),
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  iconData,
                  size: 24,
                  color: hasValue ? Colors.white : const Color(0xFF464646),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    text,
                    style: TextStyle(
                      color: hasValue ? Colors.white : const Color(0xFF464646),
                      fontSize: 16,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                      fontStyle: isItalic && !hasValue ? FontStyle.italic : FontStyle.normal,
                      height: 1.50,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTappableInputFieldWithCustomIcon(String label, String text, String? iconPath, VoidCallback onTap, bool hasValue, {bool isItalic = false, double iconWidth = 24, double iconHeight = 24}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w400,
            height: 1.50,
          ),
        ),
        const SizedBox(height: 6),
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: ShapeDecoration(
              color: Colors.black,
              shape: RoundedRectangleBorder(
                side: const BorderSide(width: 1, color: Colors.white),
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: Row(
              children: [
                iconPath != null
                    ? SvgPicture.asset(
                        hasValue
                          ? getWhiteIconPath(iconPath)
                          : iconPath,
                        width: iconWidth,
                        height: iconHeight,
                        colorFilter: hasValue
                          ? null
                          : const ColorFilter.mode(
                              Color(0xFF464646),
                              BlendMode.srcIn,
                            ),
                      )
                    : Container(
                        width: iconWidth,
                        height: iconHeight,
                        decoration: const BoxDecoration(color: Color(0xFFD9D9D9)),
                      ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    text,
                    style: TextStyle(
                      color: hasValue ? Colors.white : const Color(0xFF464646),
                      fontSize: 16,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                      fontStyle: isItalic && !hasValue ? FontStyle.italic : FontStyle.normal,
                      height: 1.50,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGenderSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Gender',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w400,
            height: 1.50,
          ),
        ),
        const SizedBox(height: 6),
        Container(
          width: double.infinity,
          height: 52,
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              side: const BorderSide(width: 0.50, color: Colors.white),
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          child: Stack(
            children: [
              AnimatedPositioned(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                left: selectedGender == 'Male' ? 3 : (MediaQuery.of(context).size.width - 54) / 2 + 3,
                top: 3,
                child: Container(
                  width: (MediaQuery.of(context).size.width - 54) / 2,
                  height: 45,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFDCFF00),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 0,
                top: 0,
                right: 0,
                bottom: 0,
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedGender = 'Male';
                          });
                        },
                        child: Container(
                          height: double.infinity,
                          alignment: Alignment.center,
                          child: AnimatedDefaultTextStyle(
                            duration: const Duration(milliseconds: 300),
                            style: TextStyle(
                              color: selectedGender == 'Male' ? Colors.black : Colors.white,
                              fontSize: 16,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                              height: 1.50,
                            ),
                            child: const Text('Male'),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedGender = 'Female';
                          });
                        },
                        child: Container(
                          height: double.infinity,
                          alignment: Alignment.center,
                          child: AnimatedDefaultTextStyle(
                            duration: const Duration(milliseconds: 300),
                            style: TextStyle(
                              color: selectedGender == 'Female' ? Colors.black : Colors.white,
                              fontSize: 16,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                              height: 1.50,
                            ),
                            child: const Text('Female'),
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
      ],
    );
  }

  Widget _buildBloodTypeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Blood Type',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w400,
            height: 1.50,
          ),
        ),
        const SizedBox(height: 6),
        Column(
          children: [
            Row(
              children: [
                _buildBloodTypeButton('A+'),
                const SizedBox(width: 21),
                _buildBloodTypeButton('O+'),
                const SizedBox(width: 21),
                _buildBloodTypeButton('B+'),
                const SizedBox(width: 21),
                _buildBloodTypeButton('AB+'),
              ],
            ),
            const SizedBox(height: 14),
            Row(
              children: [
                _buildBloodTypeButton('A-'),
                const SizedBox(width: 21),
                _buildBloodTypeButton('O-'),
                const SizedBox(width: 21),
                _buildBloodTypeButton('B-'),
                const SizedBox(width: 21),
                _buildBloodTypeButton('AB-'),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildBloodTypeButton(String bloodType) {
    bool isSelected = selectedBloodType == bloodType;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedBloodType = bloodType;
          });
        },
        child: Container(
          height: 49,
          decoration: ShapeDecoration(
            color: isSelected ? const Color(0xFFDCFF00) : Colors.transparent,
            shape: RoundedRectangleBorder(
              side: const BorderSide(width: 1, color: Colors.white),
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          child: Center(
            child: Text(
              bloodType,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: isSelected ? Colors.black : Colors.white,
                fontSize: 18,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
                height: 1.33,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
