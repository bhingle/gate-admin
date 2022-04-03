// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:safe_gate/src/add_member_data/add_member_data_screen.dart';
// import 'package:safe_gate/src/login/sign_in_screen.dart';
// import 'dart:ffi';
// import 'dart:io';
// import 'package:safe_gate/src/login/utils/authentication.dart';

// class DashboardScreen extends StatefulWidget {
//   const DashboardScreen({Key? key}) : super(key: key);

//   static const routeName = '/dashboard';
//   @override
//   _DashboardScreenState createState() => _DashboardScreenState();
// }

// class _DashboardScreenState extends State<DashboardScreen>
//     with SingleTickerProviderStateMixin {
//   final _formKey = GlobalKey<FormState>();
//   late AnimationController _controller;

//   String imgUrl = "";
//   final userMail = FirebaseAuth.instance.currentUser!.email;
//   final userID = FirebaseAuth.instance.currentUser!.uid;
//   String society_name = "";
//   void getOwnerImage() async {
//     await FirebaseFirestore.instance
//         .collection("users")
//         .doc(userMail)
//         .get()
//         .then((value) {
//       setState(() {
//         society_name = value.data()!["society_name"].toString();
//       });
//     });
//     await FirebaseFirestore.instance
//         .collection("societies")
//         .doc(society_name)
//         .collection("members")
//         .doc(userID)
//         .get()
//         .then((value) {
//       setState(() {
//         imgUrl = value.data()!["image_url"].toString();
//       });
//     });
//   }

//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(vsync: this);
//     getOwnerImage();
//     // print(
//     //     "++++++++++++++++++++++++++++++++++++++++ hiii ++++++++++++++++++++++++++++");
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     _controller.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     // family members data
//     // print(society_name);
//     final Stream<QuerySnapshot> _membersStream = FirebaseFirestore.instance
//         .collection('societies')
//         .doc(society_name)
//         .collection("members")
//         .doc(userID)
//         .collection("family")
//         .snapshots();

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Dashboard"),
//       ),
//       body: SingleChildScrollView(
//         child: Column(children: <Widget>[
//           Column(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               const Center(child: Text("Flat Owner Data")),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Row(
//                   children: [
//                     Card(
//                       child: (imgUrl == "")
//                           ? const Text("Loading ...")
//                           : Image.network(
//                               imgUrl,
//                               width: 100,
//                               height: 100,
//                             ),
//                     ),
//                     Column(
//                       children: [
//                         const Text("Viresh Fegade"),
//                         ElevatedButton(
//                           child: const Padding(
//                             padding: EdgeInsets.all(8.0),
//                             child: Text("Update Photo"),
//                           ),
//                           onPressed: () async {},
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//               const Divider(color: Colors.indigo),
//               ElevatedButton(
//                 child: const Padding(
//                   padding: EdgeInsets.all(8.0),
//                   child: Text("Add Family Member Data"),
//                 ),
//                 onPressed: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => const AddMemberDataScreen(),
//                     ),
//                   );
//                 },
//               ),
//               const Divider(
//                 color: Colors.indigo,
//                 thickness: 3,
//               ),
//               //family members list
//               const Text("Family Members"),
//               StreamBuilder<QuerySnapshot>(
//                 stream: _membersStream,
//                 builder: (BuildContext context,
//                     AsyncSnapshot<QuerySnapshot> snapshot) {
//                   if (snapshot.hasError) {
//                     return const Text('Something went wrong');
//                   }
      
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return const Text("Loading");
//                   }
      
//                   return ListView(
//                     // scrollDirection: Axis.vertical,
//                     shrinkWrap: true,
//                     children:
//                         snapshot.data!.docs.map((DocumentSnapshot document) {
//                       Map<String, dynamic> data =
//                           document.data()! as Map<String, dynamic>;
//                       // print((data["image_url"]).runtimeType);
//                       // Null image = data["image_url"];
//                       return Column(
//                         children: [
//                           ListTile(
//                             title: Text(data['name']),
//                             subtitle: Image.network(
//                               data["image_url"],
//                               width: 100,
//                               height: 100,
//                             ),
//                           ),
//                           const Divider(
//                             color: Colors.indigo,
//                             thickness: 1,
//                           ),
//                         ],
//                       );
//                     }).toList(),
//                   );
//                 },
//               ),
//               Center(
//                 child: Padding(
//                   padding: const EdgeInsets.only(left: 24.0, right: 24.0),
//                   child: ElevatedButton(
//                     child: const Padding(
//                       padding: EdgeInsets.all(8.0),
//                       child: Text("log out "),
//                     ),
//                     onPressed: () async {
//                       await Authentication.signOut(context: context);
      
//                       Navigator.pushNamedAndRemoveUntil(
//                           context,
//                           SignInScreen.routeName,
//                           (Route<dynamic> route) => false);
//                     },
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ]),
//       ),
//     );
//   }
// }