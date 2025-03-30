import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:myfront/core/data_color.dart';
import 'package:myfront/core/vtext.dart';
import 'package:myfront/presentation/pages/add_user_page.dart';
import 'package:myfront/presentation/pages/admin_pages/car.dart';
import 'package:myfront/presentation/pages/admin_pages/profile.dart';
import 'package:myfront/presentation/pages/admin_pages/shop.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int index = 1; 
  final screen = [
    Car(),
    Profile(),
    Shop(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [IconButton(onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => Register())); 
        }, icon: Icon(Icons.account_box_outlined, color: DataColor.iconColor, size: 30,))],
        title: VText().PersianText('محله ما', 30),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.white,
        color: Colors.deepPurple,
        index: index,
          items: <Widget>[
            Icon(Icons.car_crash_sharp, color: DataColor.iconColor, size: 30,),
            Icon(Icons.person, color: DataColor.iconColor,size: 30),
            Icon(Icons.shop, color: DataColor.iconColor,size: 30),
        ],
        onTap: (index) => setState(() => this.index = index),
  ),
  body: screen[index],
);
  }
}