import '../repository/user_repo.dart';

class ApiUrl{
  static final UserRepository userRepository =
  UserRepository(baseUrl: 'https://reqres.in/api/users');
}