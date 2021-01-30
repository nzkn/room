import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:room/core/repositories/chat_repository.dart';
import 'package:room/models/message.dart';
import 'package:room/modules/main/blocs/chat_event.dart';
import 'package:room/modules/main/blocs/chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc() : super(MessagesLoadingState());

  final repository = ChatRepository();

  @override
  Stream<ChatState> mapEventToState(ChatEvent event) async* {
    if (event is GetChatMessagesEvent) {
      yield* _mapGetChatMessagesEventToState();
    } else if (event is PostMessageEvent) {
      yield* _mapPostMessageEventToState(event.message);
    } else if (event is PostImageMessageEvent) {
      yield* _mapPostMessageEventToState(event.message);
    }
  }

  Stream<ChatState> _mapGetChatMessagesEventToState() async* {
    try {
      yield MessagesLoadingState();
      Stream<List<Message>> messages = repository.getMessages();
      yield MessagesLoadedState(messages);
    } on PlatformException {
      yield ChatErrorState('Error in ChatBloc!');
    }
  }

  Stream<ChatState> _mapPostMessageEventToState(Message message) async* {
    try {
      await repository.postMessage(message);
    } on PlatformException {
      yield ChatErrorState('Error in ChatBloc!');
    }
  }

  Stream<ChatState> _mapPostImageMessageEventToState() async* {
    try {

    } on PlatformException {
      yield ChatErrorState('Error in ChatBloc!');
    }
  }
}