import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  Text('AAA'),
                ],
              ),
            ),
            _buildChatWidget(),
          ],
        ),
      ),
    );
  }

  Widget _buildChatWidget() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      height: 50.0,
      color: Colors.grey.withOpacity(0.4),
      child: Center(
        child: Row(
          children: [],
        ),
      ),
    );
  }
}
