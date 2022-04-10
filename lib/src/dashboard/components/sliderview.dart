import 'package:flutter/material.dart';
import 'package:gate_admin/src/dashboard/components/slidermenuitem.dart';

class SliderView extends StatelessWidget {
  final Function(String)? onItemClick;

  const SliderView({Key? key, this.onItemClick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.only(top: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 30,
          ),
          CircleAvatar(
            radius: 65,
            backgroundColor: Colors.grey,
            child: CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage('assets/images/pdf_image.png'),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'Nick',
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 30,
                fontFamily: 'BalsamiqSans'),
          ),
          SizedBox(
            height: 20,
          ),
          SliderMenuItem(
              title: 'resident', iconData: Icons.home, onTap: onItemClick),
          SliderMenuItem(
              title: 'society',
              iconData: Icons.add_circle,
              onTap: onItemClick),
          // SliderMenuItem(
          //     title: 'logs',
          //     iconData: Icons.notifications_active,
          //     onTap: onItemClick),
          // SliderMenuItem(
          //     title: 'Likes', iconData: Icons.favorite, onTap: onItemClick),
          // SliderMenuItem(
          //     title: 'Setting', iconData: Icons.settings, onTap: onItemClick),
          // SliderMenuItem(
          //     title: 'LogOut',
          //     iconData: Icons.arrow_back_ios,
          //     onTap: onItemClick),
        ],
      ),
    );
  }
}