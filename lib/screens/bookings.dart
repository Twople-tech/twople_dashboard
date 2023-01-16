import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BookingsPage extends StatefulWidget {
  const BookingsPage({super.key});

  @override
  State<BookingsPage> createState() => _BookingsPageState();
}

class _BookingsPageState extends State<BookingsPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text("Bookings"),
          bottom: const TabBar(
            tabs: [Tab(text: "Query"), Tab(text: "Booked")],
            indicatorColor: Colors.white,
          ),
        ),
        body: TabBarView(
          children: [
            StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: FirebaseFirestore.instance
                  .collection("twopleTransactions")
                  .where(
                    "verifiedByTwople",
                    isEqualTo: false,
                  )
                  .where("queryStatus", isEqualTo: "Queue")
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final data = snapshot.requireData;
                  return ListView(
                    children: data.docs.map((e) {
                      return QueryTile(data: e);
                    }).toList(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text("Error: ${snapshot.error}"),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
            StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: FirebaseFirestore.instance
                  .collection("twopleTransactions")
                  .where(
                    "verifiedByTwople",
                    isEqualTo: false,
                  )
                  .where("paymentId", isNotEqualTo: "Query")
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final data = snapshot.requireData;
                  return ListView(
                    children: data.docs.map((e) {
                      return BookTile(data: e);
                    }).toList(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text("Error: ${snapshot.error}"),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class QueryTile extends StatefulWidget {
  final QueryDocumentSnapshot data;
  const QueryTile({super.key, required this.data});

  @override
  State<QueryTile> createState() => _QueryTileState();
}

class _QueryTileState extends State<QueryTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.black),
      ),
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        title: Text(widget.data["name"]),
        subtitle: Text(
          "${widget.data["userName"]}\n${widget.data["userNumber"]}\n${widget.data["paymentTime"].toString().substring(0, 16)}",
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: () {
                FirebaseFirestore.instance
                    .collection("twopleTransactions")
                    .doc(widget.data.id)
                    .update(
                  {
                    "queryStatus": "Cancle",
                    "transactionStatus": "Cancle",
                    "verifiedByTwople": true,
                    // "updateUser": false,
                    // "verifiedAt": DateTime.now().toString(),
                  },
                );
              },
              icon: const Icon(CupertinoIcons.xmark),
            ),
            IconButton(
              onPressed: () {
                FirebaseFirestore.instance
                    .collection("twopleTransactions")
                    .doc(widget.data.id)
                    .update(
                  {
                    "queryStatus": "Success",
                    "verifiedByTwople": true,
                    "updateUser": true,
                    "verifiedAt": DateTime.now().toString(),
                  },
                );
              },
              icon: const Icon(CupertinoIcons.check_mark),
            ),
          ],
        ),
      ),
    );
  }
}

class BookTile extends StatefulWidget {
  final QueryDocumentSnapshot data;
  const BookTile({super.key, required this.data});

  @override
  State<BookTile> createState() => _BookTileState();
}

class _BookTileState extends State<BookTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.black),
      ),
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        title: Text(widget.data["name"]),
        subtitle: Text(
          "${widget.data["userName"]}\n${widget.data["userNumber"]}\n${widget.data["slotTime"]}\n${widget.data["paymentTime"].toString().substring(0, 16)}",
        ),
        trailing: IconButton(
          onPressed: () {
            FirebaseFirestore.instance
                .collection("twopleTransactions")
                .doc(widget.data.id)
                .update(
              {
                "verifiedByTwople": true,
                "updateUser": true,
                "verifiedAt": DateTime.now().toString(),
              },
            );
          },
          icon: const Icon(CupertinoIcons.check_mark),
        ),
      ),
    );
  }
}
