import 'package:flutter/material.dart';
import 'package:bloc_test/Screens/RandomWords.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_test/Blocs/AuthenticationBloc.dart';
import 'package:bloc_test/Model/AuthenticationEvent.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthenticationBloc authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);

    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Home'),
        actions: <Widget>[
          new IconButton(icon: const Icon(Icons.list), onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => RandomWordsList()),
            );
          }),
        ],
      ),
      body: Container(
        child: Center(
            child: RaisedButton(
              child: Text('logout'),
              onPressed: () {
                authenticationBloc.dispatch(LoggedOut());
              },
            )),
      ),
    );
  }
}
