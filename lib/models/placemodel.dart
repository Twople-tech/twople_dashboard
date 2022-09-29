import 'package:cloud_firestore/cloud_firestore.dart';

class PlaceObj {
  final String id;
  final String name;
  final String about;
  final String location;
  final double lat;
  final double long;
  final String imgLink;
  final String videoLink;
  final List<dynamic> category;
  final String cost;
  final bool isProvider;
  final bool customProvider;
  final List<dynamic> days;
  final List<dynamic> timings;
  final String bookingUrl;

  PlaceObj({
    required this.id,
    required this.name,
    required this.about,
    required this.location,
    required this.lat,
    required this.long,
    required this.imgLink,
    required this.videoLink,
    required this.category,
    required this.cost,
    required this.isProvider,
    required this.customProvider,
    required this.days,
    required this.timings,
    required this.bookingUrl,
  });

  factory PlaceObj.fromFB(QueryDocumentSnapshot<Map<String, dynamic>> e) {
    return PlaceObj(
      id: e.id,
      name: e.data()["Name"],
      location: e.data()["Location"],
      lat: double.parse(e.data()["Google Location"].toString().split(",")[0]),
      long: double.parse(e.data()["Google Location"].toString().split(",")[1]),
      isProvider: e.data()["Partnership"] != "",
      imgLink: e.data()["Images"],
      videoLink: e.data()["Video Link"],
      cost: e.data()["Cost"],
      category: e.data()["Category"] ?? [],
      about: e.data()["Description"],
      customProvider: !["No", ""].contains(
        e.data()["Partnership"],
      ),
      days: (e["Days"][0] == "") ? [] : e["Days"],
      timings: (e["Timings"][0] == "") ? [] : e["Timings"],
      bookingUrl: e["Booking URL"],
    );
  }
  factory PlaceObj.fromF(DocumentSnapshot<Map<String, dynamic>> e) {
    return PlaceObj(
      id: e.id,
      name: e.data()!["Name"],
      location: e["Location"],
      lat: double.parse(e["Google Location"].toString().split(",")[0]),
      long: double.parse(e["Google Location"].toString().split(",")[1]),
      isProvider: e["Partnership"] != "",
      imgLink: e["Images"],
      videoLink: e["Video Link"],
      cost: e["Cost"],
      category: [],
      about: e["Description"],
      customProvider: !["No", ""].contains(
        e["Partnership"],
      ),
      days: (e["Days"][0] == "") ? [] : e["Days"],
      timings: (e["Timings"][0] == "") ? [] : e["Timings"],
      bookingUrl: e["Booking URL"],
    );
  }
}
