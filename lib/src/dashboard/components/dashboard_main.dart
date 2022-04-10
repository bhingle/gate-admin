import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:gate_admin/src/dashboard/components/residents_dashboard.dart';

class DashboardMain extends StatefulWidget {
  const DashboardMain({Key? key, required this.menu}) : super(key: key);
  final String menu;

  @override
  State<DashboardMain> createState() => _DashboardMainState();
}

class _DashboardMainState extends State<DashboardMain> {
//   String  menu;
//  _DashboardMainState(this.menu);
  int _selectedIndex = 0;
  late List<Widget> _widgetOptions;
  @override
  void initState() {
    _widgetOptions = <Widget>[
      ResidentsDashboard(menutype: widget.menu, status: 'pending'),
      ResidentsDashboard(menutype: widget.menu, status: 'approve'),
      ResidentsDashboard(menutype: widget.menu, status: 'decline'),
    ];
    super.initState();
  }

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
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
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
                  icon: LineIcons.home,
                  text: 'Pending',
                ),
                GButton(
                  icon: LineIcons.heart,
                  text: 'Approved',
                ),
                GButton(
                  icon: LineIcons.search,
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
