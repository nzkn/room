import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:room/core/repositories/database_repository.dart';
import 'package:room/models/user.dart';
import 'package:room/modules/main/blocs/user_event.dart';
import 'package:room/modules/main/blocs/user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserLoadingState());

  final repository = UserRepository();

  @override
  Stream<UserState> mapEventToState(UserEvent event) async* {
    if (event is CreateUserEvent) {
      yield* _mapCreateUserEventToState(event.user);
    } else if (event is UpdateUserName) {
      yield* _mapUpdateUserEventToState(event.name);
    } else if (event is GetUserEvent) {
      yield* _mapGetUserEventToState();
    }
  }

  Stream<UserState> _mapCreateUserEventToState(User newUser) async* {
    try {
      DocumentReference reference = await repository.createUser(newUser);
      String uid = reference.id;
      Stream<User> user = repository.getUser(uid);
      yield UserLoadedState(user);
    } on PlatformException {
      yield UserErrorState('Error in UserBloc!');
    }
  }

  Stream<UserState> _mapUpdateUserEventToState(String name) async* {
    try {
      yield UserLoadingState();
      await repository.updateUserName(name);
      String uid = auth.FirebaseAuth.instance.currentUser.uid;
      Stream<User> user = repository.getUser(uid);
      yield UserLoadedState(user);
    } on PlatformException {
      yield UserErrorState('Error in UserBloc!');
    }
  }

  Stream<UserState> _mapGetUserEventToState() async* {
    try {
      String id = repository.getUserId();
      Stream<User> user = repository.getUser(id);
      yield UserLoadedState(user);
    } on PlatformException {
      yield UserErrorState('Error in UserBloc!');
    }
  }

}