import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:share_plus/share_plus.dart';
//import 'package:http/http.dart';
 import 'package:http/http.dart' as http; 
import 'package:path_provider/path_provider.dart';

class ResidentsDashboard extends StatefulWidget {
  const ResidentsDashboard(
      {Key? key, required this.menutype, required this.status})
      : super(key: key);
  final String status;
  final String menutype;
  // final BuildContext context;
  @override
  State<ResidentsDashboard> createState() => _ResidentsDashboardState();
}

class _ResidentsDashboardState extends State<ResidentsDashboard> {
  bool _isElevated = false;
  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _membersStream = FirebaseFirestore.instance
        .collection('request')
        .doc(widget.menutype)
        .collection(widget.status)
        .snapshots();
    return
        // appBar: AppBar(
        //   leading: null,
        //   title: Text("Resident Requests"),
        //   backgroundColor: Colors.purple,
        // ),

        LayoutBuilder(builder:
            (BuildContext context, BoxConstraints viewportConstraints) {
      return StreamBuilder<QuerySnapshot>(
        stream: _membersStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading");
          }

          return ListView(
            //scrollDirection: Axis.vertical,
            shrinkWrap: true,
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data()! as Map<String, dynamic>;
              //print(data);
              // print((data["image_url"]).runtimeType);
              // Null image = data["image_url"];

              return (data.isEmpty)
                  ? Center(
                      child: Text("No request"),
                    )
                  : Column(
                      children: [
                        Divider(),
                        AnimatedContainer(
                          duration: const Duration(
                            milliseconds: 200,
                          ),
                          child: Row(children: [
                            GestureDetector(
                              onTap: () async {
                                final urlPdf = data["docs_url"];
                                final url = Uri.parse(urlPdf);
                                final response = await http.get(url);
                                final bytes = response.bodyBytes;

                                final temp = await getTemporaryDirectory();
                                final path = '${temp.path}/my.pdf';
                                File(path).writeAsBytesSync(bytes);

                                await Share.shareFiles([path]);
                              },
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                                child: Column(children: [
                                  Image.asset('assets/images/pdf_image.png',
                                      width: 100, height: 100),
                                ]),
                              ),
                            ),
                            Column(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 10, 0, 0),
                                  child: Column(children: [
                                    Text("Name: " + data['name']),
                                    Text("Society: " + data['society_name']),
                                    Text("Flat No: " + data['flat']),
                                  ]),
                                ),
                                (widget.status == 'pending')
                                    ? Row(children: [
                                        Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: ElevatedButton(
                                            style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all(
                                                        Colors.red)),
                                            onPressed: () async {
                                              await FirebaseFirestore.instance
                                                  .collection("request")
                                                  .doc(widget.menutype)
                                                  .collection('decline')
                                                  .doc(document.id)
                                                  .set(data);
                                              await FirebaseFirestore.instance
                                                  .collection("request")
                                                  .doc(widget.menutype)
                                                  .collection('pending')
                                                  .doc(document.id)
                                                  .delete();
                                            },
                                            child: const Text('Decline'),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: ElevatedButton(
                                            style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all(
                                                        Colors.green)),
                                            onPressed: () async {
                                              await FirebaseFirestore.instance
                                                  .collection("request")
                                                  .doc(widget.menutype)
                                                  .collection('approve')
                                                  .doc(document.id)
                                                  .set(data);
                                              await FirebaseFirestore.instance
                                                  .collection("request")
                                                  .doc(widget.menutype)
                                                  .collection('pending')
                                                  .doc(document.id)
                                                  .delete();
                                              await FirebaseFirestore.instance
                                                  .collection("users")
                                                  .doc(data["email"])
                                                  .set({
                                                "flat_owner_id": document.id,
                                                "isSignedUp": false,
                                                "role": "owner",
                                                "society_name":
                                                    data["society_name"]
                                              });
                                              await FirebaseFirestore.instance
                                                  .collection("societies")
                                                  .doc(data["society_name"])
                                                  .collection("members")
                                                  .doc(document.id)
                                                  .set({
                                                ...data,
                                                "image_url": "",
                                                "role": "owner",
                                              });
                                            },
                                            child: const Text('Approve'),
                                          ),
                                        ),
                                      ])
                                    : ((widget.status == 'decline'))
                                        ? Row(children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(5.0),
                                              child: ElevatedButton(
                                                style: ButtonStyle(
                                                    backgroundColor:
                                                        MaterialStateProperty
                                                            .all(Colors.green)),
                                                onPressed: () async {
                                                  await FirebaseFirestore
                                                      .instance
                                                      .collection("request")
                                                      .doc(widget.menutype)
                                                      .collection('approve')
                                                      .doc(document.id)
                                                      .set(data);
                                                  await FirebaseFirestore
                                                      .instance
                                                      .collection("request")
                                                      .doc(widget.menutype)
                                                      .collection('decline')
                                                      .doc(document.id)
                                                      .delete();
                                                },
                                                child: const Text('Reapprove'),
                                              ),
                                            ),
                                          ])
                                        : Row()
                              ],
                            ),
                          ]),
                          height: 125,
                          width: 325,
                          decoration: BoxDecoration(
                              // color: Colors.grey[300],
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(25),
                              boxShadow: [
                                const BoxShadow(
                                  color: Colors.grey,
                                  offset: Offset(4, 4),
                                  blurRadius: 15,
                                  spreadRadius: 1,
                                )
                              ]),
                        ),
                      ],
                    );
            }).toList(),
          );
        },
      );
    });
  }
}
