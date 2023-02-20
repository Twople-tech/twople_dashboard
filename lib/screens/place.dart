import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/placemodel.dart';

class PlaceEditTile extends StatefulWidget {
  final PlaceObj placeObj;
  const PlaceEditTile({super.key, required this.placeObj});

  @override
  State<PlaceEditTile> createState() => _PlaceEditTileState();
}

class _PlaceEditTileState extends State<PlaceEditTile> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EditExperience(placeObj: widget.placeObj),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          image: DecorationImage(
            image: CachedNetworkImageProvider(
              widget.placeObj.imgLink,
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            decoration: const BoxDecoration(
                color: Colors.white60,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                )),
            child: ListTile(
              contentPadding: const EdgeInsets.all(10),
              title: Text(widget.placeObj.name),
            ),
          ),
        ),
      ),
    );
  }
}

class EditExperience extends StatefulWidget {
  final PlaceObj placeObj;
  const EditExperience({super.key, required this.placeObj});

  @override
  State<EditExperience> createState() => _EditExperienceState();
}

class _EditExperienceState extends State<EditExperience> {
  late TextEditingController name, cost, imgLink, loc, des, itn, ll, burl, rat;
  late List<dynamic> timingSlots, expcats, expmoods, expprefs, expdays;
  late String ps;
  late Uint8List? fb;
  String videoPath = "";
  bool upload = false;
  @override
  void initState() {
    name = TextEditingController();
    cost = TextEditingController();
    imgLink = TextEditingController();
    loc = TextEditingController();
    ll = TextEditingController();
    des = TextEditingController();
    itn = TextEditingController();
    burl = TextEditingController();
    rat = TextEditingController();
    name.text = widget.placeObj.name;
    burl.text = widget.placeObj.bookingUrl;
    cost.text = widget.placeObj.cost;
    rat.text = widget.placeObj.experienceRatings;
    imgLink.text = widget.placeObj.imgLink;
    loc.text = widget.placeObj.location;
    ll.text = "${widget.placeObj.lat},${widget.placeObj.long}";
    des.text = widget.placeObj.about;
    itn.text = widget.placeObj.itn;
    timingSlots = widget.placeObj.timings;
    expcats = widget.placeObj.category;
    expmoods = widget.placeObj.moods;
    expprefs = widget.placeObj.prefs;
    expdays = widget.placeObj.days;
    ps = widget.placeObj.partnership;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const NeverScrollableScrollPhysics(),
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 400,
            flexibleSpace: Stack(
              fit: StackFit.expand,
              children: [
                InkWell(
                  onTap: () {
                    if (!upload) selectFile();
                  },
                  child: CachedNetworkImage(
                    height: 400,
                    imageUrl: widget.placeObj.imgLink,
                    fit: BoxFit.cover,
                  ),
                ),
                upload
                    ? StreamBuilder<TaskSnapshot>(
                        stream: FirebaseStorage.instance
                            .ref(
                                "videos/${widget.placeObj.id}.${videoPath.substring(videoPath.lastIndexOf(".") + 1)}")
                            .putData(fb!)
                            .snapshotEvents,
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            upload = false;
                            setState(() {});
                          }
                          if (snapshot.hasData) {
                            if (snapshot.requireData.bytesTransferred ==
                                snapshot.requireData.totalBytes) {
                              update(snapshot.requireData);
                            }
                          }
                          return Container(
                            height: 400,
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
                    : const SizedBox(
                        width: 0,
                        height: 0,
                      ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Transform.translate(
                    offset: const Offset(0, 350 / 2),
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Container(
                        width: 350,
                        height: 350,
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(12)),
                          image: DecorationImage(
                            image: CachedNetworkImageProvider(
                                widget.placeObj.imgLink),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            decoration: const BoxDecoration(
                                color: Colors.white60,
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(12),
                                  bottomRight: Radius.circular(12),
                                )),
                            child: ListTile(
                              contentPadding: const EdgeInsets.all(10),
                              title: Text(widget.placeObj.name),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            actions: [
              Container(
                color: Colors.black54,
                child: IconButton(
                  onPressed: () {
                    final docRef = FirebaseFirestore.instance
                        .collection("twopleExperiences")
                        .doc(widget.placeObj.id);
                    Map<String, dynamic> data = {
                      // "experienceName": name.value,
                      "experienceLocation": loc.text,
                      "experienceItinerary": itn.text,
                      "googleLocation": ll.text,
                      "experiencePartnership": ps,
                      "experienceImage": imgLink.text,
                      "experienceCost": cost.text,
                      "filterCost": double.parse(
                          cost.text.replaceAll("INR ", "").replaceAll(",", "")),
                      "experienceDescription": des.text,
                      "experienceTimings": timingSlots,
                      "experienceDays": expdays,
                      "bookingUrl": burl.text,
                      "experienceRatings": double.parse(rat.text),
                    };
                    for (var element in expcats) {
                      data.addAll({element: true});
                    }
                    for (var element in expmoods) {
                      data.addAll({element: true});
                    }
                    for (var element in expprefs) {
                      data.addAll({element: true});
                    }
                    docRef
                        .update(data)
                        .whenComplete(() => Navigator.pop(context));
                  },
                  icon: const Icon(CupertinoIcons.check_mark),
                ),
              )
            ],
          ),
          SliverFillRemaining(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 400.0,
                bottom: 50,
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 200,
                    ),
                    // ListTile(
                    //   title: const Text(
                    //     "Experience Name",
                    //     textScaleFactor: 1.2,
                    //   ),
                    //   subtitle: Padding(
                    //     padding: const EdgeInsets.only(left: 10.0),
                    //     child: TextFormField(
                    //       controller: name,
                    //       decoration: const InputDecoration(
                    //         hintText: "Experience Name",
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    // const SizedBox(
                    //   height: 20,
                    // ),
                    ListTile(
                      title: const Text(
                        "Experience Cost",
                        textScaleFactor: 1.2,
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: TextFormField(
                          controller: cost,
                          decoration: const InputDecoration(
                            hintText: "Experience Cost",
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ListTile(
                      title: const Text(
                        "Image Link",
                        textScaleFactor: 1.2,
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: TextFormField(
                          controller: imgLink,
                          decoration: const InputDecoration(
                            hintText: "Image Link",
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ListTile(
                      title: const Text(
                        "Booking URL",
                        textScaleFactor: 1.2,
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: TextFormField(
                          controller: burl,
                          decoration: const InputDecoration(
                            hintText: "Booking URL",
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ListTile(
                      title: const Text(
                        "Experience Location",
                        textScaleFactor: 1.2,
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: TextFormField(
                          controller: loc,
                          decoration: const InputDecoration(
                            hintText: "Experience Location",
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ListTile(
                      title: const Text(
                        "Lat Long",
                        textScaleFactor: 1.2,
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: TextFormField(
                          controller: ll,
                          decoration: const InputDecoration(
                            hintText: "Lat Long",
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ListTile(
                      title: const Text(
                        "About Experience",
                        textScaleFactor: 1.2,
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: TextFormField(
                          controller: des,
                          minLines: 5,
                          maxLines: 100,
                          decoration: const InputDecoration(
                            hintText: "About Experience",
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ListTile(
                      title: const Text(
                        "Experience Itinerary",
                        textScaleFactor: 1.2,
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: TextFormField(
                          controller: itn,
                          minLines: 5,
                          maxLines: 100,
                          decoration: const InputDecoration(
                            hintText: "Experience Itinerary",
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ListTile(
                      title: const Text(
                        "Days",
                        textScaleFactor: 1.2,
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Wrap(
                          spacing: 5,
                          runSpacing: 5,
                          children: days
                              .map(
                                (e) => ChoiceChip(
                                  label: Text(e),
                                  selected: expdays.contains(e),
                                  backgroundColor: Colors.black12,
                                  selectedColor: Colors.black38,
                                  onSelected: (value) {
                                    if (value) {
                                      expdays.add(e);
                                    } else {
                                      expdays.remove(e);
                                    }
                                    setState(() {});
                                  },
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ListTile(
                      title: const Text(
                        "Time Slots",
                        textScaleFactor: 1.2,
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: ListTile(
                          trailing: IconButton(
                            onPressed: () async {
                              var from = await showTimePicker(
                                context: context,
                                initialTime:
                                    const TimeOfDay(hour: 0, minute: 0),
                                helpText: "From",
                              );
                              if (from == null) {
                                return;
                              }
                              var to = await showTimePicker(
                                context: context,
                                initialTime:
                                    const TimeOfDay(hour: 0, minute: 0),
                                helpText: "To",
                              );
                              if (to == null) {
                                return;
                              }
                              timingSlots.add(
                                  "${(from.hour < 13 ? ((from.hour == 0 ? 12 : from.hour)) : (from.hour - 12)).toString().padLeft(2, '0')}:${from.minute.toString().padLeft(2, '0')}${from.hour < 12 ? 'AM' : 'PM'}-${(to.hour < 13 ? ((to.hour == 0 ? 12 : to.hour)) : (to.hour - 12)).toString().padLeft(2, '0')}:${to.minute.toString().padLeft(2, '0')}${to.hour < 12 ? 'AM' : 'PM'}");
                              setState(() {});
                            },
                            icon: const Icon(CupertinoIcons.add),
                          ),
                          title: timingSlots.isEmpty
                              ? const Text("Time Slots")
                              : Wrap(
                                  spacing: 5,
                                  runSpacing: 5,
                                  children: timingSlots
                                      .map(
                                        (e) => ChoiceChip(
                                          label: Text(e),
                                          selected: timingSlots.contains(e),
                                          backgroundColor: Colors.black12,
                                          selectedColor: Colors.black38,
                                          onSelected: (value) {
                                            if (value) {
                                              timingSlots.add(e);
                                            } else {
                                              timingSlots.remove(e);
                                            }
                                            setState(() {});
                                          },
                                        ),
                                      )
                                      .toList(),
                                ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ListTile(
                      title: const Text(
                        "Partnership",
                        textScaleFactor: 1.2,
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Wrap(
                          spacing: 5,
                          runSpacing: 5,
                          children: ["Yes", "No"]
                              .map(
                                (e) => ChoiceChip(
                                  label: Text(e),
                                  selected: ps == e,
                                  backgroundColor: Colors.black12,
                                  selectedColor: Colors.black38,
                                  onSelected: (value) {
                                    ps = e;
                                    setState(() {});
                                  },
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ListTile(
                      title: const Text(
                        "Category",
                        textScaleFactor: 1.2,
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Wrap(
                          spacing: 5,
                          runSpacing: 5,
                          children: tcats
                              .map(
                                (e) => ChoiceChip(
                                  label: Text(e),
                                  selected: expcats.contains(e),
                                  backgroundColor: Colors.black12,
                                  selectedColor: Colors.black38,
                                  onSelected: (value) {
                                    if (value) {
                                      expcats.add(e);
                                    } else {
                                      expcats.remove(e);
                                    }
                                    setState(() {});
                                  },
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ListTile(
                      title: const Text(
                        "Moods",
                        textScaleFactor: 1.2,
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Wrap(
                          spacing: 5,
                          runSpacing: 5,
                          children: tmoods
                              .map(
                                (e) => ChoiceChip(
                                  label: Text(e),
                                  selected: expmoods.contains(e),
                                  backgroundColor: Colors.black12,
                                  selectedColor: Colors.black38,
                                  onSelected: (value) {
                                    if (value) {
                                      expmoods.add(e);
                                    } else {
                                      expmoods.remove(e);
                                    }
                                    setState(() {});
                                  },
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ListTile(
                      title: const Text(
                        "Preferences",
                        textScaleFactor: 1.2,
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Wrap(
                          spacing: 5,
                          runSpacing: 5,
                          children: tprefs
                              .map(
                                (e) => ChoiceChip(
                                  label: Text(e),
                                  selected: expprefs.contains(e),
                                  backgroundColor: Colors.black12,
                                  selectedColor: Colors.black38,
                                  onSelected: (value) {
                                    if (value) {
                                      expprefs.add(e);
                                    } else {
                                      expprefs.remove(e);
                                    }
                                    setState(() {});
                                  },
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ListTile(
                      title: const Text(
                        "Ratings",
                        textScaleFactor: 1.2,
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: TextFormField(
                          controller: rat,
                          decoration: const InputDecoration(
                            hintText: "Ratings",
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  update(TaskSnapshot task) async {
    FirebaseFirestore.instance
        .collection("twopleExperiences")
        .doc(widget.placeObj.id)
        .update(
      {"videoLink": await task.ref.getDownloadURL()},
    );
    upload = false;
    setState(() {});
  }

  void selectFile() async {
    FilePickerResult? path = await FilePicker.platform.pickFiles(
      type: FileType.video,
      allowMultiple: false,
    );
    if (path != null && path.files.isNotEmpty) {
      fb = path.files.first.bytes;
      videoPath = path.files.first.name;
      upload = true;
    } else {
      videoPath = "";
      upload = false;
    }
    setState(() {});
  }
}
