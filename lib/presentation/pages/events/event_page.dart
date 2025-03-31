// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:myfront/core/data_color.dart';
import 'package:myfront/core/vtext.dart';
import 'package:myfront/presentation/pages/events/create_event.dart';
import 'package:myfront/presentation/pages/events/list_event.dart';

class EventPage extends StatefulWidget {
  const EventPage({Key? key}) : super(key: key);

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> with SingleTickerProviderStateMixin {
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
          unselectedLabelColor: DataColor.textColor,
          tabs: [
            Tab(child: VText().PersianText('مشاهده رویداد ها', screen_height * 0.025)), // تب اول
            Tab(child: VText().PersianText('ساخت رویداد ها', screen_height * 0.025)), // تب دوم
            
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          ListEvent(), // محتوای تب اول
          CreateEvent(), // محتوای تب دوم
              
        ],
      ),
    );
  }
}
