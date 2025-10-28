import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../setup/emergency_contact.dart';
import 'sign_in.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String selectedGender = 'Male'; // Default selection
  String selectedBloodType = ''; // Blood type selection

  // Form field values
  String fullName = '';
  String phoneNumber = '';
  String email = '';
  String age = '';
  String residentNumber = '';
  String height = '';
  String weight = '';
  String diseases = '';
  String address = '';

  // Generate dummy data for each field
  void generateFullName() {
    setState(() {
      fullName = 'Kim Ha-Joon';
    });
  }

  void generatePhoneNumber() {
    setState(() {
      phoneNumber = '010-8204-3952';
    });
  }

  void generateEmail() {
    setState(() {
      email = 'kimhajoon@gmail.com';
    });
  }

  void generateAge() {
    setState(() {
      age = '31';
    });
  }

  void generateResidentNumber() {
    setState(() {
      residentNumber = '950115-1234567';
    });
  }

  void generateHeight() {
    setState(() {
      height = '175 cm';
    });
  }

  void generateWeight() {
    setState(() {
      weight = '80 kg';
    });
  }

  void generateDiseases() {
    setState(() {
      diseases = 'None';
    });
  }

  void generateAddress() {
    setState(() {
      address = '217, Teheran-ro, Gangnam-gu';
    });
  }

  // Get the correct white icon path (handle diseases typo)
  String getWhiteIconPath(String grayIconPath) {
    String whitePath = grayIconPath.replaceAll('app_icons_gray', 'app_icons_white');
    // Handle the typo in diseases filename
    if (whitePath.contains('diseases.svg')) {
      whitePath = whitePath.replaceAll('diseases.svg', 'disesease.svg');
    }
    return whitePath;
  }

  // Check if all fields are completed
  bool get isFormComplete {
    return fullName.isNotEmpty &&
           phoneNumber.isNotEmpty &&
           email.isNotEmpty &&
           age.isNotEmpty &&
           residentNumber.isNotEmpty &&
           height.isNotEmpty &&
           weight.isNotEmpty &&
           diseases.isNotEmpty &&
           address.isNotEmpty &&
           selectedBloodType.isNotEmpty;
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
              // Already have an account section
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account?  ',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.6),
                      fontSize: 16,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const SignInPage()),
                      );
                    },
                    child: Text(
                      'Log in',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              Text(
                'Profile',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 34,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700,
                  height: 1.53,
                ),
              ),
              const SizedBox(height: 32),
              Text(
                'Please enter your information to create your account',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                  height: 1.50,
                ),
              ),
              const SizedBox(height: 40),

              // Full Name Field
              _buildTappableInputField(
                'Full Name*',
                fullName.isEmpty ? 'Your name' : fullName,
                'assets/icons/app_icons_gray/fullname.svg',
                generateFullName,
                fullName.isNotEmpty,
              ),
              const SizedBox(height: 16),

              // Phone Number Field
              _buildTappableInputField(
                'Phone number*',
                phoneNumber.isEmpty ? '010-1234-1234' : phoneNumber,
                'assets/icons/app_icons_gray/phonenumber.svg',
                generatePhoneNumber,
                phoneNumber.isNotEmpty,
                isItalic: true,
              ),
              const SizedBox(height: 16),

              // Email Field
              _buildTappableInputField(
                'Email address*',
                email.isEmpty ? '@email.com' : email,
                'assets/icons/app_icons_gray/email.svg',
                generateEmail,
                email.isNotEmpty,
              ),
              const SizedBox(height: 16),

              // Age Field
              _buildTappableInputFieldWithIcon(
                'Age*',
                age.isEmpty ? 'Your age' : age,
                Icons.cake,
                generateAge,
                age.isNotEmpty,
              ),
              const SizedBox(height: 16),

              // Gender Section
              _buildGenderSection(),
              const SizedBox(height: 16),

              // Resident Registration Number Field
              _buildTappableInputField(
                'Resident registration number*',
                residentNumber.isEmpty ? 'Your number' : residentNumber,
                'assets/icons/app_icons_gray/residentregisnumber.svg',
                generateResidentNumber,
                residentNumber.isNotEmpty,
              ),
              const SizedBox(height: 16),

              // Height Field
              _buildTappableInputFieldWithCustomIcon(
                'Your height',
                height.isEmpty ? 'Your height' : height,
                'assets/icons/app_icons_gray/height.svg',
                generateHeight,
                height.isNotEmpty,
                iconWidth: 18,
                iconHeight: 18,
              ),
              const SizedBox(height: 16),

              // Weight Field
              _buildTappableInputField(
                'Your weight',
                weight.isEmpty ? 'Your weight' : weight,
                'assets/icons/app_icons_gray/weight.svg',
                generateWeight,
                weight.isNotEmpty,
              ),
              const SizedBox(height: 16),

              // Blood Type Section
              _buildBloodTypeSection(),
              const SizedBox(height: 16),

              // Diseases Field
              _buildTappableInputField(
                'Diseases',
                diseases.isEmpty ? 'eg. Cardiomyopathy' : diseases,
                'assets/icons/app_icons_gray/diseases.svg',
                generateDiseases,
                diseases.isNotEmpty,
              ),
              const SizedBox(height: 16),

              // Address Field
              _buildTappableInputField(
                'Address',
                address.isEmpty ? 'eg. 32, Teheran-ro, Gangnam-gu ' : address,
                'assets/icons/app_icons_gray/address.svg',
                generateAddress,
                address.isNotEmpty,
              ),
              const SizedBox(height: 40),

              // Continue Button
              GestureDetector(
                onTap: isFormComplete ? () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const EmergencyContactPage()),
                  );
                } : null,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  decoration: ShapeDecoration(
                    color: isFormComplete ? const Color(0xFFDCFF00) : const Color(0xFF464646),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Text(
                    'Continue',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: isFormComplete ? Colors.black : Colors.white,
                      fontSize: 16,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                      height: 1.50,
                    ),
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

  Widget _buildInputField(String label, String placeholder, String? iconPath, {bool isItalic = false}) {
    return _buildInputFieldWithCustomIcon(label, placeholder, iconPath, isItalic: isItalic);
  }

  Widget _buildTappableInputField(String label, String text, String? iconPath, VoidCallback onTap, bool hasValue, {bool isItalic = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
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
                side: BorderSide(width: 1, color: Colors.white),
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
          style: TextStyle(
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
                side: BorderSide(width: 1, color: Colors.white),
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
          style: TextStyle(
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
                side: BorderSide(width: 1, color: Colors.white),
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

  Widget _buildInputFieldWithIcon(String label, String placeholder, IconData iconData, {bool isItalic = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
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
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: ShapeDecoration(
            color: Colors.black,
            shape: RoundedRectangleBorder(
              side: BorderSide(width: 1, color: Colors.white),
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          child: Row(
            children: [
              Icon(
                iconData,
                size: 24,
                color: const Color(0xFF464646),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  placeholder,
                  style: TextStyle(
                    color: const Color(0xFF464646),
                    fontSize: 16,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                    fontStyle: isItalic ? FontStyle.italic : FontStyle.normal,
                    height: 1.50,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInputFieldWithCustomIcon(String label, String placeholder, String? iconPath, {bool isItalic = false, double iconWidth = 24, double iconHeight = 24}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
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
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: ShapeDecoration(
            color: Colors.black,
            shape: RoundedRectangleBorder(
              side: BorderSide(width: 1, color: Colors.white),
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          child: Row(
            children: [
              iconPath != null
                  ? SvgPicture.asset(
                      iconPath,
                      width: iconWidth,
                      height: iconHeight,
                      colorFilter: const ColorFilter.mode(
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
                  placeholder,
                  style: TextStyle(
                    color: const Color(0xFF464646),
                    fontSize: 16,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                    fontStyle: isItalic ? FontStyle.italic : FontStyle.normal,
                    height: 1.50,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildGenderSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
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
              side: BorderSide(width: 0.50, color: Colors.white),
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
                            child: Text('Male'),
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
                            child: Text('Female'),
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
        Text(
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
              side: BorderSide(width: 1, color: Colors.white),
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