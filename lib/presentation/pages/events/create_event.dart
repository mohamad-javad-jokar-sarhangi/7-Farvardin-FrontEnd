import 'package:flutter/material.dart';
import 'package:myfront/core/data_color.dart';
import 'package:myfront/presentation/widgets/text_box.dart';

class CreateEvent extends StatefulWidget {
  const CreateEvent({super.key});
  @override
  State<CreateEvent> createState() => _CreateEventState();
}


class _CreateEventState extends State<CreateEvent> {
  TextEditingController titel = TextEditingController();
  TextEditingController box = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double screen_width = MediaQuery.of(context).size.width;
    double screen_height = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(height: screen_height * 0.01,),
          TextBox(
            name: ' موضوع ',
            width: screen_width * 0.7,
            height: screen_height * 0.07,
            containerColor: DataColor.backgroundColor,
            cursorColor: DataColor.accentColor,
            textColor: DataColor.textColor,
            labelColor: DataColor.backgroundColor,
            radius: 25,
            fontSize: 20, 
            tc: titel,
          ),
          SizedBox(height: screen_height * 0.01,),
          TextAreaBox(
            name: 'محتوا',
            width: screen_width * 0.9,
            hintText: '',
            maxHeight: screen_height * 0.5,
            minHeight: 10,
            containerColor: DataColor.backgroundColor,
            cursorColor: DataColor.accentColor,
            textColor: DataColor.textColor,
            labelColor: DataColor.backgroundColor,
            radius: 25,
            fontSize: 20, 
            tc: box,
          ),
        ],
      ),
    );
  }
}