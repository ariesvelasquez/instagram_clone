import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone/firebase_options.dart';

import 'dart:developer' as devtools show log;

import 'package:instagram_clone/state/auth/providers/auth_state_provider.dart';
import 'package:instagram_clone/state/auth/providers/is_logged_in_provider.dart';

extension Log on Object {
  void log() => devtools.log(toString());
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const ProviderScope(
      child: App(),
    ),
  );
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      darkTheme: ThemeData.dark(
        useMaterial3: true,
      ),
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
      ),
      themeMode: ThemeMode.dark,
      home: Consumer(
        builder: (context, ref, child) {
          final isLoggedIn = ref.watch(isLoggedInProvider);
          if (isLoggedIn) {
            return const MainView();
          } else {
            return const LoginView();
          }
        },
      ),
    );
  }
}

class MainView extends StatelessWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Main View'),
        ),
        floatingActionButton: Consumer(
          builder: (context, ref, child) {
            return FloatingActionButton(
              onPressed: ref.read(authStateProvider.notifier).logOut,
              child: const Icon(Icons.add),
            );
          },
        ));
  }
}

class LoginView extends ConsumerWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login View'),
      ),
      body: Column(
        children: [
          TextButton(
            onPressed: ref.read(authStateProvider.notifier).loginWithGoogle,
            child: const Text('Sign In with Google'),
          ),
          TextButton(
            onPressed: ref.read(authStateProvider.notifier).loginWithFacebook,
            child: const Text('Sign In with FaceBook'),
          ),
        ],
      ),
    );
  }
}
