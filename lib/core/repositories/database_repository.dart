import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:room/models/user.dart';

class UserRepository {

  final usersCollection = FirebaseFirestore.instance.collection('users');

  Future<DocumentReference> createUser(User user) async {
    await usersCollection.doc(user.id).set(user.toJson());
    return usersCollection.doc(user.id);
  }

  Future<void> updateUserName(String name) {
    return usersCollection.doc(auth.FirebaseAuth.instance.currentUser.uid).update({'fullName' : name});
  }

  Future<void> updateUserAvatar(String id, File image) async {
    Reference reference = FirebaseStorage.instance.ref(id).child(id);
    reference.putFile(image).then((snapshot) async {
      snapshot.ref.getDownloadURL().then((value) {
        usersCollection.doc(auth.FirebaseAuth.instance.currentUser.uid).update({'image' : value});
      });
    });
  }

  Stream<User> getUser(String id) {
    return FirebaseFirestore.instance.collection('users').doc(id).snapshots().map((doc) {
      return User.fromJson(doc.data());
    });
  }

  String getUserId() {
    return auth.FirebaseAuth.instance.currentUser.uid;
  }
}