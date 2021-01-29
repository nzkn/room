import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:room/models/user.dart';

class UserRepository {

  final usersCollection = FirebaseFirestore.instance.collection('users');

  Future<DocumentReference> createUser(User user) async {
    await usersCollection.doc(user.id).set(user.toJson());
    return usersCollection.doc(user.id);
  }

  Future<void> updateUser(User user) {
    return usersCollection.doc(user.id).update(user.toJson());
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