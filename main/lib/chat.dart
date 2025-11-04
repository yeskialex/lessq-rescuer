import 'package:flutter/material.dart';

class Message {
  final String text;
  final bool isFromUser;
  final bool isSystemMessage;

  Message({
    required this.text,
    required this.isFromUser,
    this.isSystemMessage = false,
  });
}

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _controller = TextEditingController();
  final List<int> _targetCode = [5, 2, 3, 2];
  int _currentPosition = 0;
  bool _gameActive = false;
  bool _gameCompleted = false;
  final List<Message> _messages = [];

  final List<String> _sectionPrompts = [
    'We have a partial signal. Let\'s begin. Proceed to **Section WT** on your map. Find the **[STICKERS icon]** and report the number underneath.',
    'New signal acquired. Proceed to **Section EG**. Find the **[TENT icon]** and report the number underneath.',
    'Acquiring third location. Proceed to **Section KD**. Find the **[FLOWER icon]** and report the number underneath.',
    'Final signal. Proceed to **Section NZ**. Find the **[TREE icon]** and report the number underneath.',
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
        } else {
          _messages.add(Message(
            text: _sectionPrompts[_currentPosition],
            isFromUser: false,
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
  }

  String _getSectionName(int position) {
    const sections = ['Section WT', 'Section EG', 'Section KD', 'Section NZ'];
    return sections[position];
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];

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
                    child: Text(
                      message.isFromUser ? message.text : '[119 Dispatcher] ${message.text}',
                      style: TextStyle(
                        color: message.isFromUser ? Colors.black : Colors.white,
                        fontSize: 16,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                        height: 1.5,
                      ),
                    ),
                  ),
                );
              },
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
                        onSubmitted: _handleInput,
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
                  // Voice button
                  Container(
                    width: 48,
                    height: 48,
                    decoration: const BoxDecoration(
                      color: Color(0xFF464646),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.mic,
                      color: Colors.white,
                      size: 24,
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