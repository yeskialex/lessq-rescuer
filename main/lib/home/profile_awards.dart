import 'package:flutter/material.dart';
import 'bottom_navigation.dart';

class ProfileAwardsPage extends StatelessWidget {
  const ProfileAwardsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white, size: 28),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ),
                  const Center(
                    child: Text(
                      'Awards',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Scrollable grid
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    const SizedBox(height: 16),

                    // Grid of awards (2 columns)
                    GridView.count(
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisSpacing: 50,
                      mainAxisSpacing: 20,
                      childAspectRatio: 0.62,
                      children: [
                        _buildAwardCard(
                          title: 'NEW RECORD',
                          description: 'You\'ve set a new record!',
                          imagePath: 'assets/images/awarding1.png',
                          isLocked: false,
                        ),
                        _buildAwardCard(
                          title: 'KING OF HIKER',
                          description: 'You\'ve completed all the mountains!',
                          imagePath: 'assets/images/awarding2.png',
                          isLocked: false,
                        ),
                        _buildAwardCard(
                          title: 'Monthly',
                          description: 'You\'ve earned the title of Monthly 2nd Place!',
                          imagePath: 'assets/images/awarding3.png',
                          isLocked: false,
                        ),
                        _buildAwardCard(
                          title: '???',
                          description: '???',
                          imagePath: null,
                          isLocked: true,
                        ),
                        _buildAwardCard(
                          title: '???',
                          description: '???',
                          imagePath: null,
                          isLocked: true,
                        ),
                        _buildAwardCard(
                          title: '???',
                          description: '???',
                          imagePath: null,
                          isLocked: true,
                        ),
                        _buildAwardCard(
                          title: '???',
                          description: '???',
                          imagePath: null,
                          isLocked: true,
                        ),
                        _buildAwardCard(
                          title: '???',
                          description: '???',
                          imagePath: null,
                          isLocked: true,
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),
                  ],
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
              Expanded(child: _buildNavItem(context, 0, 'Hike', Icons.hiking, false)),
              Expanded(child: _buildNavItem(context, 1, 'SOS', Icons.emergency, false)),
              Expanded(child: _buildNavItem(context, 2, 'Contacts', Icons.contacts, false)),
              Expanded(child: _buildNavItem(context, 3, 'My', Icons.person, true)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAwardCard({
    required String title,
    required String description,
    required String? imagePath,
    required bool isLocked,
  }) {
    return Column(
      children: [
        AspectRatio(
          aspectRatio: 1.0,
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: isLocked ? const Color(0xFFDCFF00).withValues(alpha: 0.3) : const Color(0xFFDCFF00),
                width: 2,
              ),
            ),
            child: Center(
              child: isLocked
                  ? Icon(
                      Icons.lock,
                      color: const Color(0xFFDCFF00).withValues(alpha: 0.3),
                      size:50,
                    )
                  : imagePath != null
                      ? Image.asset(
                          imagePath,
                          fit: BoxFit.contain,
                        )
                      : const SizedBox.shrink(),
            ),
          ),
        ),
        const SizedBox(height: 8),
        // Title with wing brackets
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ColorFiltered(
              colorFilter: ColorFilter.mode(
                isLocked ? Colors.white.withValues(alpha: 0.3) : Colors.white,
                BlendMode.srcIn,
              ),
              child: Image.asset(
                'assets/icons/leftwing.png',
                width: 20,
                height: 20,
              ),
            ),
            const SizedBox(width: 0),
            Flexible(
              child: Text(
                title,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: isLocked ? Colors.white.withValues(alpha: 0.3) : Colors.white,
                  fontSize: 14,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(width: 0),
            ColorFiltered(
              colorFilter: ColorFilter.mode(
                isLocked ? Colors.white.withValues(alpha: 0.3) : Colors.white,
                BlendMode.srcIn,
              ),
              child: Image.asset(
                'assets/icons/rightwing.png',
                width: 20,
                height: 20,
              ),
            ),
          ],
        ),
        if (!isLocked) ...[
          const SizedBox(height: 4),
          // Description
          Text(
            description,
            textAlign: TextAlign.center,
            maxLines: 2,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 11,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
              height: 1.3,
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildNavItem(BuildContext context, int index, String label, IconData icon, bool isSelected) {
    return GestureDetector(
      onTap: () {
        if (!isSelected) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomeBottomNavigation(currentIndex: index),
            ),
          );
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isSelected ? const Color(0x8EC6E500) : Colors.grey,
              size: 20,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? const Color(0x8EC6E500) : Colors.grey,
                fontSize: 10,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
