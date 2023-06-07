import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> initializeFirebase() async {
  await Firebase.initializeApp();
}

Future<UserCredential> signInAnonymously() async {
  final auth = FirebaseAuth.instance;
  final userCredential = await auth.signInAnonymously();
  return userCredential;
}