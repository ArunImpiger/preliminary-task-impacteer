import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:preliminary_task/utils/api_url.dart';
import 'Screens/user/bloc/user_bloc.dart';
import 'Screens/user/bloc/user_event.dart';
import 'Screens/user/user_list_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {


  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Preliminary',
      home: BlocProvider(
        create: (context) =>
            UserBloc(userRepository: ApiUrl.userRepository)..add(const FetchUsersList(1)),
        child: UserListScreen(),
      ),
    );
  }
}

