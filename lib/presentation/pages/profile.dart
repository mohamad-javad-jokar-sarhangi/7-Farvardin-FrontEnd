import 'package:flutter/material.dart';
import 'package:myfront/core/data_color.dart';
import 'package:myfront/core/vtext.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: VText().PersianText('Profile', 70),
      ),
    );
  }
}