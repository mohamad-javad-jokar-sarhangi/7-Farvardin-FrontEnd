import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myfront/core/data_color.dart';
import 'package:myfront/data/models/ride_request.dart';
import 'package:myfront/presentation/blocs/ride/ride_bloc.dart';
import 'package:myfront/presentation/blocs/ride/ride_event.dart';
import 'package:myfront/presentation/blocs/ride/ride_state.dart';
import 'package:myfront/presentation/widgets/gemini_button.dart';

class DriverRequestsScreen extends StatefulWidget {
  const DriverRequestsScreen({super.key});

  @override
  State<DriverRequestsScreen> createState() => _DriverRequestsScreenState();
}

class _DriverRequestsScreenState extends State<DriverRequestsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<RideBloc>().add(GetDriverRequests());
  }

  @override
  Widget build(BuildContext context) {
    double screen_width = MediaQuery.of(context).size.width;
    double screen_height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: DataColor.backgroundColor,
        elevation: 0,
        title: const Text(
          "درخواست‌های مسافران",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: BlocConsumer<RideBloc, RideState>(
        listener: (context, state) {
          if (state is RideAccepted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("درخواست با موفقیت پذیرفته شد ✅")),
            );
            context.read<RideBloc>().add(GetDriverRequests());
          } else if (state is RideError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("خطا: ${state.error}")),
            );
          }
        },
        builder: (context, state) {
          if (state is RideLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is DriverRequestsLoaded) {
            if (state.requests.isEmpty) {
              return const Center(child: Text("هیچ درخواست فعالی وجود ندارد."));
            }

            return ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: state.requests.length,
              itemBuilder: (context, index) {
                RideRequest request = state.requests[index];
                return Card(
                  margin: EdgeInsets.symmetric(
                      horizontal: screen_width * 0.05,
                      vertical: screen_height * 0.015),
                  color: DataColor.tableRowEvenColor.withOpacity(0.9),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "مسافر: ${request.passengerName}",
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.right,
                        ),
                        const SizedBox(height: 6),
                        Text(
                          "مبدا: ${request.pickup}",
                          style: const TextStyle(fontSize: 16),
                          textAlign: TextAlign.right,
                        ),
                        Text(
                          "مقصد: ${request.destination}",
                          style: const TextStyle(fontSize: 16),
                          textAlign: TextAlign.right,
                        ),
                        const SizedBox(height: 10),
                        GeminiButton(
                          text: "پذیرفتن درخواست",
                          onPressed: () {
                            context
                                .read<RideBloc>()
                                .add(AcceptRideRequest(request.id));
                          },
                          width: double.infinity,
                          height: 45,
                          radius: 12,
                          fontSize: 16,
                          buttonColor: DataColor.backgroundColor,
                          textColor: DataColor.textColor,
                          iconData: Icons.check_circle_outline,
                          iconColor: DataColor.accentColor,
                          iconSize: 20,
                          iconPadding: 8,
                          iconPosition: IconPosition.leading,
                          elevation: 2,
                          splashColor:
                              Colors.greenAccent.withOpacity(0.3),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(child: Text("در حال بارگذاری اطلاعات..."));
          }
        },
      ),
    );
  }
}
