import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);
  static const routeName = '/dashboard';

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  bool _isElevated = false;
  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _membersStream =
        FirebaseFirestore.instance.collection('request').snapshots();
    return Scaffold(
      appBar: AppBar(
        leading: null,
        title: Text("Resident Requests"),
        backgroundColor: Colors.purple,
      ),
      body: SingleChildScrollView(
        child: Column(children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              //const Center(child: Text("Flat Owner Data")),

              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Row(
              //     children: [
              // Card(
              //   child: (imgUrl == "")
              //       ? const Text("Loading ...")
              //       : Image.network(
              //           imgUrl,
              //           width: 100,
              //           height: 100,
              //         ),
              // ),
              // Column(
              //   children: [
              //     const Text("Viresh Fegade"),
              //     ElevatedButton(
              //       child: const Padding(
              //         padding: EdgeInsets.all(8.0),
              //         child: Text("Update Photo"),
              //       ),
              //       onPressed: () async {},
              //     ),
              //   ],
              // ),
              //     ],
              //   ),
              // ),
              // const Divider(color: Colors.indigo),
              // ElevatedButton(
              //   child: const Padding(
              //     padding: EdgeInsets.all(8.0),
              //     child: Text("Add Family Member Data"),
              //   ),
              //   onPressed: () {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //         builder: (context) => const AddMemberDataScreen(),
              //       ),
              //     );
              //   },
              // ),
              // const Divider(
              //   color: Colors.indigo,
              //   thickness: 3,
              // ),
              //family members list
              //  const Text("Family Members"),
              StreamBuilder<QuerySnapshot>(
                stream: _membersStream,
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return const Text('Something went wrong');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Text("Loading");
                  }

                  return ListView(
                    // scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    children:
                        snapshot.data!.docs.map((DocumentSnapshot document) {
                      Map<String, dynamic> data =
                          document.data()! as Map<String, dynamic>;
                      // print((data["image_url"]).runtimeType);
                      // Null image = data["image_url"];
                      return Column(
                        children: [
                          // ListTile(
                          //   title: Text(data['email']),
                          // subtitle: Image.network(
                          //   data["image_url"],
                          //   width: 100,
                          //   height: 100,
                          // ),
                          // ),
                          Divider(),
                          AnimatedContainer(
                            duration: const Duration(
                              milliseconds: 200,
                            ),
                            child: Row(children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 10, 0,0),
                                child: Column(children: [
                                  // Text(data['status'] != -1
                                  //     ? (data['status'] == 1
                                  //         ? "Aproved"
                                  //         : "Decline")
                                  //     : "Pending"),
                                  Image.asset('assets/images/pdf_image.png',
                                      width: 100, height: 100),
                                ]),
                              ),
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                                    child: Column(children: [
                                      Text("Name: " + data['name']),
                                      Text("Society: " + data['society_name']),
                                      Text("Flat No: " + data['flat']),
                                    ]),
                                  ),
                                  Row(children: [
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: ElevatedButton(
                                        style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    Colors.red)),
                                        onPressed: () {
                                          FirebaseFirestore.instance
                                              .collection('request')
                                              .doc('request1')
                                              .update({'status': '0'});
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
                                        onPressed: () {
                                          FirebaseFirestore.instance
                                              .collection('request')
                                              .doc('request1')
                                              .update({'status': '1'});
                                        },
                                        child: const Text('Approve'),
                                      ),
                                    ),
                                  ])
                                ],
                              ),
                            ]),
                            height: 125,
                            width: 325,
                            decoration: BoxDecoration(
                                color: Colors.grey[300],
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
                          // const Divider(
                          //   color: Colors.indigo,
                          //   thickness: 1,
                          // ),
                        ],
                      );
                    }).toList(),
                  );
                },
              ),
              // Center(
              //   child: Padding(
              //     padding: const EdgeInsets.only(left: 24.0, right: 24.0),
              //     child: ElevatedButton(
              //       child: const Padding(
              //         padding: EdgeInsets.all(8.0),
              //         child: Text("log out "),
              //       ),
              //       onPressed: () async {
              //         await Authentication.signOut(context: context);

              //         Navigator.pushNamedAndRemoveUntil(
              //             context,
              //             SignInScreen.routeName,
              //             (Route<dynamic> route) => false);
              //       },
              //     ),
              //   ),
              // ),
            ],
          ),
        ]),
      ),
    );
  }
}
