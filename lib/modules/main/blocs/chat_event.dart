import 'package:room/models/message.dart';

abstract class ChatEvent {}

class GetChatMessagesEvent extends ChatEvent {}

class PostMessageEvent extends ChatEvent {
  final Message message;

  PostMessageEvent(this.message);
}
