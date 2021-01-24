import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:room/modules/auth/blocs/auth_bloc/auth_event.dart';
import 'package:room/modules/auth/blocs/auth_bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthLoadingState());

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is SignInWithEmailEvent) {
      yield* _mapSignInWithEmailEventToState();
    } else if (event is SignUpWithEmailEvent) {
      yield* _mapSignUpWithEmailEventToState();
    }
  }

  Stream<AuthState> _mapSignInWithEmailEventToState() async* {
    try {

    } on FirebaseAuthException catch (error) {

    }
  }

  Stream<AuthState> _mapSignUpWithEmailEventToState() async* {
    try {

    } on FirebaseAuthException catch (error) {

    }
  }
}