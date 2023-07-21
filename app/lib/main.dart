import 'dart:io';

import 'package:app/common/async_widget.dart';
import 'package:app/observers/initialize_observers.dart';
import 'package:app/views/navigation_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'firebase_setup.dart';
import 'package:app/controllers/auth_controller.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

void main() async {
  await dotenv.load();
  WidgetsFlutterBinding.ensureInitialized();
  await initializeFirebase();

  if (Platform.isIOS) {
    await FirebaseMessaging.instance.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  runApp(const ProviderScope(child: App()));
}

class App extends ConsumerStatefulWidget {
  const App({super.key});

  @override
  ConsumerState<App> createState() => _AppState();
}

class _AppState extends ConsumerState<App> {
  @override
  void initState() {
    super.initState();

    initializeObservers(ref);
    
    FirebaseMessaging.onMessageOpenedApp.listen((message) =>
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: build),
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Digital Journal',
      home: const HomeWidget(),
      theme: ThemeData.from(colorScheme: ColorScheme.fromSeed(
        seedColor: const Color.fromARGB(255, 184, 219, 217))
      ),
    );
  }
}

class HomeWidget extends ConsumerWidget {
  const HomeWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncAuthState = ref.watch(authControllerProvider);

    return Scaffold(
      body: AsyncWidget(
        asyncValue: asyncAuthState,
        buildWidget: (authState) {
          if (authState != null) {
            return const NavigationView();
          } else {
            return const Text('Welcome to the Digital Journal!');
          }
        }
      ),
    );
  }
}
