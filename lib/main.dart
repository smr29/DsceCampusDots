import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/current_user.dart';
// ignore: unused_import
import 'package:flutter_application_1/screens/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_application_1/services/auth.dart';
// ignore: unused_import
import 'package:flutter_application_1/splash.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<CurrentUser?>.value(
      value: AuthService().currentUser,
      initialData: null,
      child: const MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     // Replace with actual values
//     options: const FirebaseOptions(
//       apiKey: "AIzaSyDDP4zxPYRs4afstLBdwaDWN_-3Z_dvUig",
//       appId: "1:380926653855:android:98d7297b1dec0b1bf379aa",
//       messagingSenderId: "380926653855",
//       projectId: "dsce-project",
//     ),
//   );
//   runApp(const MyApp());
// }
