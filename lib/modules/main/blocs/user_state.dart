import 'package:room/models/user.dart';

abstract class UserState {}

class UserLoadedState extends UserState {
  final Stream<User> user;
  // final User user;

  UserLoadedState(this.user);
}

class UserLoadingState extends UserState {}

class UserErrorState extends UserState {
  final String error;

  UserErrorState(this.error);
}