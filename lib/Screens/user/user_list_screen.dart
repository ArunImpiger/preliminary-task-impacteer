import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:preliminary_task/Screens/user/user_details_screen.dart';
import 'bloc/user_bloc.dart';
import 'bloc/user_event.dart';
import 'bloc/user_state.dart';

class UserListScreen extends StatefulWidget {
  @override
  _UserListScreenState createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FBFC),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF9FBFC),
        title: const Text('Users List'),
      ),
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UserInitial) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: SpinKitThreeBounce(
                  color: Colors.purple,
                  size: 40,
                ),
              ),
            );
          } else if (state is UserListLoaded) {
            WidgetsBinding.instance
                .addPostFrameCallback((_) => _checkIfNeedsMoreData(state));
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: ListView.builder(
                controller: _scrollController,
                itemCount: state.users.length + 1,
                itemBuilder: (context, index) {
                  if (index >= state.users.length) {
                    return state.hasReachedMax
                        ? const Center(
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text('No more data'),
                            ),
                          )
                        : const Center(
                            child: Padding(
                              padding: EdgeInsets.all(10.0),
                              child: SpinKitThreeBounce(
                                color: Colors.purple,
                                size: 40,
                              ),
                            ),
                          );
                  } else {
                    final user = state.users[index];
                    return Container(
                      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5)),
                        border: Border.all(width: 1, color: Color(0xFFF5F5F5)),
                      ),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UserDetailsScreen(
                                  userId: state.users[index].id),
                            ),
                          );
                        },
                        child: ListTile(
                          leading: CircleAvatar(
                            radius: 30,
                            backgroundImage: Image.network(user.avatar).image,
                          ),
                          title: Text(
                            '${user.firstName} ${user.lastName}',
                            style: const TextStyle(
                                fontFamily: 'SF-Pro',
                                fontWeight: FontWeight.w700),
                          ),
                          subtitle: Text(user.email,style: const TextStyle(
                              fontFamily: 'SF-Pro',
                              fontWeight: FontWeight.w500),),
                          trailing: const Icon(Icons.more_horiz),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 10),
                        ),
                      ),
                    );
                  }
                },
              ),
            );
          } else if (state is UserError) {
            return const Center(child: Text('Failed to fetch users'));
          }
          return Container();
        },
      ),
    );
  }

  void _onScroll() {
    if (_isBottom) context.read<UserBloc>().add(FetchUsersList(1));
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    return currentScroll >= maxScroll * 0.9;
  }

  void _checkIfNeedsMoreData(UserListLoaded state) {
    if (!_scrollController.hasClients) return;
    final screenHeight = MediaQuery.of(context).size.height;
    final contentHeight = _scrollController.position.viewportDimension +
        _scrollController.position.maxScrollExtent;
    if (contentHeight < screenHeight && !state.hasReachedMax) {
      context.read<UserBloc>().add(FetchUsersList(state.users.length ~/ 6 + 1));
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
