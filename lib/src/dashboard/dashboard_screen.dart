import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:gate_admin/src/dashboard/components/sliderview.dart';
import 'package:gate_admin/src/dashboard/components/dashboard_main.dart';
class DashboardScreen extends StatefulWidget {
  const DashboardScreen({ Key? key }) : super(key: key);
  static const routeName = '/dashboard';

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  GlobalKey<SliderDrawerState> _key = GlobalKey<SliderDrawerState>();
  late String title;

  @override
  void initState() {
    title = "resident";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SliderDrawer(
            appBar: SliderAppBar(
                appBarColor: Colors.transparent,
                title: Text(title,
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.w700))),
            key: _key,
            sliderOpenSize: 179,
            slider: SliderView(
              onItemClick: (title) {
                _key.currentState!.closeSlider();
                setState(() {
                  this.title = title;
                });
              },
            ),
            child: DashboardMain(menu:title)),
      );
  }
}