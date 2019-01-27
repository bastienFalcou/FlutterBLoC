import 'package:flutter/material.dart';
import 'package:bloc_test/Screens/RandomWords.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_test/Blocs/AuthenticationBloc.dart';

class Authentication extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthenticationBloc authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);

    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Authentication'),
        actions: <Widget>[
          new IconButton(icon: const Icon(Icons.list), onPressed: () {
            _pushSaved(context);
          }),
        ],
      ),
      body: Center(
        child: Text("Placeholder"),
      ),
    );
  }

  void _pushSaved(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RandomWordsList()),
    );
  }
}
