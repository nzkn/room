import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:room/models/message.dart';
import 'package:room/models/user.dart';
import 'package:room/modules/chat/widgets/my_message_widget.dart';
import 'package:room/modules/chat/widgets/user_message_wdget.dart';
import 'package:room/modules/main/blocs/blocs.dart';
import 'package:room/modules/main/blocs/chat_bloc.dart';
import 'package:room/modules/main/blocs/chat_event.dart';
import 'package:room/modules/main/blocs/chat_state.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();

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
                  physics: BouncingScrollPhysics(),
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
    if (auth.FirebaseAuth.instance.currentUser.uid == message.userId) {
      return MyMessageWidget(message);
    } else {
      return UserMessageWidget(message);
    }
  }

  Widget _buildChatWidget() {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is UserLoadedState) {
          return StreamBuilder(
            stream: state.user,
            builder: (context, snapshot) {
              if (snapshot.hasError ||
                  snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                final User user = snapshot.data;
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
                            style: TextStyle(color: Colors.black87),
                            decoration: InputDecoration(
                              hintText: 'Type your message here...',
                              hintStyle: TextStyle(
                                color: Colors.grey.withOpacity(0.7),
                              ),
                              filled: true,
                              fillColor: Colors.white.withOpacity(0.8),
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 12.0),
                              border: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black26),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 15.0),
                        GestureDetector(
                          onTap: () => _onMessageSendTap(user),
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

  void _onMessageSendTap(User user) {
    if (_controller.text.trim().isNotEmpty) {
      FocusScope.of(context).unfocus();
      context.read<ChatBloc>().add(
        PostMessageEvent(
          Message(_controller.text, user.id, user.fullName, DateTime.now().toString()),
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
