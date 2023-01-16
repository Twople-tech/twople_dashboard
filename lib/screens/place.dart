// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:twople_dashboard/models/placemodel.dart';
// import 'package:video_player/video_player.dart';

// List<String> days = ["None", "Mon", "Tue", "Wed", "Thr", "Fri", "Sat", "Sun"];

// class BookingDetails extends StatefulWidget {
//   final PlaceObj place;
//   const BookingDetails({
//     Key? key,
//     required this.place,
//   }) : super(key: key);

//   @override
//   State<BookingDetails> createState() => _BookingDetailsState();
// }

// class _BookingDetailsState extends State<BookingDetails> {
//   late GoogleMapController mapController;
//   late ScrollController _sc;
//   final bool _selected = false;
//   bool visible = false;
//   late GlobalKey scrollTo;
//   late Widget cal;
//   late String pid;
//   late DateTime day;
//   late VideoPlayerController videoPlayerController;
//   late FloatingActionButton _actionButton;

//   void _onMapCreated(GoogleMapController controller) {
//     mapController = controller;
//   }

//   @override
//   void initState() {
//     _sc = ScrollController();
//     scrollTo = GlobalKey();
//     if (widget.place.videoLink != "") {
//       videoPlayerController = VideoPlayerController.network(
//         widget.place.videoLink,
//       )..initialize().then(
//           (value) => setState(
//             () {
//               videoPlayerController.play();
//             },
//           ),
//         );
//     }

//     super.initState();
//   }

//   @override
//   void dispose() {
//     mapController.dispose();
//     if (widget.place.videoLink != "") {
//       videoPlayerController.dispose();
//     }
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: CustomScrollView(
//         physics: const NeverScrollableScrollPhysics(),
//         slivers: [
//           SliverAppBar(
//             expandedHeight: 320,
//             pinned: true,
//             leading: Padding(
//               padding: const EdgeInsets.fromLTRB(10, 5, 0, 5),
//               child: Container(
//                 decoration: BoxDecoration(
//                   color: const Color(0XFF000000).withOpacity(0.2),
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: IconButton(
//                   onPressed: () => Navigator.pop(context),
//                   icon: const Icon(
//                     CupertinoIcons.back,
//                   ),
//                 ),
//               ),
//             ),
//             backgroundColor: Colors.white,
//             flexibleSpace: FlexibleSpaceBar(
//               background: ClipRRect(
//                 borderRadius: const BorderRadius.only(
//                   bottomLeft: Radius.circular(20),
//                   bottomRight: Radius.circular(20),
//                 ),
//                 child: SizedBox(
//                   height: 320,
//                   child: Stack(
//                     fit: StackFit.expand,
//                     children: [
//                       (widget.place.videoLink != "")
//                           ? videoPlayerController.value.isInitialized
//                               ? VideoPlayer(
//                                   videoPlayerController,
//                                 )
//                               : const Center(
//                                   child: CircularProgressIndicator(
//                                     color: Color(0XFFCB6CE6),
//                                   ),
//                                 )
//                           : CachedNetworkImage(
//                               imageUrl: widget.place.imgLink,
//                               fit: BoxFit.cover,
//                             ),
//                       (widget.place.videoLink != "")
//                           ? InkWell(
//                               onTap: () {
//                                 if (videoPlayerController.value.isPlaying) {
//                                   videoPlayerController.pause();
//                                 } else {
//                                   videoPlayerController.play();
//                                 }
//                                 setState(() {});
//                               },
//                               child: Container(
//                                 color: videoPlayerController.value.isPlaying
//                                     ? Colors.transparent
//                                     : Colors.black45,
//                                 child: Center(
//                                   child: Icon(
//                                     videoPlayerController.value.isPlaying
//                                         ? CupertinoIcons.pause
//                                         : CupertinoIcons.play,
//                                     color: videoPlayerController.value.isPlaying
//                                         ? Colors.transparent
//                                         : Colors.white,
//                                   ),
//                                 ),
//                               ),
//                             )
//                           : const SizedBox(),
//                       Align(
//                         alignment: Alignment.bottomCenter,
//                         child: Padding(
//                           padding: const EdgeInsets.all(20.0),
//                           child: Container(
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(12),
//                               color: const Color(0XFF888888).withOpacity(0.5),
//                             ),
//                             child: ListTile(
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(12),
//                               ),
//                               title: Text(
//                                 widget.place.location,
//                                 style: const TextStyle(color: Colors.white),
//                               ),
//                               trailing: Text(
//                                 (widget.place.cost == "")
//                                     ? "INR 5000"
//                                     : widget.place.cost,
//                                 style: const TextStyle(color: Colors.white),
//                               ),
//                             ),
//                           ),
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           SliverFillRemaining(
//             child: NotificationListener<ScrollNotification>(
//               onNotification: (scroll) {
//                 var currentContext = scrollTo.currentContext;
//                 if (currentContext == null) return false;

//                 var renderObject = currentContext.findRenderObject()!;
//                 RenderAbstractViewport viewport =
//                     RenderAbstractViewport.of(renderObject)!;
//                 var offsetToRevealBottom =
//                     viewport.getOffsetToReveal(renderObject, 1.0);

//                 if (offsetToRevealBottom.offset > scroll.metrics.pixels) {
//                   if (visible) {
//                     setState(() {
//                       visible = false;
//                     });
//                   }
//                 } else {
//                   if (!visible) {
//                     setState(() {
//                       visible = true;
//                     });
//                   }
//                 }
//                 return false;
//               },
//               child: ListView(
//                 controller: _sc,
//                 padding: EdgeInsets.zero,
//                 children: [
//                   Container(
//                     color: Colors.white,
//                     child: ListTile(
//                       isThreeLine: true,
//                       title: Text(
//                         "\n${widget.place.name}",
//                         style: const TextStyle(
//                           fontSize: 22,
//                           color: Color(0XFFCB6CE6),
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       subtitle: Text(
//                         ("\n") + (widget.place.about),
//                       ),
//                     ),
//                   ),
//                   Container(
//                     color: Colors.white,
//                     child: ListTile(
//                       isThreeLine: true,
//                       title: const Text(
//                         "\nLocation",
//                         style: TextStyle(
//                           fontSize: 22,
//                           color: Color(0XFFCB6CE6),
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       subtitle: Text(
//                         "\n${widget.place.location}",
//                       ),
//                     ),
//                   ),
//                   Container(
//                     color: Colors.white,
//                     padding: const EdgeInsets.all(20),
//                     child: ClipRRect(
//                       borderRadius: const BorderRadius.all(Radius.circular(10)),
//                       child: Container(
//                         width: 300,
//                         height: 200,
//                         decoration: const BoxDecoration(
//                           color: Colors.white,
//                         ),
//                         child: GoogleMap(
//                           onMapCreated: _onMapCreated,
//                           scrollGesturesEnabled: false,
//                           initialCameraPosition: CameraPosition(
//                             target: LatLng(widget.place.lat, widget.place.long),
//                             zoom: 12.0,
//                           ),
//                           markers: {
//                             Marker(
//                               markerId: MarkerId(widget.place.name),
//                               position:
//                                   LatLng(widget.place.lat, widget.place.long),
//                               infoWindow: InfoWindow(
//                                 title: widget.place.name,
//                                 snippet: widget.place.location,
//                               ),
//                             ),
//                           },
//                         ),
//                       ),
//                     ),
//                   ),
//                   (widget.place.isProvider && !widget.place.customProvider)
//                       ? ListTile(
//                           key: scrollTo,
//                           tileColor: Colors.white,
//                           title: const Text(
//                             "\nBook A Date",
//                             style: TextStyle(
//                               fontSize: 22,
//                               color: Color(0XFFCB6CE6),
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         )
//                       : const SizedBox(),
//                 ],
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
