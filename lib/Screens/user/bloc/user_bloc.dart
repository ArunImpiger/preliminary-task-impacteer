import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../models/user_model.dart';
import '../../../repository/user_repo.dart';
import 'user_event.dart';
import 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;

  UserBloc({required this.userRepository}) : super(UserInitial()) {
    on<FetchUsersList>(_onFetchUsersList);
    on<GetUserByIdEvent>(_getUserById);
  }

  void _onFetchUsersList(FetchUsersList event, Emitter<UserState> emit) async {
    final currentState = state;
    try {
      if (currentState is UserInitial) {
        final users = await userRepository.fetchUsers(event.page);
        emit(UserListLoaded(users: users, hasReachedMax: users.isEmpty));
      } else if (currentState is UserListLoaded) {
        final nextPage = currentState.users.length ~/ 6 + 1;
        final users = await userRepository.fetchUsers(nextPage);
        emit(users.isEmpty
            ? currentState.copyWith(hasReachedMax: true)
            : UserListLoaded(
          users: currentState.users + users,
          hasReachedMax: false,
        ));
      }
    } catch (_) {
      emit(UserError('Failed to fetch users'));
    }
  }

  void _getUserById(GetUserByIdEvent event, Emitter<UserState> emit) async {
    emit(UserLoading());
    try {
      User data = await userRepository.getUserById(event.userId);
      emit(UserLoaded(user: data));
    } catch (_) {
      emit(const UserError('Failed to fetch user'));
    }
  }

  }
