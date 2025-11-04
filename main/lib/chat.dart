import 'dart:async';
import 'package:flutter/material.dart';
import 'mission_failed.dart';
import 'mission_success.dart';

class Message {
  final String text;
  final bool isFromUser;
  final bool isSystemMessage;
  final String? imagePath;

  Message({
    required this.text,
    required this.isFromUser,
    this.isSystemMessage = false,
    this.imagePath,
  });
}

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final FocusNode _focusNode = FocusNode();
  final List<int> _targetCode = [5, 2, 3, 2];
  int _currentPosition = 0;
  bool _gameActive = false;
  bool _gameCompleted = false;
  bool _hasText = false;
  int _timeRemaining = 120; // 2 minutes in seconds
  Timer? _timer;
  final List<Message> _messages = [];

  final List<String> _sectionPrompts = [
    'We have a partial signal. Let\'s begin. Proceed to Section WT on your map. Find the [IMAGE:symbol_1] and report the number underneath.',
    'New signal acquired. Proceed to Section EG. Find the [IMAGE:symbol2] and report the number underneath.',
    'Acquiring third location. Proceed to Section KD. Find the [IMAGE:symbol3] and report the number underneath.',
    'Final signal. Proceed to Section NZ. Find the [IMAGE:symbol4] and report the number underneath.',
  ];

  final List<String> _sectionImages = [
    'assets/symbol_1.png',
    'assets/symbol2.png',
    'assets/symbol3.png',
    'assets/symbol4.png',
  ];

  final List<String> _confirmationMessages = [
    'Confirmed. First digit is 5. Moving to the next signal area.',
    'Confirmed. Second digit is 2. Good work.',
    'Confirmed. Third digit is 3. One location remaining.',
    'Confirmed. Final digit is 2.',
  ];

  @override
  void initState() {
    super.initState();
    _startGame();
    _startTimer();
    _controller.addListener(_onTextChanged);
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_timeRemaining > 0) {
          _timeRemaining--;
        } else {
          _timer?.cancel();
          _onTimerExpired();
        }
      });
    });
  }

  void _onTimerExpired() {
    setState(() {
      _gameActive = false;
      _messages.add(Message(
        text: 'TIME\'S UP! The Golden Hour has passed. Mission failed.',
        isFromUser: false,
        isSystemMessage: true,
      ));
    });
    _showMissionFailedDialog();
  }

  void _showMissionFailedDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: const Color(0xFF464646),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Crying emoji
                const Text(
                  '😢',
                  style: TextStyle(fontSize: 60),
                ),
                const SizedBox(height: 20),
                // Title
                const Text(
                  'Mission Failed',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                // Description
                const Text(
                  'The Golden Hour has passed. Time ran out during the rescue mission.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                // Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Close dialog
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => const MissionFailedPage(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFDCFF00),
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Continue',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showMissionSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: const Color(0xFF464646),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Success emoji/icon
                const Text(
                  '🎉',
                  style: TextStyle(fontSize: 60),
                ),
                const SizedBox(height: 20),
                // Title
                const Text(
                  'Mission Success!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                // Description
                const Text(
                  'Congratulations! You successfully saved the hiker within the Golden Hour.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                // Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Close dialog
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => const MissionSuccessPage(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFDCFF00),
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Continue',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  String _formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  void _onTextChanged() {
    final hasText = _controller.text.trim().isNotEmpty;
    if (hasText != _hasText) {
      setState(() {
        _hasText = hasText;
      });
    }
  }

  void _startGame() {
    setState(() {
      _gameActive = true;
      _messages.clear();
      _messages.add(Message(
        text: '[CONNECTION ESTABLISHED]... Welcome, Rescuer. A hiker is lost. The Golden Hour is running out. We need you to visually confirm 4 location markers to form the final rescue code.',
        isFromUser: false,
        isSystemMessage: true,
      ));
      _messages.add(Message(
        text: _sectionPrompts[0],
        isFromUser: false,
      ));
      _messages.add(Message(
        text: '',
        isFromUser: false,
        imagePath: _sectionImages[0],
      ));
    });
    _scrollToBottom();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          0,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _handleInput(String input) {
    if (!_gameActive || _gameCompleted) return;

    final inputDigit = int.tryParse(input.trim());
    if (inputDigit == null) return;

    setState(() {
      _messages.add(Message(text: input, isFromUser: true));

      if (inputDigit == _targetCode[_currentPosition]) {
        _messages.add(Message(
          text: _confirmationMessages[_currentPosition],
          isFromUser: false,
        ));

        _currentPosition++;

        if (_currentPosition >= _targetCode.length) {
          _timer?.cancel();
          _messages.add(Message(
            text: 'CODE: 5 - 2 - 3 - 2. We have a match! You\'ve found the hiker\'s path. Rescue team is being dispatched to the final coordinates.',
            isFromUser: false,
          ));
          _messages.add(Message(
            text: 'MISSION COMPLETE. You\'ve saved the hiker! #EverySecondCounts',
            isFromUser: false,
            isSystemMessage: true,
          ));
          _gameCompleted = true;
          _gameActive = false;
          _showMissionSuccessDialog();
        } else {
          _messages.add(Message(
            text: _sectionPrompts[_currentPosition],
            isFromUser: false,
          ));
          _messages.add(Message(
            text: '',
            isFromUser: false,
            imagePath: _sectionImages[_currentPosition],
          ));
        }
      } else {
        _messages.add(Message(
          text: 'Wrong number, try again. Current location: ${_getSectionName(_currentPosition)}',
          isFromUser: false,
        ));
      }
    });

    _controller.clear();
    _focusNode.unfocus();
    _scrollToBottom();
  }

  String _getSectionName(int position) {
    const sections = ['Section WT', 'Section EG', 'Section KD', 'Section NZ'];
    return sections[position];
  }

  Widget _buildMessageText(Message message) {
    final text = message.isFromUser ? message.text : '[119 Dispatcher] ${message.text}';
    final color = message.isFromUser ? Colors.black : Colors.white;

    if (message.isFromUser) {
      return Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 16,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w400,
          height: 1.5,
        ),
      );
    }

    // For dispatcher messages, handle both images and bold sections
    return _buildRichMessageText(text, color);
  }

  Widget _buildRichMessageText(String text, Color color) {
    final sections = ['Section WT', 'Section EG', 'Section KD', 'Section NZ'];
    final imagePattern = RegExp(r'\[IMAGE:([^\]]+)\]');

    List<InlineSpan> spans = [];
    int lastIndex = 0;

    // Process images first
    for (Match match in imagePattern.allMatches(text)) {
      int start = match.start;
      int end = match.end;
      String imageName = match.group(1)!;

      // Add text before image
      if (start > lastIndex) {
        String beforeText = text.substring(lastIndex, start);
        spans.addAll(_processTextForSections(beforeText, sections, color));
      }

      // Add image
      spans.add(WidgetSpan(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
          child: Image.asset(
            'assets/$imageName.png',
            width: 24,
            height: 24,
            fit: BoxFit.contain,
          ),
        ),
        alignment: PlaceholderAlignment.middle,
      ));

      lastIndex = end;
    }

    // Add remaining text after last image
    if (lastIndex < text.length) {
      String afterText = text.substring(lastIndex);
      spans.addAll(_processTextForSections(afterText, sections, color));
    }

    // If no images found, just process for sections
    if (spans.isEmpty) {
      spans.addAll(_processTextForSections(text, sections, color));
    }

    return RichText(
      text: TextSpan(children: spans),
    );
  }

  List<InlineSpan> _processTextForSections(String text, List<String> sections, Color color) {
    List<InlineSpan> spans = [];
    int lastIndex = 0;

    for (String section in sections) {
      int index = text.indexOf(section, lastIndex);
      if (index != -1) {
        // Add text before the section
        if (index > lastIndex) {
          spans.add(TextSpan(
            text: text.substring(lastIndex, index),
            style: TextStyle(
              color: color,
              fontSize: 16,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
              height: 1.5,
            ),
          ));
        }
        // Add the bold section
        spans.add(TextSpan(
          text: section,
          style: TextStyle(
            color: color,
            fontSize: 16,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
            height: 1.5,
          ),
        ));
        lastIndex = index + section.length;
      }
    }

    // Add remaining text
    if (lastIndex < text.length) {
      spans.add(TextSpan(
        text: text.substring(lastIndex),
        style: TextStyle(
          color: color,
          fontSize: 16,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w400,
          height: 1.5,
        ),
      ));
    }

    // If no sections found, return the whole text
    if (spans.isEmpty) {
      spans.add(TextSpan(
        text: text,
        style: TextStyle(
          color: color,
          fontSize: 16,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w400,
          height: 1.5,
        ),
      ));
    }

    return spans;
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    _focusNode.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.red, width: 2),
              ),
              child: const Icon(
                Icons.local_hospital,
                color: Colors.red,
                size: 24,
              ),
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: Text(
                '119 EMERGENCY DISPATCH',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.call, color: Colors.red, size: 28),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Timer Progress Bar
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
            decoration: const BoxDecoration(
              color: Color(0xFF464646),
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
            margin: const EdgeInsets.all(16),
            child: Row(
              children: [
                const Text(
                  'Time',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Stack(
                    children: [
                      // Background bar
                      Container(
                        height: 6,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade700,
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                      // Progress bar
                      FractionallySizedBox(
                        widthFactor: (120 - _timeRemaining) / 120,
                        child: Container(
                          height: 6,
                          decoration: BoxDecoration(
                            color: _timeRemaining <= 30 ? Colors.red : const Color(0xFFDCFF00),
                            borderRadius: BorderRadius.circular(3),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Text(
                  _formatTime(_timeRemaining),
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: Align(
                alignment: Alignment.topCenter,
                child: ListView.builder(
                  controller: _scrollController,
                  reverse: true,
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(16),
                  itemCount: _messages.length,
                  itemBuilder: (context, index) {
                    final reversedIndex = _messages.length - 1 - index;
                    final message = _messages[reversedIndex];

                    if (message.isSystemMessage) {
                      return Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1a1a1a),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.orange, width: 1),
                        ),
                        child: Text(
                          message.text,
                          style: const TextStyle(
                            color: Colors.orange,
                            fontSize: 14,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                            height: 1.5,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      );
                    }

                    // Handle image messages
                    if (message.imagePath != null && message.imagePath!.isNotEmpty) {
                      return Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 16),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: const Color(0xFF464646),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(
                              message.imagePath!,
                              width: 120,
                              height: 120,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      );
                    }

                    return Align(
                      alignment: message.isFromUser
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: Container(
                        constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.75,
                        ),
                        margin: const EdgeInsets.only(bottom: 16),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: message.isFromUser
                              ? const Color(0xFFDCFF00)
                              : const Color(0xFF464646),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: _buildMessageText(message),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          // Input area
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Colors.black,
            ),
            child: SafeArea(
              child: Row(
                children: [
                  // Attachment button
                  Container(
                    width: 48,
                    height: 48,
                    decoration: const BoxDecoration(
                      color: Color(0xFF464646),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.attach_file,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Text input
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: const Color(0xFF464646),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: TextField(
                        controller: _controller,
                        focusNode: _focusNode,
                        onSubmitted: _handleInput,
                        keyboardType: TextInputType.number,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: 'Poppins',
                        ),
                        decoration: InputDecoration(
                          hintText: _gameCompleted ? 'Game completed!' : 'Enter digit',
                          hintStyle: const TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                            fontFamily: 'Poppins',
                          ),
                          border: InputBorder.none,
                        ),
                        enabled: _gameActive && !_gameCompleted,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Send button
                  GestureDetector(
                    onTap: _hasText && _gameActive && !_gameCompleted
                        ? () => _handleInput(_controller.text)
                        : null,
                    child: Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: _hasText && _gameActive && !_gameCompleted
                            ? const Color(0xFFDCFF00)
                            : const Color(0xFF464646),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.send,
                        color: _hasText && _gameActive && !_gameCompleted
                            ? Colors.black
                            : Colors.grey,
                        size: 24,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}