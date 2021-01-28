import 'package:room/models/user.dart';

abstract class UserEvent {}

class CreateUserEvent extends UserEvent {
  final User user;

  CreateUserEvent(this.user);
}

class UpdateUserEvent extends UserEvent {
  final User user;

  UpdateUserEvent(this.user);
}

class GetUserEvent extends UserEvent {}

