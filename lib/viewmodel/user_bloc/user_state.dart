import 'package:equatable/equatable.dart';
import 'package:shophomework/model/user.dart';

abstract class UserState extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class UserInitialState extends UserState {
  UserInitialState();
}

class UserLoadingState extends UserState {
  UserLoadingState();
}

class UserLoadedState extends UserState {
  final List<UserModel> userlist;
  UserLoadedState(this.userlist);

  @override
  List<Object?> get props => [userlist];
}

class UserErrorState extends UserState {
  final String error;
  UserErrorState(this.error);

  @override
  List<Object?> get props => [error];
}
