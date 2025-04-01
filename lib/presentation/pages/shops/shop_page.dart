import 'package:flutter/material.dart';
import 'package:myfront/core/data_color.dart';
import 'package:myfront/presentation/pages/shops/create_products.dart';
import 'package:myfront/presentation/pages/shops/product_list.dart';
import 'package:myfront/presentation/widgets/vtext.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({Key? key}) : super(key: key);

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this); // 2 تب
  }

  @override
  Widget build(BuildContext context) {
    double screen_height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: VText().PersianText('رویدادها', 30),
        centerTitle: true,
        backgroundColor: DataColor.backgroundColor,
        bottom: TabBar(
          controller: _tabController,
          labelColor: DataColor.accentColor,
          indicatorColor: DataColor.accentColor,
          unselectedLabelColor: DataColor.textColor,         
          tabs: [
            Tab(child: VText().PersianText('مشاهده لیست کالا', screen_height * 0.024)), // تب اول
            Tab(child: VText().PersianText('ساخت کالا ها', screen_height * 0.024)), // تب دوم
            
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          ProductList(), // محتوای تب اول
          CreateProducts(), // محتوای تب دوم   
        ],
      ),
    );
  }
}
