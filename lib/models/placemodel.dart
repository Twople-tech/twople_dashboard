import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:twople_dashboard/screens/addplace.dart';

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

class PlaceObj {
  final String id;
  final String name;
  final String about;
  final String location;
  final String itn;
  final double lat;
  final double long;
  final String imgLink;
  final String videoLink;
  final List<dynamic> category, moods, prefs;
  final String cost;
  // final bool isProvider;
  // final bool customProvider;
  final String partnership;
  final List<dynamic> days;
  final List<dynamic> timings;
  final String bookingUrl;

  PlaceObj({
    required this.id,
    required this.name,
    required this.about,
    required this.location,
    required this.itn,
    required this.lat,
    required this.long,
    required this.imgLink,
    required this.videoLink,
    required this.category,
    required this.moods,
    required this.prefs,
    required this.cost,
    // required this.isProvider,
    // required this.customProvider,
    required this.partnership,
    required this.days,
    required this.timings,
    required this.bookingUrl,
  });

  factory PlaceObj.fromFB(QueryDocumentSnapshot<Map<String, dynamic>> e) {
    List<dynamic> cat = [], mood = [], pref = [];
    for (var f in tcats) {
      if (e.data().containsKey(f)) {
        cat.add(f);
      }
    }
    for (var f in tmoods) {
      if (e.data().containsKey(f)) {
        mood.add(f);
      }
    }
    for (var f in tprefs) {
      if (e.data().containsKey(f)) {
        pref.add(f);
      }
    }
    return PlaceObj(
      id: e.id,
      name: e.data()["experienceName"],
      location: e.data()["experienceLocation"],
      itn: e.data()["experienceItinerary"],
      lat: double.parse(e.data()["googleLocation"].toString().split(",")[0]),
      long: double.parse(e.data()["googleLocation"].toString().split(",")[1]),
      // isProvider: e.data()["experiencePartnership"] != "",
      imgLink: e.data()["experienceImage"],
      videoLink: e.data()["videoLink"],
      cost: e.data()["experienceCost"],
      category: cat,
      moods: mood,
      prefs: pref,
      about: e.data()["experienceDescription"],
      // customProvider: !["No", ""].contains(
      // e.data()["experiencePartnership"],
      // ),
      partnership: e["experiencePartnership"],
      days: ((e["experienceDays"].isNotEmpty && e["experienceDays"][0] == "")
          ? []
          : e["experienceDays"]),
      timings: ((e["experienceTimings"].isNotEmpty &&
              e["experienceTimings"][0] == "")
          ? []
          : e["experienceTimings"]),
      bookingUrl: e["bookingUrl"],
    );
  }
  // factory PlaceObj.fromF(DocumentSnapshot<Map<String, dynamic>> e) {
  //   return PlaceObj(
  //     id: e.id,
  //     name: e.data()!["experienceName"],
  //     location: e["experienceLocation"],
  //     itn: e["experienceItinerary"],
  //     lat: double.parse(e["googleLocation"].toString().split(",")[0]),
  //     long: double.parse(e["googleLocation"].toString().split(",")[1]),
  //     isProvider: e["experiencePartnership"] != "",
  //     imgLink: e["experienceImage"],
  //     videoLink: e["videoLink"],
  //     cost: e["experienceCost"],
  //     category: [],
  //     about: e["experienceDescription"],
  //     customProvider: !["No", ""].contains(
  //       e["experiencePartnership"],
  //     ),
  //     days: (e["experienceDays"][0] == "") ? [] : e["experienceDays"],
  //     timings: (e["experienceTimings"][0] == "") ? [] : e["experienceTimings"],
  //     bookingUrl: e["bookingUrl"],
  //   );
  // }
}
