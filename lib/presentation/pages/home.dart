import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:myfront/core/data_color.dart';
import 'package:myfront/core/vtext.dart';
import 'package:myfront/presentation/pages/add_user_page.dart';
import 'package:myfront/presentation/pages/admin_pages/car.dart';
import 'package:myfront/presentation/pages/admin_pages/profile.dart';
import 'package:myfront/presentation/pages/admin_pages/shop.dart';
import 'package:myfront/presentation/pages/events/event_page.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int index = 0; 
  final screen = [
    EventPage(),
    Car(),
    Shop(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        color: DataColor.backgroundColor,
        buttonBackgroundColor: DataColor.accentColor,
        index: index,
          items: <Widget>[
            Icon(Icons.event, color: DataColor.textColor, size: 30,),
            Icon(Icons.car_repair, color: DataColor.textColor,size: 30),
            Icon(Icons.shop, color: DataColor.textColor,size: 30),
        ],
        onTap: (index) => setState(() => this.index = index),
  ),
  body: screen[index],
);
  }
}