import 'package:flutter/material.dart';
import 'package:myfront/core/vtext.dart';
import 'package:myfront/presentation/pages/events/event_details.dart';
import 'package:myfront/presentation/widgets/row_of_event.dart';

class ListEvent extends StatefulWidget {
  const ListEvent({super.key});

  @override
  State<ListEvent> createState() => _ListEventState();
}

class _ListEventState extends State<ListEvent> {
  final String longArticleText = '''
    این یک مقاله طولانی است با متن فارسی.
    این متن می‌تواند خیلی طولانی باشد و شامل چندین پاراگراف.

    پاراگراف دوم در اینجا شروع می‌شود.
    و می‌تواند ادامه پیدا کند.

    پاراگراف سوم و همینطور ادامه...
    ''';
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        RowOfEvent(
          eventTitle: 'قطعی اب',
          onIconPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ArticleView(
                      writer: 'ارمین',
                      title: 'قطعی اب',
                      articleText: longArticleText
                      ),
                ),
              );      
          },
        ),
        RowOfEvent(
          eventTitle: 'قطعی برق',
          onIconPressed: () {
            
          },
        ),
        RowOfEvent(
          eventTitle: ' مراسم ',
          onIconPressed: () {
            
          },
        ),
      ],
    );
  }
}