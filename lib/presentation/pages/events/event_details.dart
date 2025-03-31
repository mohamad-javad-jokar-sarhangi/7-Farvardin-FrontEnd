import 'package:flutter/material.dart';
import 'package:myfront/core/data_color.dart';
import 'package:myfront/core/vtext.dart';

class ArticleView extends StatelessWidget {
  final String articleText;
  final String? title;
  final String writer;

  const ArticleView({
    Key? key, 
    required this.articleText,
    required this.title,
    required this.writer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screen_width = MediaQuery.of(context).size.width;
    double screen_height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(title ?? 'مقاله', style: TextStyle(color: Colors.white)),
        backgroundColor: DataColor.backgroundColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          width: screen_width,
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: DataColor.backgroundColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              VText().PersianText(' نویسنده :   ${writer} ', screen_height * 0.03),
              if (title != null) ...[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: VText().PersianText(' موضوع :   ${title} ', screen_height * 0.03),
                ),
                Container(
                  height: 3,
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  color: DataColor.accentColor,
                ),
                SizedBox(height: 16),
              ],
              Directionality(
                textDirection: TextDirection.rtl,
                child: Text(
                  _formatArticleText(articleText),
                  style: TextStyle(
                    fontSize: screen_height * 0.03,
                    color: DataColor.textColor,
                    height: 1.5,
                    fontFamily: 'vazir', // اگر VText از فونت خاصی استفاده می‌کند
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  // این تابع فاصله‌های اضافی ابتدای خطوط را حذف می‌کند
  String _formatArticleText(String text) {
    // حذف فاصله‌های اضافی ابتدای هر خط
    List<String> lines = text.split('\n');
    List<String> trimmedLines = lines.map((line) => line.trimLeft()).toList();
    return trimmedLines.join('\n');
  }
}
