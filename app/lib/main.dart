import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'firebase_setup.dart';
import 'package:app/controllers/auth_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeFirebase();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Digital Journal',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Digital Journal'),
      ),
      body: Center(
        child: authState.when(
          data: (authState) {
            if (authState != null) {
              return Text('Welcome to the Digital Journal, ${authState.currentUser.id}');
            } else {
              return const Text('Welcome to the Digital Journal!');
            }
          },
          loading: () => const CircularProgressIndicator(),
          error: (err, st) => Text('An error occured while signing in: $err'),
        ),
      ),
    );
  }
}
