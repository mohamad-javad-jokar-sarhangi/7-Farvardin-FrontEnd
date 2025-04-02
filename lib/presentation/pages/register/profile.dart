import 'package:flutter/material.dart';
import 'package:myfront/core/data_color.dart';
import 'package:myfront/presentation/widgets/vtext.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String name = 'محمد جواد';
  String phone = '0911431694';
  String userType = 'کاربر عادی';
  
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: VText().PersianText('پروفایل', 30),
        centerTitle: true,
        backgroundColor: DataColor.backgroundColor,
        elevation: 0,
      ),
      // SingleChildScrollView به صفحه اضافه شده تا قابلیت اسکرول داشته باشد
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(), // برای اضافه کردن حس اسکرول بهتر
        child: Column(
          children: [
            // بخش بالایی با آواتار
            Container(
              padding: EdgeInsets.only(bottom: 15),
              width: double.infinity,
              decoration: BoxDecoration(
                color: DataColor.backgroundColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
              ),
              child: Column(
                children: [
                  SizedBox(height: 15),
                  
                  // نام کاربر زیر آواتار
                  VText().PersianText(name, screenWidth * 0.07, color: Colors.white),

                  // نوع کاربری زیر نام
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    decoration: BoxDecoration(
                      color: DataColor.accentColor.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: VText().PersianText(userType, screenWidth * 0.04, color: Colors.white),
                  ),
                ],
              ),
            ),
                        
            // بخش کارت‌های اطلاعات
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  // کارت اطلاعات شخصی
                  _buildInfoCard(
                    context: context,
                    title: 'اطلاعات شخصی',
                    items: [
                      {'عنوان': 'نام کاربری', 'مقدار': name, 'آیکون': Icons.person},
                      {'عنوان': 'شماره تماس', 'مقدار': phone, 'آیکون': Icons.phone},
                      {'عنوان': 'نوع کاربری', 'مقدار': userType, 'آیکون': Icons.people},
                    ],
                  ),
                  
                  SizedBox(height: 20),
                  
                  // دکمه ویرایش پروفایل
                  Container(
                    width: double.infinity,
                    height: 55,
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: ElevatedButton(
                      onPressed: () {
                        // عملکرد دکمه ویرایش پروفایل
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: DataColor.accentColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.edit, color: DataColor.backgroundColor , size: screenWidth * 0.08,),
                          SizedBox(width: 10),
                          VText().PersianText('ویرایش پروفایل', screenWidth * 0.05, color: DataColor.backgroundColor),
                        ],
                      ),
                    ),
                  ),
                  
                ],
              ),
            ),
            SizedBox(height: 25),
          ],
        ),
      ),
    );
  }

  // ویجت کارت اطلاعات
  Widget _buildInfoCard({
    required BuildContext context,
    required String title,
    required List<Map<String, dynamic>> items,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: DataColor.backgroundColor.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // عنوان کارت
          Padding(
            padding: const EdgeInsets.only(right: 10, bottom: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                VText().PersianText(title, MediaQuery.of(context).size.width * 0.07, color: DataColor.backgroundColor),
                SizedBox(width: 5),
                Icon(Icons.info_outline, color: DataColor.accentColor, size: MediaQuery.of(context).size.width * 0.07),
              ],
            ),
          ),
          
          // جدا کننده
          Divider(color: DataColor.backgroundColor.withOpacity(0.2)),
          
          // آیتم‌های اطلاعات
          ...items.map((item) => _buildInfoItem(
            context: context,
            title: item['عنوان'],
            value: item['مقدار'],
            icon: item['آیکون'],
          )),
        ],
      ),
    );
  }

  // ویجت آیتم اطلاعات
  Widget _buildInfoItem({
    required BuildContext context,
    required String title,
    required String value,
    required IconData icon,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // مقدار (سمت چپ)
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.left,
              style: TextStyle(
                fontFamily: 'Vazir',
                fontSize: MediaQuery.of(context).size.width * 0.045,
                color: Colors.black87,
              ),
            ),
          ),
          
          // عنوان و آیکون (سمت راست)
          Row(
            children: [
              VText().PersianText(title, MediaQuery.of(context).size.width * 0.055, color: Colors.black54),
              SizedBox(width: 5),
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: DataColor.backgroundColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: DataColor.accentColor, size: MediaQuery.of(context).size.width * 0.07),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
