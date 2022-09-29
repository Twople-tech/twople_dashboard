import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:twople_dashboard/models/placemodel.dart';
import 'package:twople_dashboard/screens/addplace.dart';
import 'package:twople_dashboard/screens/place.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late FirebaseFirestore _firestore;
  late FirebaseStorage _storage;
  @override
  void initState() {
    _firestore = FirebaseFirestore.instance;
    _storage = FirebaseStorage.instance;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Twople Places"),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) => const UploadPlace(),
          ),
        ),
        child: const Icon(CupertinoIcons.add),
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: _firestore
            .collection("experiences")
            .where("Partnership", isNotEqualTo: "")
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }
          if (snapshot.hasData) {
            final data = snapshot.requireData;
            return GridView(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 370,
              ),
              children: data.docs
                  .map(
                    (e) => PlaceTile(
                      queryDocumentSnapshot: e,
                      firebaseFirestore: _firestore,
                      firebaseStorage: _storage,
                    ),
                  )
                  .toList(),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

class PlaceTile extends StatefulWidget {
  final QueryDocumentSnapshot<Map<String, dynamic>> queryDocumentSnapshot;
  final FirebaseFirestore firebaseFirestore;
  final FirebaseStorage firebaseStorage;
  const PlaceTile({
    Key? key,
    required this.queryDocumentSnapshot,
    required this.firebaseFirestore,
    required this.firebaseStorage,
  }) : super(key: key);

  @override
  State<PlaceTile> createState() => _PlaceTileState();
}

class _PlaceTileState extends State<PlaceTile> {
  String videoPath = "";
  bool uploading = false;
  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        InkWell(
          // onTap: () => Navigator.push(
          //   context,
          //   CupertinoPageRoute(
          //     builder: (context) => BookingDetails(
          //       place: PlaceObj.fromFB(widget.queryDocumentSnapshot),
          //     ),
          //   ),
          // ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.7),
                  offset: const Offset(3, 3),
                  blurRadius: 7,
                  spreadRadius: 1,
                ),
              ],
              image: DecorationImage(
                image: NetworkImage(
                  widget.queryDocumentSnapshot["Images"],
                ),
                fit: BoxFit.cover,
              ),
            ),
            margin: const EdgeInsets.all(20),
            width: 350,
            height: 200,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0XFF888888).withOpacity(0.5),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                  ),
                ),
                padding: const EdgeInsets.all(10),
                child: ListTile(
                  onTap: () {
                    if (!uploading) selectFile();
                  },
                  title: Text(
                    widget.queryDocumentSnapshot["tempName"],
                    style: const TextStyle(color: Colors.white),
                  ),
                  trailing: Icon(
                    CupertinoIcons.check_mark_circled,
                    color: widget.queryDocumentSnapshot["Video Link"] != ""
                        ? Colors.white
                        : Colors.transparent,
                  ),
                ),
              ),
            ),
          ),
        ),
        uploading
            ? StreamBuilder<TaskSnapshot>(
                stream: widget.firebaseStorage
                    .ref(
                        "videos/${widget.queryDocumentSnapshot["Google Location"] + widget.queryDocumentSnapshot['tempName']}.${videoPath.substring(videoPath.lastIndexOf(".") + 1)}")
                    .putFile(File(videoPath))
                    .snapshotEvents,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    uploading = false;
                    setState(() {});
                  }
                  if (snapshot.hasData) {
                    if (snapshot.requireData.bytesTransferred ==
                        snapshot.requireData.totalBytes) {
                      update(snapshot.requireData);
                    }
                  }
                  return Container(
                    margin: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.black38,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: CircularProgressIndicator(
                        value: (snapshot.hasData)
                            ? (snapshot.requireData.bytesTransferred /
                                snapshot.requireData.totalBytes)
                            : 0,
                      ),
                    ),
                  );
                })
            : const SizedBox(),
      ],
    );
  }

  update(TaskSnapshot task) async {
    widget.firebaseFirestore
        .collection("experiences")
        .doc(widget.queryDocumentSnapshot.id)
        .update(
      {"Video Link": await task.ref.getDownloadURL()},
    );
    uploading = false;
    setState(() {});
  }

  void selectFile() async {
    FilePickerResult? path = await FilePicker.platform.pickFiles(
      type: FileType.video,
    );
    if (path == null) {
      videoPath = "";
      uploading = false;
    } else {
      videoPath = path.paths[0] ?? "";
      uploading = true;
    }
    setState(() {});
  }
}
