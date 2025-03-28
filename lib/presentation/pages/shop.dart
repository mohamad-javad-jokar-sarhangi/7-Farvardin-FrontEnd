import 'package:flutter/material.dart';
import 'package:myfront/core/data_color.dart';
import 'package:myfront/core/vtext.dart';

class Shop extends StatefulWidget {
  const Shop({super.key});

  @override
  State<Shop> createState() => _ShopState();
}

class _ShopState extends State<Shop> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: VText().PersianText('Shop', 70),
      ),
    );
  }
}