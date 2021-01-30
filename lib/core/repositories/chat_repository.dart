import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:room/models/message.dart';
import 'package:rxdart/rxdart.dart';

class ChatRepository {
  final chatCollection = FirebaseFirestore.instance.collection('chat');

  Future<DocumentReference> postMessage(Message message) async {
    DocumentReference reference = await chatCollection.add(message.toJson());
    return chatCollection.doc(reference.id);
  }

  Stream<List<Message>> getMessages() {
    final messages = FirebaseFirestore.instance
        .collection('chat')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((data) {
      return data.docs.map((doc) {
        return Message.fromJson(doc.data());
      }).toList();
    });

    return ValueConnectableStream(messages).autoConnect();
  }

  Future<DocumentReference> uploadMessageImage(File image, Message message) async {
    String imageUrl;
    Reference reference = FirebaseStorage.instance.ref(message.userId).child('messages/${message.userId}/${DateTime.now().millisecondsSinceEpoch}');
    return reference.putFile(image).then((snapshot) async {
      imageUrl = await snapshot.ref.getDownloadURL();

      Message newMessage = Message(
        message.userId,
        message.nickname,
        message.createdAt,
        image: imageUrl,
      );
      DocumentReference reference = await chatCollection.add(newMessage.toJson());
      return chatCollection.doc(reference.id);
    });

  }
}