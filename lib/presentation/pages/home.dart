import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:myfront/core/data_color.dart';
import 'package:myfront/presentation/pages/register/login_regisster_page.dart';
import 'package:myfront/presentation/pages/register/profile.dart';
import 'package:myfront/presentation/pages/register/waiting_page.dart';
import 'package:myfront/presentation/pages/transfers/driver_requests_screen.dart';
import 'package:myfront/presentation/pages/transfers/passenger_request_screen.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int index = 1; 
  final screen = [
    DriverRequestsScreen(),
    Profile(),
    PassengerRequestScreen(),
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
            Icon(Icons.car_repair, color: DataColor.textColor,size: 30),
            Icon(Icons.person, color: DataColor.textColor,size: 30),
            Icon(Icons.car_repair_sharp, color: DataColor.textColor,size: 30),
        ],
        onTap: (index) => setState(() => this.index = index),
  ),
  body: screen[index],
);
  }
}