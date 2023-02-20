import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:twople_dashboard/firebase_options.dart';
import 'package:twople_dashboard/models/placemodel.dart';
import 'package:twople_dashboard/screens/addplace.dart';
import 'package:twople_dashboard/screens/bookings.dart';
import 'package:twople_dashboard/screens/place.dart';

const Color mainColor = Color.fromARGB(280, 119, 114, 114),
    lightColor = Color(0XFFFFFFFF);
List<String> days = [
  "Mon",
  "Tue",
  "Wed",
  "Thr",
  "Fri",
  "Sat",
  "Sun",
];
List<String> tcats = [
  "Eat-out",
  "Surprise Me!",
  "Roam Around",
  "Stays",
];
List<String> tmoods = [
  "Creative",
  "Lazy",
  "Pampered",
  "Adventurous",
];
List<String> tprefs = [
  "Budget Friendly",
  "Our Vibe",
  "Sophisticated",
  "Special Day",
];

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
      title: 'Twople Experience - Dashboard',
      routes: {
        '/': (context) => const DashBoard(),
        '/add': (context) => const CreateExperience(),
        '/bookings': (context) => const BookingsPage(),
        '/404': (context) => const NotFound(),
      },
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) => const NotFound(),
        );
      },
      initialRoute: '/',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}

class NotFound extends StatelessWidget {
  const NotFound({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Not Found!"),
      ),
    );
  }
}

class Loader extends StatelessWidget {
  final String pid;
  const Loader({super.key, required this.pid});

  @override
  Widget build(BuildContext context) {
    Future(() {
      FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
      firebaseFirestore
          .collection("collectionPath")
          .doc(pid)
          .get()
          .then((value) {
        if (value.exists) {
          Navigator.pushNamed(context, "/$pid", arguments: {value});
        } else {
          Navigator.pushNamed(context, "404");
        }
      });
    });
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  late FirebaseFirestore firebaseFirestore;
  @override
  void initState() {
    firebaseFirestore = FirebaseFirestore.instance;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFF130021),
      appBar: AppBar(
        backgroundColor: Colors.black12,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Image.network(
                "https://static.wixstatic.com/media/9cf951_224e46bd6d1d4914b9a90e0be466a13d~mv2.png/v1/fill/w_201,h_50,al_c,q_85,usm_0.66_1.00_0.01,enc_auto/Twople_Logo_-_Black-3-removebg-preview.png")
          ],
        ),
        actions: [
          IconButton(
            onPressed: () => Navigator.pushNamed(context, "/add"),
            icon: const Icon(CupertinoIcons.add),
          ),
          const SizedBox(
            width: 10,
          ),
          IconButton(
            onPressed: () => Navigator.pushNamed(context, "/bookings"),
            icon: const Icon(CupertinoIcons.list_bullet_indent),
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: firebaseFirestore.collection("twopleExperiences").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }
          if (snapshot.hasData) {
            final data = snapshot.data;
            return GridView(
              padding: const EdgeInsets.all(15),
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 370,
                mainAxisSpacing: 15,
                crossAxisSpacing: 15,
              ),
              children: data!.docs
                  .map(
                    (e) => PlaceEditTile(placeObj: PlaceObj.fromFB(e)),
                  )
                  .toList(),
            );
          }
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.black,
            ),
          );
        },
      ),
    );
  }
}
