import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_test/Blocs/LoginBloc.dart';
import 'package:bloc_test/Blocs/AuthenticationBloc.dart';
import 'package:bloc_test/Model/LoginEvent.dart';
import 'package:bloc_test/Model/LoginState.dart';

class LoginForm extends StatefulWidget {
  final LoginBloc loginBloc;
  final AuthenticationBloc authenticationBloc;

  LoginForm({
    Key key,
    @required this.loginBloc,
    @required this.authenticationBloc,
  }) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  LoginBloc get _loginBloc => widget.loginBloc;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginEvent, LoginState>(
      bloc: _loginBloc,
      builder: (
          BuildContext context,
          LoginState state,
          ) {
        if (state is LoginFailure) {
          _onWidgetDidBuild(() {
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text('${state.error}'),
                backgroundColor: Colors.red,
              ),
            );
          });
        }

        return Container(
          padding: EdgeInsets.all(20.0),
          child: Form(
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: 'username'),
                  controller: _usernameController,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'password'),
                  controller: _passwordController,
                  obscureText: true,
                ),
                Divider(
                  height: 24.0,
                  color: Colors.transparent,
                ),
                RaisedButton(
                  onPressed:
                  state is! LoginLoading ? _onLoginButtonPressed : null,
                  child: Text('Login'),
                ),
                Divider(
                  height: 24.0,
                  color: Colors.transparent,
                ),
                Container(
                  child:
                  state is LoginLoading ? CircularProgressIndicator() : null,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _onWidgetDidBuild(Function callback) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      callback();
    });
  }

  _onLoginButtonPressed() {
    _loginBloc.dispatch(LoginButtonPressed(
      username: _usernameController.text,
      password: _passwordController.text,
    ));
  }
}