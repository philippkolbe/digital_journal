import 'package:app/common/async_widget.dart';
import 'package:app/observers/initialize_observers.dart';
import 'package:app/views/navigation_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'firebase_setup.dart';
import 'package:app/controllers/auth_controller.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load();
  WidgetsFlutterBinding.ensureInitialized();
  await initializeFirebase();
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
    initializeObservers(ref);
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Digital Journal',
      home: HomeWidget(),
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
