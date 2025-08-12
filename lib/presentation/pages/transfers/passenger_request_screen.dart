import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myfront/core/data_color.dart';
import 'package:myfront/presentation/widgets/gemini_button.dart';
import 'package:myfront/presentation/widgets/gemini_dropdown.dart';
import 'package:myfront/presentation/widgets/gemini_text_box.dart';
import 'package:myfront/presentation/blocs/ride/ride_bloc.dart';
import 'package:myfront/presentation/blocs/ride/ride_event.dart';
import 'package:myfront/presentation/blocs/ride/ride_state.dart';

class PassengerRequestScreen extends StatefulWidget {
  const PassengerRequestScreen({super.key});

  @override
  State<PassengerRequestScreen> createState() => _PassengerRequestScreenState();
}

class _PassengerRequestScreenState extends State<PassengerRequestScreen> {
  
  String? _selectedOrigin;
  String? _selectedDestination;
  List<String> Origin = ["تجنک","دارکلا","آهن کتی","قجر مرحله","شهر"];
   List<String> Destination = ["محل","شهر",];
  @override
  Widget build(BuildContext context) {
    double screen_width = MediaQuery.of(context).size.width;
    double screen_height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: DataColor.backgroundColor,
        elevation: 0,
        title: const Text(
          "درخواست سفر",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: BlocListener<RideBloc, RideState>(
        listener: (context, state) {
          if (state is RideRequestCreated) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("درخواست سفر با موفقیت ارسال شد ✅")),
            );
            setState(() {
              _selectedOrigin = null;
              _selectedDestination = null;
            });
          } else if (state is RideError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("خطا: ${state.error}")),
            );
          }
        },
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: screen_height * 0.05),
              Icon(
                Icons.location_on,
                size: screen_height * 0.15,
                color: DataColor.backgroundColor,
              ),
              SizedBox(height: screen_height * 0.03),

              // فیلد مبدا
              Center(
                child: Padding(
                  padding: EdgeInsets.all(screen_height * 0.02),
                  child: GeminiDropdown(
                   label: " مبدا انتخاب کن ",
                   items: Origin,
                   dropdownColor: DataColor.tableRowEvenColor,
                   selectedValue: _selectedOrigin,
                   onChanged: (String? newValue) {
                     setState(() {
                       _selectedOrigin = newValue;
                     });
                   },
                   width: screen_width * 0.7,
                   height: screen_height * 0.1,
                   fontSize: 16,
                   radius: 12,
                   selectedBorderColor: Colors.purple,
                   unselectedBorderColor: Colors.grey.shade400,
                   labelColor: Colors.grey.shade600,
                   iconData: Icons.person_outline,
                   iconColor: Colors.purpleAccent,
                   hintText: "لطفا مبدا خود را انتخاب کنید...",
                                      ),
                ),
              ),

              // فیلد مقصد
              Center(
                child: GeminiDropdown(
                  label: " مقصد انتخاب کن ",
                  items: Destination,
                  dropdownColor: DataColor.tableRowEvenColor,
                  selectedValue: _selectedDestination,
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedDestination = newValue;
                    });
                  },
                  width: screen_width * 0.7,
                  height: screen_height * 0.1,
                  fontSize: 16,
                  radius: 12,
                  selectedBorderColor: Colors.purple,
                  unselectedBorderColor: Colors.grey.shade400,
                  labelColor: Colors.grey.shade600,
                  iconData: Icons.person_outline,
                  iconColor: Colors.purpleAccent,
                  hintText: "لطفا مقصد خود را انتخاب کنید...",
                                    ),
              ),

              SizedBox(height: screen_height * 0.04),

              // دکمه ارسال درخواست
              GeminiButton(
                text: 'ارسال درخواست سفر',
                onPressed: () {
                  if (_selectedOrigin != null && _selectedDestination != null) {
                    context.read<RideBloc>().add(
                            CreateRideRequest(
                              _selectedOrigin!,
                              _selectedDestination!,
                            ),
                          );
                    } else {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('خطا'),
                          content:
                              const Text('لطفاً مبدا و مقصد را وارد کنید.'),
                          actions: [
                            TextButton(
                              child: const Text("باشه"),
                              onPressed: () => Navigator.pop(context),
                            )
                          ],
                        );
                      },
                    );
                  }
                },
                width: screen_width * 0.7,
                height: screen_height * 0.09,
                radius: 20,
                fontSize: screen_width * 0.06,
                buttonColor: DataColor.backgroundColor,
                textColor: DataColor.textColor,
                iconData: Icons.send_rounded,
                iconColor: DataColor.accentColor,
                iconSize: 22,
                iconPadding: 12,
                iconPosition: IconPosition.leading,
                elevation: 4,
                splashColor: Colors.purpleAccent.withOpacity(0.3),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
