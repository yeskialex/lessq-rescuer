import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:main/home/calling_emergency.dart';
import 'dart:async';
import 'dart:math' as math;
import 'package:main/services/native_alert_service.dart';
import 'hike_finished.dart';

class HikeActivePage extends StatefulWidget {
  final String trailTitle;
  final String totalDistance;
  final String estimatedTime;

  const HikeActivePage({
    super.key,
    required this.trailTitle,
    required this.totalDistance,
    required this.estimatedTime,
  });

  @override
  State<HikeActivePage> createState() => _HikeActivePageState();
}

class _HikeActivePageState extends State<HikeActivePage> {
  Timer? _timer;
  int _elapsedSeconds = 0;
  double _progress = 0.0; // Progress from 0.0 to 1.0
  int _heartRate = 120;
  int _calories = 0;
  bool _isPaused = false;
  int _distanceToNextStop = 200;
  bool _hasShownCliffWarning = false;
  bool _hasShownChestPainWarning = false;
  bool _hasShownDaylightWarning = false;
  bool _hasShownOffTrailWarning = false;
  bool _hasShownHeavyRainWarning = false;
  bool _hasShownNearbyAssistanceWarning = false;
  bool _hasShownDangerousTrailWarning = false;
  bool _hasShownGKimiWarning = false;
  bool _hasShownCompletionPopup = false;

  @override
  void initState() {
    super.initState();
    _startHike();
  }

  void _startHike() {
    _timer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      if (!_isPaused) {
        setState(() {
          _elapsedSeconds++;

          // Update progress: faster rate (completes in ~1 minute)
          _progress = math.min(1.0, _progress + (1.0 / 120));

          // Update heart rate with smooth fluctuation (gradual changes between 110-155)
          // Use sine wave for smooth, realistic heart rate variation
          final heartRateVariation = (math.sin(_elapsedSeconds / 10) * 20).round();
          _heartRate = 130 + heartRateVariation;

          // Update calories faster (roughly 1 calorie every second)
          _calories = _elapsedSeconds;

          // Update distance to next stop (decrease by 4m per tick = 8m per second)
          _distanceToNextStop = math.max(0, 200 - (_elapsedSeconds * 4) % 200);

          // Trigger chest pain warning at 7% progress
          if (_progress >= 0.07 && !_hasShownChestPainWarning) {
            _hasShownChestPainWarning = true;
            _showChestPainWarning();
          }

          // Trigger daylight warning at 11% progress
          if (_progress >= 0.11 && !_hasShownDaylightWarning) {
            _hasShownDaylightWarning = true;
            _showDaylightWarning();
          }

          // Trigger off-trail warning at 15% progress
          if (_progress >= 0.15 && !_hasShownOffTrailWarning) {
            _hasShownOffTrailWarning = true;
            _showOffTrailWarning();
          }

          // Trigger heavy rain warning at 18% progress
          if (_progress >= 0.18 && !_hasShownHeavyRainWarning) {
            _hasShownHeavyRainWarning = true;
            _showHeavyRainWarning();
          }

          // Trigger nearby assistance warning at 23% progress
          if (_progress >= 0.23 && !_hasShownNearbyAssistanceWarning) {
            _hasShownNearbyAssistanceWarning = true;
            _showNearbyAssistanceWarning();
          }

          // Trigger dangerous trail warning at 26% progress
          if (_progress >= 0.26 && !_hasShownDangerousTrailWarning) {
            _hasShownDangerousTrailWarning = true;
            _showDangerousTrailWarning();
          }

          // Trigger cliff warning at 30% progress (example trigger point)
          if (_progress >= 0.03 && !_hasShownCliffWarning) {
            _hasShownCliffWarning = true;
            _showCliffWarning();
          }

          // Trigger G-KIMI warning at 33% progress
          if (_progress >= 0.33 && !_hasShownGKimiWarning) {
            _hasShownGKimiWarning = true;
            _showGKimiWarning();
          }

          // Trigger completion popup at 100% progress
          if (_progress >= 1.0 && !_hasShownCompletionPopup) {
            _hasShownCompletionPopup = true;
            _timer?.cancel();
            _showCompletionPopup();
          }
        });
      }
    });
  }

  void _showChestPainWarning() async {
    // Pause the timer while showing the alert
    final wasPaused = _isPaused;
    setState(() {
      _isPaused = true;
    });

    final result = await NativeAlertService.showWarningAlert(
      title: 'Chest Pain Warning',
      message: 'The symptom like chest pain should be treated as a medical emergency, regardless of environmental factors.',
      pauseButtonText: 'Call 119',
      cancelButtonText: 'Cancel',
    );

    if (result == 'pause') {
      // Navigate to calling emergency page
      _timer?.cancel();
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const CallingEmergencyPage(),
          ),
        );
      }
    } else if (result == 'cancel') {
      // Resume the hike
      setState(() {
        _isPaused = wasPaused; // Restore previous pause state
      });
    }
  }

  void _showDaylightWarning() async {
    // Pause the timer while showing the alert
    final wasPaused = _isPaused;
    setState(() {
      _isPaused = true;
    });

    final result = await NativeAlertService.showWarningAlert(
      title: 'Daylight Warning',
      message: 'The sun is setting. Be aware of the trail conditions. If you are lost, it may be safer to stay put and call for help.',
      pauseButtonText: 'Call 119',
      cancelButtonText: 'Cancel',
    );

    if (result == 'pause') {
      // Navigate to calling emergency page
      _timer?.cancel();
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const CallingEmergencyPage(),
          ),
        );
      }
    } else if (result == 'cancel') {
      // Resume the hike
      setState(() {
        _isPaused = wasPaused; // Restore previous pause state
      });
    }
  }

  void _showOffTrailWarning() async {
    // Pause the timer while showing the alert
    final wasPaused = _isPaused;
    setState(() {
      _isPaused = true;
    });

    final result = await NativeAlertService.showWarningAlert(
      title: 'Off-Trail Warning',
      message: 'It looks like you\'ve wandered from the main path. Let\'s get you back safely—tap to see the quickest route to the trail.',
      pauseButtonText: 'Call 119',
      cancelButtonText: 'Cancel',
    );

    if (result == 'pause') {
      // Navigate to calling emergency page
      _timer?.cancel();
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const CallingEmergencyPage(),
          ),
        );
      }
    } else if (result == 'cancel') {
      // Resume the hike
      setState(() {
        _isPaused = wasPaused; // Restore previous pause state
      });
    }
  }

  void _showHeavyRainWarning() async {
    // Pause the timer while showing the alert
    final wasPaused = _isPaused;
    setState(() {
      _isPaused = true;
    });

    final result = await NativeAlertService.showWarningAlert(
      title: 'Heavy Rain Warning',
      message: 'Heavy rain and a possible thunderstorm are moving into your location now. Descend from high ground immediately.',
      pauseButtonText: 'On my way!',
      cancelButtonText: 'Cancel',
    );

    if (result == 'pause') {
      // User acknowledged and is on their way
      setState(() {
        _isPaused = wasPaused; // Resume the hike
      });
    } else if (result == 'cancel') {
      // Resume the hike
      setState(() {
        _isPaused = wasPaused; // Restore previous pause state
      });
    }
  }

  void _showNearbyAssistanceWarning() async {
    // Pause the timer while showing the alert
    final wasPaused = _isPaused;
    setState(() {
      _isPaused = true;
    });

    final result = await NativeAlertService.showWarningAlert(
      title: 'Nearby Assistance',
      message: 'A hiker near you needs assistance. Tap to view details and help if you can do so safely.',
      pauseButtonText: 'On my way!',
      cancelButtonText: 'Cancel',
    );

    if (result == 'pause') {
      // User acknowledged and is on their way to help
      setState(() {
        _isPaused = wasPaused; // Resume the hike
      });
    } else if (result == 'cancel') {
      // Resume the hike
      setState(() {
        _isPaused = wasPaused; // Restore previous pause state
      });
    }
  }

  void _showDangerousTrailWarning() async {
    // Pause the timer while showing the alert
    final wasPaused = _isPaused;
    setState(() {
      _isPaused = true;
    });

    final result = await NativeAlertService.showWarningAlert(
      title: 'Dangerous Trail Warning',
      message: 'Pay close attention to the trail ahead! It can be dangerous.',
      pauseButtonText: 'I will be careful!',
      cancelButtonText: 'Cancel',
    );

    if (result == 'pause') {
      // User acknowledged and will be careful
      setState(() {
        _isPaused = wasPaused; // Resume the hike
      });
    } else if (result == 'cancel') {
      // Resume the hike
      setState(() {
        _isPaused = wasPaused; // Restore previous pause state
      });
    }
  }

  void _showGKimiWarning() async {
    // Pause the timer while showing the alert
    final wasPaused = _isPaused;
    setState(() {
      _isPaused = true;
    });

    final result = await NativeAlertService.showWarningAlert(
      title: 'G-KIMI Warning',
      message: 'Heavy rain and a possible thunderstorm are moving into your location now. Descend from high ground immediately.',
      pauseButtonText: 'On my way!',
      cancelButtonText: 'Cancel',
    );

    if (result == 'pause') {
      // User acknowledged and is on their way
      setState(() {
        _isPaused = wasPaused; // Resume the hike
      });
    } else if (result == 'cancel') {
      // Resume the hike
      setState(() {
        _isPaused = wasPaused; // Restore previous pause state
      });
    }
  }

  void _showCliffWarning() async {
    // Pause the timer while showing the alert
    final wasPaused = _isPaused;
    setState(() {
      _isPaused = true;
    });

    final result = await NativeAlertService.showWarningAlert(
      title: 'Cliff Warning',
      message: 'Cliff edge is in front. Be careful.',
      pauseButtonText: 'Pause',
      cancelButtonText: 'Continue',
    );

    if (result == 'pause') {
      // Keep the hike paused
      setState(() {
        _isPaused = true;
      });
    } else if (result == 'cancel') {
      // Resume the hike
      setState(() {
        _isPaused = wasPaused; // Restore previous pause state
      });
    }
  }

  void _togglePause() {
    setState(() {
      _isPaused = !_isPaused;
    });
  }

  void _endHike() async {
    _timer?.cancel();

    final result = await NativeAlertService.showWarningAlert(
      title: 'End Hike?',
      message: 'Are you sure you want to end this hike?',
      pauseButtonText: 'End',
      cancelButtonText: 'Cancel',
    );

    if (result == 'pause') {
      // User confirmed ending the hike
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const HikeFinishedPage(),
          ),
        );
      }
    } else if (result == 'cancel') {
      // User cancelled, resume the timer
      _startHike();
    }
  }

  void _showSOS() async{
    _timer?.cancel();

    final result = await NativeAlertService.showWarningAlert(
      title: 'SOS Emergency',
      message: 'Emergency services will be contacted with your location.',
      pauseButtonText: 'Send SOS',
      cancelButtonText: 'Cancel',
    );

    if (result == 'pause') {
      // User confirmed ending the hike
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const CallingEmergencyPage(),
          ),
        );
      }
    } else if (result == 'cancel') {
      // User cancelled, resume the timer
      _startHike();
    }
    // // Navigate to SOS page or show SOS dialog
    // showDialog(
    //   context: context,
    //   builder: (context) => AlertDialog(
    //     backgroundColor: const Color(0xFFF72D2D),
    //     title: const Text(
    //       'SOS Emergency',
    //       style: TextStyle(color: Colors.white, fontFamily: 'Poppins', fontWeight: FontWeight.w700),
    //     ),
    //     content: const Text(
    //       'Emergency services will be contacted with your location.',
    //       style: TextStyle(color: Colors.white, fontFamily: 'Poppins'),
    //     ),
    //     actions: [
    //       TextButton(
    //         onPressed: () => Navigator.pop(context),
    //         child: const Text(
    //           'Cancel',
    //           style: TextStyle(color: Colors.white),
    //         ),
    //       ),
    //       TextButton(
    //         onPressed: () {
    //           Navigator.pop(context);
    //           // Handle SOS logic here
    //         },
    //         child: const Text(
    //           'Send SOS',
    //           style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  }

  void _showCompletionPopup() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const HikeFinishedPage(),
      ),
    );
  }

  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int secs = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 20),

                    // Top section with emergency button and next rest stop
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Emergency button (red circle with phone icon)
                          GestureDetector(
                            onTap: _showSOS,
                            child: Container(
                              width: 34,
                              height: 34,
                              decoration: const ShapeDecoration(
                                color: Color.fromARGB(255, 0, 0, 0),
                                shape: OvalBorder(
                                  side: BorderSide(
                                    width: 1,
                                    color: Color.fromARGB(255, 0, 0, 0),
                                  ),
                                ),
                              ),
                              child: const Icon(
                                Icons.phone,
                                color: Color.fromARGB(255, 0, 0, 0),
                                size: 16,
                              ),
                            ),
                          ),

                          // Next rest stop indicator
                          Text.rich(
                            TextSpan(
                              children: [
                                const TextSpan(
                                  text: 'Next rest stop  ',
                                  style: TextStyle(
                                    color: Color(0xFFDCFF00),
                                    fontSize: 14,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                    height: 1.71,
                                  ),
                                ),
                                TextSpan(
                                  text: '$_distanceToNextStop m',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                    height: 1.20,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Progress bar with time and percentage
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
                        decoration: ShapeDecoration(
                          color: const Color(0xFF464646),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                const Text(
                                  'Time',
                                  style: TextStyle(
                                    color: Color(0xFFA4A4A4),
                                    fontSize: 14,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: LayoutBuilder(
                                    builder: (context, constraints) {
                                      final progressWidth = constraints.maxWidth;
                                      final dotPosition = _progress * progressWidth;

                                      return Stack(
                                        clipBehavior: Clip.none,
                                        alignment: Alignment.centerLeft,
                                        children: [
                                          // Background bar
                                          Container(
                                            height: 8,
                                            decoration: BoxDecoration(
                                              color: const Color(0xFF6B6B6B),
                                              borderRadius: BorderRadius.circular(4),
                                            ),
                                          ),
                                          // Progress bar
                                          FractionallySizedBox(
                                            widthFactor: _progress,
                                            child: Container(
                                              height: 8,
                                              decoration: BoxDecoration(
                                                color: const Color(0xFFDCFF00),
                                                borderRadius: BorderRadius.circular(4),
                                              ),
                                            ),
                                          ),
                                          // Yellow dot indicator with percentage text
                                          Positioned(
                                            left: dotPosition - 14,
                                            top: -27,
                                            child: Column(
                                              children: [
                                                // Percentage text above the dot
                                                Transform.translate(
                                                  offset: const Offset(0, -1),
                                                  child: Text(
                                                    '${(_progress * 100).toInt()}%',
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 17,
                                                      fontFamily: 'Poppins',
                                                      fontWeight: FontWeight.w700,
                                                      height: 1.41,
                                                    ),
                                                  ),
                                                ),
                                                // Yellow circle dot
                                                Container(
                                                  width: 14,
                                                  height: 14,
                                                  decoration: const ShapeDecoration(
                                                    color: Color(0xFFDCFF00),
                                                    shape: OvalBorder(),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Text(
                                  _formatTime(_elapsedSeconds),
                                  style: const TextStyle(
                                    color: Color(0xFFA4A4A4),
                                    fontSize: 14,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Trail map
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Container(
                        width: double.infinity,
                        height: 350,
                        decoration: ShapeDecoration(
                          color: const Color(0xFF464646),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(37),
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(37),
                          child: ActiveTrailMapWidget(progress: _progress),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Heart rate and Calories
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                              decoration: ShapeDecoration(
                                color: const Color(0x4CDCFF00),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                              child: Column(
                                children: [
                                  const Text(
                                    'Heart rate',
                                    style: TextStyle(
                                      color: Color(0xFFA4A4A4),
                                      fontSize: 14,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    '$_heartRate bpm',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                              decoration: ShapeDecoration(
                                color: const Color(0x4CDCFF00),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                              child: Column(
                                children: [
                                  const Text(
                                    'Calories',
                                    style: TextStyle(
                                      color: Color(0xFFA4A4A4),
                                      fontSize: 14,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    '$_calories',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),

            // Bottom action buttons
            Padding(
              padding: const EdgeInsets.all(24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // SOS button
                  GestureDetector(
                    onTap: _showSOS,
                    child: Container(
                      width: 81,
                      height: 81,
                      decoration: const ShapeDecoration(
                        color: Color(0xFFF72D2D),
                        shape: OvalBorder(),
                      ),
                      child: const Center(
                        child: Text(
                          'SOS',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),

                  // Pause/Play button (center, larger)
                  GestureDetector(
                    onTap: _togglePause,
                    child: Container(
                      width: 115,
                      height: 115,
                      decoration: const ShapeDecoration(
                        color: Color(0xFFDCFF00),
                        shape: OvalBorder(),
                      ),
                      child: Center(
                        child: Icon(
                          _isPaused ? Icons.play_arrow : Icons.pause,
                          color: Colors.black,
                          size: 45,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),

                  // End button
                  GestureDetector(
                    onTap: _endHike,
                    child: Container(
                      width: 81,
                      height: 81,
                      decoration: const ShapeDecoration(
                        color: Color(0xFFDCFF00),
                        shape: OvalBorder(),
                      ),
                      child: const Center(
                        child: Text(
                          'End',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                          ),
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
    );
  }
}

// Widget that combines the trail map with the SVG pin marker
class ActiveTrailMapWidget extends StatelessWidget {
  final double progress;

  const ActiveTrailMapWidget({super.key, required this.progress});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Calculate pin position based on progress
        final points = _getTrailPoints(constraints.maxWidth, constraints.maxHeight);
        final currentPos = _calculateCurrentPosition(points, progress);

        return Stack(
          clipBehavior: Clip.none,
          children: [
            // Trail path
            CustomPaint(
              size: Size(constraints.maxWidth, constraints.maxHeight),
              painter: ActiveTrailPainter(progress: progress),
            ),
            // SVG pin marker overlay
            Positioned(
              left: currentPos.dx - 20,
              top: currentPos.dy - 45,
              child: SvgPicture.asset(
                'assets/icons/hike/pinmarker.svg',
                width: 40,
                height: 45,
                fit: BoxFit.contain,
                colorFilter: const ColorFilter.mode(
                  Color(0xFFDCFF00),
                  BlendMode.srcIn,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  List<Offset> _getTrailPoints(double width, double height) {
    return [
      Offset(width * 0.10, height * 0.92), // Start: bottom left
      Offset(width * 0.25, height * 0.80), // First turn
      Offset(width * 0.45, height * 0.75), // Horizontal stretch
      Offset(width * 0.48, height * 0.55), // Vertical up
      Offset(width * 0.60, height * 0.35), // Middle section
      Offset(width * 0.80, height * 0.28), // Upper horizontal
      Offset(width * 0.85, height * 0.15), // Near top right
      Offset(width * 0.78, height * 0.08), // End: top right area
    ];
  }

  Offset _calculateCurrentPosition(List<Offset> points, double progress) {
    int completedSegments = (progress * (points.length - 1)).floor();
    double segmentProgress = (progress * (points.length - 1)) - completedSegments;

    if (completedSegments < points.length - 1) {
      return Offset(
        points[completedSegments].dx + (points[completedSegments + 1].dx - points[completedSegments].dx) * segmentProgress,
        points[completedSegments].dy + (points[completedSegments + 1].dy - points[completedSegments].dy) * segmentProgress,
      );
    } else {
      return points.last;
    }
  }
}

class ActiveTrailPainter extends CustomPainter {
  final double progress;

  ActiveTrailPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    // Path points for the trail
    final List<Offset> points = [
      Offset(size.width * 0.10, size.height * 0.92), // Start: bottom left
      Offset(size.width * 0.25, size.height * 0.80), // First turn
      Offset(size.width * 0.45, size.height * 0.75), // Horizontal stretch
      Offset(size.width * 0.48, size.height * 0.55), // Vertical up
      Offset(size.width * 0.60, size.height * 0.35), // Middle section
      Offset(size.width * 0.80, size.height * 0.28), // Upper horizontal
      Offset(size.width * 0.85, size.height * 0.15), // Near top right
      Offset(size.width * 0.78, size.height * 0.08), // End: top right area
    ];

    // Calculate progress point
    int completedSegments = (progress * (points.length - 1)).floor();
    double segmentProgress = (progress * (points.length - 1)) - completedSegments;

    // Step 1: Draw the entire trail path as grey solid base
    final greyBasePaint = Paint()
      ..color = const Color(0xFF8A8A8A)
      ..strokeWidth = 20
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    for (int i = 0; i < points.length - 1; i++) {
      canvas.drawLine(points[i], points[i + 1], greyBasePaint);
    }

    // Step 2: Draw black dashed line on entire path (static, won't move)
    final dashedPaint = Paint()
      ..color = Colors.black
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke;

    for (int i = 0; i < points.length - 1; i++) {
      _drawDashedLine(canvas, points[i], points[i + 1], dashedPaint);
    }

    // Step 3: Draw completed path (yellow/lime solid on top, overlapping the dashed line)
    final completedPaint = Paint()
      ..color = const Color(0xFFDCFF00)
      ..strokeWidth = 12
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    for (int i = 0; i < completedSegments && i < points.length - 1; i++) {
      canvas.drawLine(points[i], points[i + 1], completedPaint);
    }

    // Draw current segment partially
    if (completedSegments < points.length - 1) {
      Offset currentEnd = Offset(
        points[completedSegments].dx + (points[completedSegments + 1].dx - points[completedSegments].dx) * segmentProgress,
        points[completedSegments].dy + (points[completedSegments + 1].dy - points[completedSegments].dy) * segmentProgress,
      );
      canvas.drawLine(points[completedSegments], currentEnd, completedPaint);
    }

    // Draw waypoint circles
    final waypointPaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;

    for (int i = 1; i < points.length - 1; i++) {
      canvas.drawCircle(points[i], 10, waypointPaint);
    }

    // Note: Pin marker is now drawn as SVG overlay in ActiveTrailMapWidget
  }

  void _drawDashedLine(Canvas canvas, Offset start, Offset end, Paint paint) {
    const dashWidth = 8;
    const dashSpace = 5;

    double distance = (end - start).distance;
    double dashCount = distance / (dashWidth + dashSpace);

    for (int i = 0; i < dashCount; i++) {
      double t1 = (i * (dashWidth + dashSpace)) / distance;
      double t2 = math.min(((i * (dashWidth + dashSpace)) + dashWidth) / distance, 1.0);

      Offset p1 = Offset(
        start.dx + (end.dx - start.dx) * t1,
        start.dy + (end.dy - start.dy) * t1,
      );
      Offset p2 = Offset(
        start.dx + (end.dx - start.dx) * t2,
        start.dy + (end.dy - start.dy) * t2,
      );

      canvas.drawLine(p1, p2, paint);
    }
  }

  @override
  bool shouldRepaint(ActiveTrailPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
