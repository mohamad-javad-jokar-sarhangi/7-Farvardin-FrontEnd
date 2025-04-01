import 'package:flutter/material.dart';
import 'package:myfront/core/data_color.dart';
import 'package:myfront/presentation/pages/transfers/get_car.dart';
import 'package:myfront/presentation/pages/transfers/passenger_tmie.dart';
import 'package:myfront/presentation/pages/transfers/wtach_passenger.dart';
import 'package:myfront/presentation/widgets/vtext.dart';

class CarPage extends StatefulWidget {
  const CarPage({Key? key}) : super(key: key);

  @override
  State<CarPage> createState() => _CarPageState();
}

// اضافه کردن SingleTickerProviderStateMixin به کلاس _CarPageState
class _CarPageState extends State<CarPage> with SingleTickerProviderStateMixin {

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this); // 3 تب
  }

  @override
  void dispose() {
    _tabController.dispose(); // آزادسازی منابع
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screen_height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: VText().PersianText(' حمل نقل ', 30),
        centerTitle: true,
        backgroundColor: DataColor.backgroundColor,
        bottom: TabBar(
          controller: _tabController,
          labelColor: DataColor.accentColor,
          indicatorColor: DataColor.accentColor,
          unselectedLabelColor: DataColor.textColor,         
          tabs: [
            Tab(child: VText().PersianText(' ماشین گرفتن ', screen_height * 0.025)),
            Tab(child: VText().PersianText(' مشاهده زمان رفت و آمد مسافران ', screen_height * 0.025)),
            Tab(child: VText().PersianText(' صف حرکت ', screen_height * 0.025)), 
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          GetCar(), // محتوای تب اول
          PassengerTmie(), // محتوای تب دوم
          WtachPassenger() // محتوای تب سوم
        ],
      ),
    );
  }
}
