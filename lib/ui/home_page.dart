import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gmail_oauth/bloc/auth_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: BlocBuilder<AuthBloc, bool>(
          builder: (context, authenticated) {
            return authenticated ? _gotoEmails(context) : _auth(context);
          },
        ),
      ),
    );
  }

  MaterialButton _auth(BuildContext context) {
    return MaterialButton(
        child: const Text('authorize'),
        color: Colors.blue,
        onPressed: () {
          context.read<AuthBloc>().add(AuthEvent());
        });
  }

  MaterialButton _gotoEmails(BuildContext context) {
    return MaterialButton(
        child: const Text('go to emails'),
        color: Colors.blue,
        onPressed: () {
          Navigator.of(context).pushNamed('/emails');
        });
  }
}
