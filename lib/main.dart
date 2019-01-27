import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_test/Screens/Home.dart';
import 'package:bloc_test/Helpers/SimpleBlocDelegate.dart';
import 'package:bloc_test/Helpers/User.dart';
import 'package:bloc_test/Blocs/AuthenticationBloc.dart';
import 'package:bloc_test/Model/AuthenticationEvent.dart';
import 'package:bloc_test/Model/AuthenticationState.dart';
import 'package:bloc_test/Screens/Login.dart';
import 'package:bloc_test/Views/LoadingIndicator.dart';

void main() {
  BlocSupervisor().delegate = SimpleBlocDelegate();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  final userRepository = UserRepository();

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AuthenticationBloc authenticationBloc;
  UserRepository get userRepository => widget.userRepository;

  @override
  void initState() {
    authenticationBloc = AuthenticationBloc(userRepository: userRepository);
    authenticationBloc.dispatch(AppStarted());
    super.initState();
  }

  @override
  void dispose() {
    authenticationBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthenticationBloc>(
      bloc: authenticationBloc,
      child: MaterialApp(
        home: BlocBuilder<AuthenticationEvent, AuthenticationState>(
          bloc: authenticationBloc,
          builder: (BuildContext context, AuthenticationState state) {
            if (state is AuthenticationUninitialized || state is AuthenticationUnauthenticated) {
              return LoginPage(userRepository: userRepository);
            }
            if (state is AuthenticationLoading) {
              return LoadingIndicator();
            }
            if (state is AuthenticationAuthenticated) {
              return Home();
            }
          },
        ),
      ),
    );
  }
}
