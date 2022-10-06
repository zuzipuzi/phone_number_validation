import 'package:flutter/material.dart';
import 'package:phone_number_validation/src/di/di_host.dart';
import 'package:phone_number_validation/src/presentation/base/cubit/host_cubit.dart';
import 'package:phone_number_validation/src/presentation/features/screens/home/home_screen.dart';
import 'package:phone_number_validation/src/presentation/features/screens/home/home_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return DIHost(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: "Inter"),
        title: 'Phone number validation',
        home: const HostCubit<HomeCubit>(child: HomeScreen()),
      ),
    );
  }
}
