
abstract class AuthRepository {

  Future<String> signUpWithEmail(String email, String password);

  Future<String> logInWithEmail(String email, String password);

  Future<void> resetPasswordWithEmail(String email);

}