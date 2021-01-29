import 'package:room/models/message.dart';

abstract class ChatState {}

class MessagesLoadedState extends ChatState {
  final Stream<List<Message>> messages;

  MessagesLoadedState(this.messages);
}

class MessagesLoadingState extends ChatState {}

class ChatErrorState extends ChatState {
  final String error;

  ChatErrorState(this.error);
}