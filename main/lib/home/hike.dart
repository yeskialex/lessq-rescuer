import 'package:flutter/material.dart';
import 'hike_confirm.dart';

class HikePage extends StatefulWidget {
  const HikePage({super.key});

  @override
  State<HikePage> createState() => _HikePageState();
}

class _HikePageState extends State<HikePage> {
  int? selectedTrailIndex;
  String sortBy = 'none'; // 'none', 'name', or 'difficulty'

  final List<Map<String, String>> allTrails = [
    {
      'title': 'Samcheonsa Trail',
      'distance': '7.33 km',
      'time': '2 hours 40 minutes',
      'difficulty': 'moderate',
    },
    {
      'title': 'Baegundae – Ui Gugok Trail',
      'distance': '5.1 km',
      'time': '2 hours 10 minutes',
      'difficulty': 'moderate',
    },
    {
      'title': 'Cheonwangbong Peak Trail (Jirisan)',
      'distance': '10.4 km',
      'time': '5 hours 20 minutes',
      'difficulty': 'advanced',
    },
    {
      'title': 'Hallasan Seongpanak Trail (Jeju island)',
      'distance': '9.6 km',
      'time': '4 hours 30 minutes',
      'difficulty': 'advanced',
    },
    {
      'title': 'Namsan Circular Trail (Seoul)',
      'distance': '7.2 km',
      'time': '2 hours',
      'difficulty': 'easy',
    },
  ];

  void selectTrail(int index) {
    setState(() {
      selectedTrailIndex = index;
    });
  }

  void setSortBy(String sortType) {
    setState(() {
      sortBy = sortType;
      selectedTrailIndex = null; // Reset selection when sorting changes
    });
  }

  List<Map<String, String>> getSortedTrails() {
    List<Map<String, String>> trails = List.from(allTrails);

    if (sortBy == 'name') {
      trails.sort((a, b) => a['title']!.compareTo(b['title']!));
    } else if (sortBy == 'difficulty') {
      // Define difficulty order: easy -> moderate -> advanced
      Map<String, int> difficultyOrder = {
        'easy': 1,
        'moderate': 2,
        'advanced': 3,
      };
      trails.sort((a, b) =>
        difficultyOrder[a['difficulty']]!.compareTo(difficultyOrder[b['difficulty']]!)
      );
    }

    return trails;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
              // Top header with location and profile
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Seoul location button
                    Container(
                      height: 36,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: ShapeDecoration(
                        color: const Color(0xFFDCFF00),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(21),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.location_on,
                            color: Colors.black,
                            size: 18,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Seoul',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Filter options
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: ShapeDecoration(
                        color: const Color(0xFFDCFF00),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(21),
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () => setSortBy('name'),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: 16,
                                  height: 16,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black, width: 2),
                                    borderRadius: BorderRadius.circular(4),
                                    color: sortBy == 'name' ? Colors.black : Colors.transparent,
                                  ),
                                  child: sortBy == 'name'
                                      ? const Icon(
                                          Icons.check,
                                          color: Color(0xFFDCFF00),
                                          size: 12,
                                        )
                                      : null,
                                ),
                                const SizedBox(width: 8),
                                const Text(
                                  'By Name',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 8),
                          GestureDetector(
                            onTap: () => setSortBy('difficulty'),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: 16,
                                  height: 16,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black, width: 2),
                                    borderRadius: BorderRadius.circular(4),
                                    color: sortBy == 'difficulty' ? Colors.black : Colors.transparent,
                                  ),
                                  child: sortBy == 'difficulty'
                                      ? const Icon(
                                          Icons.check,
                                          color: Color(0xFFDCFF00),
                                          size: 12,
                                        )
                                      : null,
                                ),
                                const SizedBox(width: 8),
                                const Text(
                                  'By Difficulty',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Trail list
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ...getSortedTrails().asMap().entries.map((entry) {
                      int index = entry.key;
                      Map<String, String> trail = entry.value;
                      return Column(
                        children: [
                          _buildTrailCard(
                            index: index,
                            title: trail['title']!,
                            distance: trail['distance']!,
                            time: trail['time']!,
                            difficulty: trail['difficulty']!,
                          ),
                          const SizedBox(height: 20),
                        ],
                      );
                    }),

                    const SizedBox(height: 100), // Space for bottom navigation
                  ],
                ),
              ),
                ],
              ),
            ),
          ),

          // Floating Next button (appears when trail is selected)
          if (selectedTrailIndex != null)
            Positioned(
              bottom: 15, // Position above the bottom navigation
              left: 24,
              right: 24,
              child: GestureDetector(
                onTap: () {
                  // Get selected trail data from sorted list
                  final trails = getSortedTrails();
                  final selectedTrail = trails[selectedTrailIndex!];

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HikeConfirmPage(
                        trailTitle: selectedTrail['title']!,
                        distance: selectedTrail['distance']!,
                        time: selectedTrail['time']!,
                        difficulty: selectedTrail['difficulty']!,
                      ),
                    ),
                  );
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  decoration: ShapeDecoration(
                    color: const Color(0xFFDCFF00),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    shadows: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.3),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const Text(
                    'Next',
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
            ),
        ],
      ),
    );
  }

  Widget _buildTrailCard({
    required int index,
    required String title,
    required String distance,
    required String time,
    required String difficulty,
  }) {
    final bool isSelected = selectedTrailIndex == index;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Trail title
        Text(
          title,
          style: TextStyle(
            color: isSelected ? const Color(0xFFDCFF00) : Colors.white,
            fontSize: 18,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        // Trail info card
        GestureDetector(
          onTap: () => selectTrail(index),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: ShapeDecoration(
              color: isSelected ? const Color(0xFFDCFF00).withValues(alpha: 0.25) : const Color(0xFF464646),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(22),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Distance
                Text.rich(
                  TextSpan(
                    children: [
                      const TextSpan(
                        text: 'Total travel distance: ',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      TextSpan(
                        text: distance,
                        style: const TextStyle(
                          color: Color(0xFFDCFF00),
                          fontSize: 14,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                // Time
                Text.rich(
                  TextSpan(
                    children: [
                      const TextSpan(
                        text: 'Average travel time: ',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      TextSpan(
                        text: time,
                        style: const TextStyle(
                          color: Color(0xFFDCFF00),
                          fontSize: 14,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                // Difficulty
                Text.rich(
                  TextSpan(
                    children: [
                      const TextSpan(
                        text: 'Difficulty: ',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      TextSpan(
                        text: difficulty,
                        style: const TextStyle(
                          color: Color(0xFFDCFF00),
                          fontSize: 14,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}