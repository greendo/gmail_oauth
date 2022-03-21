import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gmail_oauth/bloc/auth_bloc.dart';
import 'package:gmail_oauth/bloc/emails_bloc.dart';
import 'package:gmail_oauth/repository/auth_repo.dart';
import 'package:gmail_oauth/repository/auth_repo_impl.dart';
import 'package:gmail_oauth/repository/email_repo.dart';
import 'package:gmail_oauth/repository/email_repo_impl.dart';
import 'package:gmail_oauth/repository/emails_list_repo.dart';
import 'package:gmail_oauth/repository/emails_list_repo_impl.dart';
import 'package:gmail_oauth/ui/email_page.dart';
import 'package:gmail_oauth/ui/emails_page.dart';
import 'package:gmail_oauth/ui/home_page.dart';
import 'package:gmail_oauth/util/token_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    http.Client client = http.Client();
    TokenStorage tokenStorage = TokenStorage();
    GoogleSignIn googleSignIn = GoogleSignIn(
      clientId: '621982300950-45u0v37rg1v501mtkplrf913dpp8qvtf.apps.googleusercontent.com', //web
      scopes: <String>[
        'email',
        'https://mail.google.com/',
        'https://www.googleapis.com/auth/gmail.readonly',
        'https://www.googleapis.com/auth/contacts.readonly',
      ],
    );

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepo>(
          create: (context) => AuthRepoImpl(gSignIn: googleSignIn),
        ),
        RepositoryProvider<EmailRepo>(
          create: (context) =>
              EmailRepoImpl(client: client, tokenStorage: tokenStorage),
        ),
        RepositoryProvider<EmailsListRepo>(
          create: (context) =>
              EmailsListRepoImpl(client: client, tokenStorage: tokenStorage),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
            create: (context) =>
                AuthBloc(context.read<AuthRepo>(), tokenStorage),
          ),
          BlocProvider<EmailsBloc>(
            create: (context) => EmailsBloc(context.read<EmailsListRepo>()),
          ),
        ],
        child: MaterialApp(
          title: 'GMail OAuth',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            textTheme: const TextTheme(
              headline6: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              bodyText2: TextStyle(fontSize: 14.0, fontWeight: FontWeight.normal),
            ),
          ),
          initialRoute: '/',
          routes: {
            '/': (context) => const HomePage(),
            '/emails': (context) => const EmailsPage(),
            '/email': (context) => const EmailPage(),
          },
        ),
      ),
    );
  }
}
