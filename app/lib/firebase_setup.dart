import 'package:app/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

Future<FirebaseApp> initializeFirebase() {
  return Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

Future<UserCredential> signInAnonymously() async {
  final auth = FirebaseAuth.instance;
  final userCredential = await auth.signInAnonymously();
  return userCredential;
}