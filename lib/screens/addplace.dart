import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



// class UploadPlace extends StatefulWidget {
//   const UploadPlace({Key? key}) : super(key: key);

//   @override
//   State<UploadPlace> createState() => _UploadPlaceState();
// }

// class _UploadPlaceState extends State<UploadPlace> {
//   List<String> usertags = [];
//   List<String> userdays = [];
//   List<String> usercats = [];
//   List<String> usermoods = [];
//   List<String> userprefs = [];
//   List<String> timings = [];
//   late GlobalKey<FormState> form;
//   late TextEditingController name, loc, des, cos, bou, gol, ll, img, itn, pat;
//   @override
//   void initState() {
//     name = TextEditingController();
//     loc = TextEditingController();
//     des = TextEditingController();
//     cos = TextEditingController();
//     bou = TextEditingController();
//     gol = TextEditingController();
//     ll = TextEditingController();
//     img = TextEditingController();
//     itn = TextEditingController();
//     pat = TextEditingController();
//     form = GlobalKey<FormState>();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Add New Place"),
//       ),
//       body: Form(
//         key: form,
//         child: Padding(
//           padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
//           child: ListView(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
//                 child: TextFormField(
//                   validator: (value) =>
//                       value == null || value.isEmpty ? "Can't Be Empty" : null,
//                   controller: name,
//                   decoration: InputDecoration(
//                     hintText: "Name",
//                     border: OutlineInputBorder(
//                       borderSide: const BorderSide(color: Colors.blueAccent),
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
//                 child: TextFormField(
//                   validator: (value) =>
//                       value == null || value.isEmpty ? "Can't Be Empty" : null,
//                   controller: img,
//                   decoration: InputDecoration(
//                     hintText: "Image",
//                     border: OutlineInputBorder(
//                       borderSide: const BorderSide(color: Colors.blueAccent),
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
//                 child: TextFormField(
//                   validator: (value) =>
//                       value == null || value.isEmpty ? "Can't Be Empty" : null,
//                   controller: loc,
//                   decoration: InputDecoration(
//                     hintText: "Location",
//                     border: OutlineInputBorder(
//                       borderSide: const BorderSide(color: Colors.blueAccent),
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
//                 child: TextFormField(
//                   validator: (value) =>
//                       value == null || value.isEmpty ? "Can't Be Empty" : null,
//                   controller: ll,
//                   decoration: InputDecoration(
//                     hintText: "Latitude, Longitude",
//                     border: OutlineInputBorder(
//                       borderSide: const BorderSide(color: Colors.blueAccent),
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
//                 child: TextFormField(
//                   controller: pat,
//                   decoration: InputDecoration(
//                     hintText: "Partner",
//                     border: OutlineInputBorder(
//                       borderSide: const BorderSide(color: Colors.blueAccent),
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
//                 child: TextFormField(
//                   validator: (value) =>
//                       value == null || value.isEmpty ? "Can't Be Empty" : null,
//                   controller: des,
//                   minLines: 5,
//                   maxLines: 100,
//                   decoration: InputDecoration(
//                     hintText: "Description",
//                     border: OutlineInputBorder(
//                       borderSide: const BorderSide(color: Colors.blueAccent),
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
//                 child: TextFormField(
//                   controller: itn,
//                   minLines: 5,
//                   maxLines: 100,
//                   decoration: InputDecoration(
//                     hintText: "Itinerary",
//                     border: OutlineInputBorder(
//                       borderSide: const BorderSide(color: Colors.blueAccent),
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
//                 child: TextFormField(
//                   validator: (value) =>
//                       value == null || value.isEmpty ? "Can't Be Empty" : null,
//                   controller: cos,
//                   decoration: InputDecoration(
//                     hintText: "Cost",
//                     border: OutlineInputBorder(
//                       borderSide: const BorderSide(color: Colors.blueAccent),
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
//                 child: TextFormField(
//                   validator: (value) =>
//                       value == null || value.isEmpty ? "Can't Be Empty" : null,
//                   controller: bou,
//                   decoration: InputDecoration(
//                     hintText: "Booking URL",
//                     border: OutlineInputBorder(
//                       borderSide: const BorderSide(color: Colors.blueAccent),
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
//                 child: ListTile(
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                     side: const BorderSide(color: Colors.grey),
//                   ),
//                   title: usertags.isEmpty
//                       ? const Text("Tags")
//                       : Wrap(
//                           spacing: 5,
//                           children: usertags
//                               .map(
//                                 (e) => Chip(label: Text(e)),
//                               )
//                               .toList(),
//                         ),
//                   trailing: IconButton(
//                     onPressed: () {
//                       showCupertinoModalPopup(
//                         context: context,
//                         builder: (context) {
//                           TextEditingController textEditingController =
//                               TextEditingController();
//                           return Center(
//                             child: Padding(
//                               padding: const EdgeInsets.all(40.0),
//                               child: Material(
//                                 color: Colors.transparent,
//                                 child: TextFormField(
//                                   controller: textEditingController,
//                                   focusNode: FocusNode()..requestFocus(),
//                                   onEditingComplete: () {
//                                     usertags.add(textEditingController.text);
//                                     Future(() => setState(() {}));
//                                     Navigator.pop(context);
//                                   },
//                                   decoration: InputDecoration(
//                                     hintText: "Tag",
//                                     fillColor: Colors.white,
//                                     filled: true,
//                                     border: OutlineInputBorder(
//                                       borderSide: const BorderSide(
//                                           color: Colors.blueAccent),
//                                       borderRadius: BorderRadius.circular(12),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           );
//                         },
//                       );
//                     },
//                     icon: const Icon(CupertinoIcons.add),
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
//                 child: ListTile(
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                     side: const BorderSide(color: Colors.grey),
//                   ),
//                   title: const Padding(
//                     padding: EdgeInsets.all(8.0),
//                     child: Text("Days"),
//                   ),
//                   subtitle: Padding(
//                     padding: const EdgeInsets.only(bottom: 10.0),
//                     child: Wrap(
//                       spacing: 5,
//                       children: days
//                           .map(
//                             (e) => ChoiceChip(
//                               label: Text(e),
//                               selected: userdays.contains(e),
//                               backgroundColor: Colors.black12,
//                               selectedColor: Colors.black38,
//                               onSelected: (value) {
//                                 if (value) {
//                                   userdays.add(e);
//                                 } else {
//                                   userdays.remove(e);
//                                 }
//                                 setState(() {});
//                               },
//                             ),
//                           )
//                           .toList(),
//                     ),
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
//                 child: ListTile(
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                     side: const BorderSide(color: Colors.grey),
//                   ),
//                   title: timings.isEmpty
//                       ? const Text("Time Slots")
//                       : Wrap(
//                           spacing: 5,
//                           children: timings
//                               .map(
//                                 (e) => ChoiceChip(
//                                   label: Text(e),
//                                   selected: timings.contains(e),
//                                   backgroundColor: Colors.black12,
//                                   selectedColor: Colors.black38,
//                                   onSelected: (value) {
//                                     if (value) {
//                                       timings.add(e);
//                                     } else {
//                                       timings.remove(e);
//                                     }
//                                     setState(() {});
//                                   },
//                                 ),
//                               )
//                               .toList(),
//                         ),
//                   trailing: IconButton(
//                     onPressed: () async {
//                       var from = await showTimePicker(
//                         context: context,
//                         initialTime: const TimeOfDay(hour: 0, minute: 0),
//                         helpText: "From",
//                       );
//                       if (from == null) {
//                         return;
//                       }
//                       var to = await showTimePicker(
//                         context: context,
//                         initialTime: const TimeOfDay(hour: 0, minute: 0),
//                         helpText: "To",
//                       );
//                       if (to == null) {
//                         return;
//                       }
//                       timings.add(
//                           "${from.hour.toString().padLeft(2, '0')}:${from.minute.toString().padLeft(2, '0')}${from.hour < 12 ? 'AM' : 'PM'}-${to.hour.toString().padLeft(2, '0')}:${to.minute.toString().padLeft(2, '0')}${to.hour < 12 ? 'AM' : 'PM'}");
//                       setState(() {});
//                     },
//                     icon: const Icon(CupertinoIcons.add),
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
//                 child: ListTile(
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                     side: const BorderSide(color: Colors.grey),
//                   ),
//                   title: const Padding(
//                     padding: EdgeInsets.all(8.0),
//                     child: Text("Category"),
//                   ),
//                   subtitle: Padding(
//                     padding: const EdgeInsets.only(bottom: 10.0),
//                     child: Wrap(
//                       spacing: 5,
//                       children: tcats
//                           .map(
//                             (e) => ChoiceChip(
//                               label: Text(e),
//                               selected: usercats.contains(e),
//                               backgroundColor: Colors.black12,
//                               selectedColor: Colors.black38,
//                               onSelected: (value) {
//                                 if (value) {
//                                   usercats.add(e);
//                                 } else {
//                                   usercats.remove(e);
//                                 }
//                                 setState(() {});
//                               },
//                             ),
//                           )
//                           .toList(),
//                     ),
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
//                 child: ListTile(
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                     side: const BorderSide(color: Colors.grey),
//                   ),
//                   title: const Padding(
//                     padding: EdgeInsets.all(8.0),
//                     child: Text("Moods"),
//                   ),
//                   subtitle: Padding(
//                     padding: const EdgeInsets.only(bottom: 10.0),
//                     child: Wrap(
//                       spacing: 5,
//                       children: tmoods
//                           .map(
//                             (e) => ChoiceChip(
//                               label: Text(e),
//                               selected: usermoods.contains(e),
//                               backgroundColor: Colors.black12,
//                               selectedColor: Colors.black38,
//                               onSelected: (value) {
//                                 if (value) {
//                                   usermoods.add(e);
//                                 } else {
//                                   usermoods.remove(e);
//                                 }
//                                 setState(() {});
//                               },
//                             ),
//                           )
//                           .toList(),
//                     ),
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
//                 child: ListTile(
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                     side: const BorderSide(color: Colors.grey),
//                   ),
//                   title: const Padding(
//                     padding: EdgeInsets.all(8.0),
//                     child: Text("Preferences"),
//                   ),
//                   subtitle: Padding(
//                     padding: const EdgeInsets.only(bottom: 10.0),
//                     child: Wrap(
//                       spacing: 5,
//                       children: tprefs
//                           .map(
//                             (e) => ChoiceChip(
//                               label: Text(e),
//                               selected: userprefs.contains(e),
//                               backgroundColor: Colors.black12,
//                               selectedColor: Colors.black38,
//                               onSelected: (value) {
//                                 if (value) {
//                                   userprefs.add(e);
//                                 } else {
//                                   userprefs.remove(e);
//                                 }
//                                 setState(() {});
//                               },
//                             ),
//                           )
//                           .toList(),
//                     ),
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
//                 child: CupertinoButton.filled(
//                   child: const Text("Upload"),
//                   onPressed: () {
//                     if (form.currentState!.validate()) {
//                       final dr = FirebaseFirestore.instance
//                           .collection("experiences")
//                           .doc(
//                             ll.text +
//                                 name.text
//                                     .replaceAll(" ", "")
//                                     .replaceAll("/", "")
//                                     .replaceAll("-", ""),
//                           );
//                       Map<String, dynamic> data = {
//                         "Name": name.text,
//                         "tempName": name.text
//                             .replaceAll(" ", "")
//                             .replaceAll("/", "")
//                             .replaceAll("-", ""),
//                         "Booking URL": bou.text,
//                         "Cost": cos.text,
//                         "Location": loc.text,
//                         "Google Location": ll.text,
//                         "Tags": usertags,
//                         "Days": userdays,
//                         "Video Link": "",
//                         "Images": img.text,
//                         "Itinerary": itn.text,
//                         "Partnership": pat.text,
//                         "Timings": timings,
//                         "Description": des.text,
//                       };
//                       for (var element in usercats) {
//                         data.addAll({element: true});
//                       }
//                       for (var element in usermoods) {
//                         data.addAll({element: true});
//                       }
//                       for (var element in userprefs) {
//                         data.addAll({element: true});
//                       }
//                       dr.set(data).whenComplete(() => Navigator.pop(context));
//                     }
//                   },
//                 ),
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
