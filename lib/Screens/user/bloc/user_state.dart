import 'package:equatable/equatable.dart';
import '../../../models/user_model.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserListLoaded extends UserState {
  final List<User> users;
  final bool hasReachedMax;

  const UserListLoaded({required this.users, this.hasReachedMax = false});

  UserListLoaded copyWith({
    List<User>? users,
    bool? hasReachedMax,
  }) {
    return UserListLoaded(
      users: users ?? this.users,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [users, hasReachedMax];
}

class UserLoaded extends UserState {
  final User user;

  const UserLoaded({required this.user});

  @override
  List<Object> get props => [user];
}

class UserError extends UserState {
  final String message;

  const UserError(this.message);

  @override
  List<Object> get props => [message];
}
