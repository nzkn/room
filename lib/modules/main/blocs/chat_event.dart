import 'dart:io';

import 'package:room/models/message.dart';

abstract class ChatEvent {}

class GetChatMessagesEvent extends ChatEvent {}

class PostMessageEvent extends ChatEvent {
  final Message message;

  PostMessageEvent(this.message);
}

class PostImageMessageEvent extends ChatEvent {
  final Message message;
  final File file;

  PostImageMessageEvent(this.message, this.file);
}

class DeleteMessageEvent extends ChatEvent {
  final String messageId;

  DeleteMessageEvent(this.messageId);
}