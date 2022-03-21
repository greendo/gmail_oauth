import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gmail_oauth/bloc/email_bloc.dart';
import 'package:gmail_oauth/model/email.dart';
import 'package:gmail_oauth/repository/email_repo.dart';
import 'package:gmail_oauth/util/net_states.dart';

class EmailPage extends StatelessWidget {
  const EmailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Email'),
      ),
      body: BlocProvider(
        create: (context) => EmailBloc(context.read<EmailRepo>()),
        child: BlocBuilder<EmailBloc, NetStates>(
          builder: (context, state) {
            switch (state) {
              case NetStates.initial:
                context.read<EmailBloc>().add(EmailEvent(id));
                return const Center(child: Text('fetching...'));
              case NetStates.loading:
                return const Center(child: CircularProgressIndicator());
              case NetStates.success:
                return _EmailContainer(email: context.read<EmailBloc>().email!);
              case NetStates.error:
                return const Center(child: Text('error'));
            }
          },
        ),
      ),
    );
  }
}

class _EmailContainer extends StatelessWidget {
  final Email email;

  const _EmailContainer({required this.email});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Id: ${email.id}',
              style: Theme.of(context).textTheme.headline6,
            ),
            const SizedBox(height: 16.0),
            Text(
              'Snippet: ${email.snippet}',
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ],
        ),
      ),
    );
  }
}
