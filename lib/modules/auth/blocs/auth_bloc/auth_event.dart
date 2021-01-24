abstract class AuthEvent {}

class SignUpWithEmailEvent extends AuthEvent {
  final String email;
  final String password;

  SignUpWithEmailEvent(this.email, this.password);
}

class SignInWithEmailEvent extends AuthEvent {
  final String email;
  final String password;

  SignInWithEmailEvent(this.email, this.password);
}

