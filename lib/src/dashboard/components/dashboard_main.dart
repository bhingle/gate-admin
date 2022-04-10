import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:gate_admin/src/dashboard/components/residents_dashboard.dart';

class DashboardMain extends StatefulWidget {
  const DashboardMain({Key? key, required this.menu}) : super(key: key);
  final String menu;
  // final BuildContext context;

  @override
  State<DashboardMain> createState() => _DashboardMainState();
}

class _DashboardMainState extends State<DashboardMain> {
//   late String  menu;
//  _DashboardMainState(menu){
//    menu=this.menu;
//  }
  int _selectedIndex = 0;
  // var widgetOptions;
  @override
  // late BuildContext context;
  @override
  void initState() {
    // widgetOptions = <Widget>[
    //   ResidentsDashboard(menutype: widget.menu, status: 'pending'),
    //   ResidentsDashboard(menutype: widget.menu, status: 'approve'),
    //   ResidentsDashboard(menutype: widget.menu, status: 'decline'),
    // ];
    // context = widget.context;
    super.initState();
  }
  final List<String> _status=['pending','approve','decline'];
  //  var widgetOptions = <Widget>[
  //     ResidentsDashboard(menutype: menu, status: 'pending'),
  //     ResidentsDashboard(menutype: menu, status: 'approve'),
  //     ResidentsDashboard(menutype: widget.menu, status: 'decline'),
  //   ];

  //String menu=menu;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.w600);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      // appBar: AppBar(
      //   elevation: 20,
      //   title: const Text('Resident Requests'),
      // ),
      body: ResidentsDashboard(menutype: widget.menu, status: _status.elementAt(_selectedIndex)),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              rippleColor: Colors.grey[300]!,
              hoverColor: Colors.grey[100]!,
              gap: 8,
              activeColor: Colors.black,
              iconSize: 24,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: Duration(milliseconds: 400),
              tabBackgroundColor: Colors.grey[100]!,
              color: Colors.black,
              tabs: [
                GButton(
                  icon: IconData(0xee2b, fontFamily: 'MaterialIcons'),
                  text: 'Pending',
                ),
                GButton(
                  icon: IconData(0xf47d, fontFamily: 'MaterialIcons'),
                  text: 'Approved',
                ),
                GButton(
                  icon: IconData(0xf0fe, fontFamily: 'MaterialIcons'),
                  text: 'Declined',
                ),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}

// Widget DashboardMain(BuildContext context){
//   return Scaffold(
//       // backgroundColor: Colors.white,
//       // appBar: AppBar(
//       //   elevation: 20,
//       //   title: const Text('Resident Requests'),
//       // ),
//       body: _widgetOptions.elementAt(_selectedIndex),
//       bottomNavigationBar: Container(
//         decoration: BoxDecoration(
//           color: Colors.white,
//           boxShadow: [
//             BoxShadow(
//               blurRadius: 20,
//               color: Colors.black.withOpacity(.1),
//             )
//           ],
//         ),
//         child: SafeArea(
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
//             child: GNav(
//               rippleColor: Colors.grey[300]!,
//               hoverColor: Colors.grey[100]!,
//               gap: 8,
//               activeColor: Colors.black,
//               iconSize: 24,
//               padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
//               duration: Duration(milliseconds: 400),
//               tabBackgroundColor: Colors.grey[100]!,
//               color: Colors.black,
//               tabs: [
//                 GButton(
//                   icon: LineIcons.home,
//                   text: 'Pending',
//                 ),
//                 GButton(
//                   icon: LineIcons.heart,
//                   text: 'Approved',
//                 ),
//                 GButton(
//                   icon: LineIcons.search,
//                   text: 'Declined',
//                 ),
//               ],
//               selectedIndex: _selectedIndex,
//               onTabChange: (index) {
//                 setState(() {
//                   _selectedIndex = index;
//                 });
//               },
//             ),
//           ),
//         ),
//       ),
//     );

// }
