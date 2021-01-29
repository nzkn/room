import 'package:room/models/user.dart';

abstract class UserEvent {}

class CreateUserEvent extends UserEvent {
  final User user;

  CreateUserEvent(this.user);
}

class UpdateUserName extends UserEvent {
  final String name;

  UpdateUserName(this.name);
}

class GetUserEvent extends UserEvent {}

