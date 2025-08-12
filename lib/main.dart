import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myfront/data/repositories/ride_repository.dart';
import 'package:myfront/presentation/blocs/ride/ride_bloc.dart';
import 'package:myfront/presentation/blocs/users/user_bloc.dart';
import 'package:myfront/presentation/pages/home.dart';
import 'package:myfront/data/repositories/user_repository.dart';
import 'package:myfront/presentation/pages/register/login_regisster_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UserBloc>(
          create: (context) => UserBloc(
            userRepository: UserRepository(),
          ),
        ),
        BlocProvider<RideBloc>(
          create: (context) => RideBloc(
            rideRepository: RideRepository(),
          ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LoginRegissterPage(),
      ),
    );
  }
}
