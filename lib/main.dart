import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:twople_dashboard/firebase_options.dart';
import 'package:twople_dashboard/screens/home.dart';

const Color mainColor = Color.fromARGB(255, 119, 114, 114),
    lightColor = Color(0XFFFFFFFF);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Twople Places',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}





/*
firebase_core: ^1.21.1
firebase_storage: ^10.3.7
cloud_firestore: ^3.4.6
file_picker: ^5.0.1
*/