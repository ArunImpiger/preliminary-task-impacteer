import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../utils/api_url.dart';
import 'bloc/user_bloc.dart';
import 'bloc/user_event.dart';
import 'bloc/user_state.dart';

class UserDetailsScreen extends StatefulWidget {
  final int userId;

  UserDetailsScreen({required this.userId, super.key});

  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreen();
}

class _UserDetailsScreen extends State<UserDetailsScreen> {
  late UserBloc userBloc;

  @override
  void initState() {
    super.initState();
    userBloc = UserBloc(userRepository: ApiUrl.userRepository);
    userBloc.add(GetUserByIdEvent(widget.userId));
  }

  @override
  void dispose() {
    userBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FBFC),
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: const Text('User Profile', style: TextStyle(fontSize: 24)),
      ),
      body: BlocProvider(
        create: (context) => userBloc,
        child: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            if (state is UserLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is UserLoaded) {
              return Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.blueAccent, Colors.cyanAccent],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Center(
                  child: FadeIn(
                    duration: Duration(seconds: 1),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          BounceInDown(
                            child: CircleAvatar(
                              radius: 50,
                              backgroundImage: CachedNetworkImageProvider(state.user.avatar),
                            ),
                          ),
                          SizedBox(height: 20),
                          FadeInUp(
                            child: Text(
                              "${state.user.firstName} ${state.user.lastName}",
                              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                            ),
                          ),
                          SizedBox(height: 10),
                          FadeInUp(
                            child: Text(
                              state.user.email,
                              style: TextStyle(fontSize: 16, color: Colors.white70),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            } else if (state is UserError) {
              return Center(child: Text(state.message));
            }
            return const Center(child: Text('Fetching user data...'));
          },
        ),
      ),
    );
  }
}
