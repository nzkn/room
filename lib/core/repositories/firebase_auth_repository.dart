import 'package:firebase_auth/firebase_auth.dart';
import 'package:room/core/repositories/auth_repository.dart';

class FirebaseAuthRepository implements AuthRepository {

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<String> signUpWithEmail(String email, String password) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      return userCredential?.user?.uid;
    } on FirebaseAuthException catch (e) {
      print(e.message);
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<String> logInWithEmail(String email, String password) async {
    try {
      final userCredential =  await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      return userCredential?.user?.uid;
    } on FirebaseAuthException catch (e) {
      print(e.message);
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<void> resetPasswordWithEmail(String email) async {
    try {
      return await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      print(e.message);
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<void> signOut() async {
    try {
      return await _firebaseAuth.signOut();
    } on FirebaseAuthException catch (e) {
      print(e.message);
    } catch (e) {
      print(e);
    }
  }

}