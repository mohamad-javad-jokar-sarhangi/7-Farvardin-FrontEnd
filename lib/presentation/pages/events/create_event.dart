import 'package:flutter/material.dart';
import 'package:myfront/core/vtext.dart';

class CreateEvent extends StatefulWidget {
  const CreateEvent({super.key});

  @override
  State<CreateEvent> createState() => _CreateEventState();
}

class _CreateEventState extends State<CreateEvent> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Container(
      child: VText().PersianText('Create Event', 70),
    ));
  }
}