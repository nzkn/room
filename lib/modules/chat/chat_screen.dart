import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:room/models/message.dart';
import 'package:room/modules/main/blocs/chat_bloc.dart';
import 'package:room/modules/main/blocs/chat_event.dart';
import 'package:room/modules/main/blocs/chat_state.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  DateFormat format = DateFormat('EEE HH:mm');

  @override
  void initState() {
    _controller.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: _buildMessagesList(),
            ),
            _buildChatWidget(),
          ],
        ),
      ),
    );
  }

  Widget _buildMessagesList() {
    return BlocBuilder<ChatBloc, ChatState>(
      builder: (context, state) {
        if (state is MessagesLoadedState) {
          return StreamBuilder(
            stream: state.messages,
            builder: (context, snapshot) {
              if (snapshot.hasError || snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return ListView.separated(
                  itemCount: snapshot.data.length,
                  reverse: true,
                  itemBuilder: (context, index) {
                    return _buildMessageWidget(snapshot.data[index]);
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(height: 12.0);
                  },
                  padding: const EdgeInsets.all(12.0),
                );
              }
            },
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget _buildMessageWidget(Message message) {
    if (FirebaseAuth.instance.currentUser.uid == message.userId) {
      return Row(
        children: [
          const SizedBox(width: 30.0),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.4),
                borderRadius: BorderRadius.all(Radius.circular(4.0)),
              ),
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          message?.message ?? '',
                          style: TextStyle(
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        message?.createdAt != null
                            ? format.format(DateTime.parse(message.createdAt)).toString()
                            : '',
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 12.0,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 10.0),
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(15.0)
            ),
          ),
        ],
      );
    } else {
      return Row(
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(15.0)
            ),
          ),
          const SizedBox(width: 10.0),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.1),
                borderRadius: BorderRadius.all(Radius.circular(4.0)),
              ),
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  if (message?.nickname != null && (message?.nickname?.isNotEmpty ?? false))
                    Row(
                      children: [
                        Text(
                          message.nickname,
                          style: TextStyle(
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          message?.message ?? '',
                          style: TextStyle(
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        message?.createdAt != null
                            ? format.format(DateTime.parse(message.createdAt)).toString()
                            : '',
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 12.0,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 30.0),
        ],
      );
    }

  }

  Widget _buildChatWidget() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
      height: 60.0,
      color: Colors.grey.withOpacity(0.4),
      child: Center(
        child: Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: _controller,
                style: TextStyle(
                  color: Colors.black87
                ),
                decoration: InputDecoration(
                  hintText: 'Type your message here...',
                  hintStyle: TextStyle(
                    color: Colors.grey.withOpacity(0.7),
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
              onTap: _onMessageSendTap,
              child: Icon(Icons.send),
            ),
            const SizedBox(width: 15.0),
            GestureDetector(
              onTap: _onImagePickTap,
              child: Icon(Icons.image),
            ),
          ],
        ),
      ),
    );
  }

  void _onMessageSendTap() {
    if (_controller.text.trim().isNotEmpty) {
      FocusScope.of(context).unfocus();
      context.read<ChatBloc>().add(
        PostMessageEvent(
          Message(_controller.text, FirebaseAuth.instance.currentUser.uid,
              '', DateTime.now().toString()),
        ),
      );
      _controller.clear();
    }
  }

  void _onImagePickTap() async {
    File _image;
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }
}
