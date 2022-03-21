import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gmail_oauth/bloc/emails_bloc.dart';
import 'package:gmail_oauth/model/email_id.dart';
import 'package:gmail_oauth/util/net_states.dart';

class EmailsPage extends StatelessWidget {
  const EmailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Emails'),
      ),
      body: Center(
        child: BlocBuilder<EmailsBloc, NetStates>(
          builder: (context, state) {
            switch (state) {
              case NetStates.initial:
                context.read<EmailsBloc>().add(EmailsEvent());
                return const Center(
                  child: Text('fetching...'),
                );
              case NetStates.loading:
                return const CircularProgressIndicator();
              case NetStates.success:
                return RefreshIndicator(
                  onRefresh: () async {
                    context.read<EmailsBloc>().add(EmailsEvent());
                  },
                  child: _EmailsList(ids: context.read<EmailsBloc>().ids),
                );
              case NetStates.error:
                return const Text('error');
            }
          },
        ),
      ),
    );
  }
}

class _EmailsList extends StatelessWidget {
  final List<EmailId>? ids;

  const _EmailsList({required this.ids});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: ids!.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
            child: InkWell(
              onTap: () {
                Navigator.of(context)
                    .pushNamed('/email', arguments: ids![index].id);
              },
              child: SizedBox(
                width: double.infinity,
                height: 48.0,
                child: Center(
                    child: Text(
                  'id: ${ids![index].id}',
                  style: Theme.of(context).textTheme.headline6,
                )),
              ),
            ),
          );
        });
  }
}
