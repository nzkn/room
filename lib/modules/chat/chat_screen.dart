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
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
      height: 60.0,
      color: Colors.grey.withOpacity(0.6),
      child: Center(
        child: Row(
          children: [
            Expanded(
              child: TextFormField(
                style: TextStyle(
                  color: Colors.black87
                ),
                decoration: InputDecoration(
                  hintText: 'Type your message here...',
                  hintStyle: TextStyle(
                    color: Colors.grey.withOpacity(0.5),
                  ),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.8),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12.0),
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black26),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 15.0),
            GestureDetector(
              onTap: () {},
              child: Icon(Icons.send),
            ),
            const SizedBox(width: 15.0),
            GestureDetector(
              onTap: () {},
              child: Icon(Icons.image),
            ),
          ],
        ),
      ),
    );
  }
}
