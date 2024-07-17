
import 'package:equatable/equatable.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class FetchUsersList extends UserEvent {
  final int page;

  const FetchUsersList(this.page);

  @override
  List<Object> get props => [page];
}

class GetUserByIdEvent extends UserEvent {
  final int userId;
  const GetUserByIdEvent(this.userId);

  @override
  List<Object> get props => [userId];
}
