import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class CreateExperience extends StatefulWidget {
  const CreateExperience({super.key});

  @override
  State<CreateExperience> createState() => _CreateExperienceState();
}

class _CreateExperienceState extends State<CreateExperience> {
  late TextEditingController name, cost, imgLink, loc, des, itn, ll, burl, rat;
  late List<dynamic> timingSlots, expcats, expmoods, expprefs, expdays;
  late String ps;
  // late Uint8List? fb;
  // String videoPath = "";
  // bool upload = false;
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
    timingSlots = [];
    expcats = [];
    expmoods = [];
    expprefs = [];
    expdays = [];
    ps = "No";
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
                Image.asset(
                  "imgs/cloudupload.jpg",
                  height: 400,
                  fit: BoxFit.cover,
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
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          image: DecorationImage(
                            image: AssetImage("imgs/cloudupload.jpg"),
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
                            child: const ListTile(
                              contentPadding: EdgeInsets.all(10),
                              title: Text("Name"),
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
                        .doc();
                    Map<String, dynamic> data = {
                      "experienceName": name.text,
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
                      "videoLink": "",
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
                    docRef.set(data).whenComplete(() => Navigator.pop(context));
                  },
                  icon: const Icon(CupertinoIcons.check_mark),
                ),
              ),
            ],
          ),
          SliverFillRemaining(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 50.0,
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
                    ListTile(
                      title: const Text(
                        "Experience Name",
                        textScaleFactor: 1.2,
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: TextFormField(
                          controller: name,
                          decoration: const InputDecoration(
                            hintText: "Experience Name",
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
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
                        "Time Slot Alloted",
                        textScaleFactor: 1.2,
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Wrap(
                          spacing: 5,
                          runSpacing: 5,
                          children: [
                            "Yes",
                            "No",
                          ]
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
}
