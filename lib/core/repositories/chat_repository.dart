import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:room/models/message.dart';
import 'package:rxdart/rxdart.dart';

class ChatRepository {
  final chatCollection = FirebaseFirestore.instance.collection('chat');

  Future<DocumentReference> postMessage(Message message) async {
    DocumentReference reference = await chatCollection.add(message.toJson());
    return chatCollection.doc(reference.id);
  }

  Stream<List<Message>> getMessages() {
    final messages = FirebaseFirestore.instance.collection('chat').snapshots().map((data) {
      return data.docs.map((doc) {
        return Message.fromJson(doc.data());
      }).toList();
    });

    return ValueConnectableStream(messages).autoConnect();
  }




}