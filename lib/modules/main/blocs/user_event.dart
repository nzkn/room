import 'dart:io';

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

class UpdateUserAvatar extends UserEvent {
  final File file;

  UpdateUserAvatar(this.file);
}

class GetUserEvent extends UserEvent {}

class GetOtherUserEvent extends UserEvent {
  final String userId;

  GetOtherUserEvent(this.userId);

}

