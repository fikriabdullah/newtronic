import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keluhanlayanan/bloc/complaintGet/getComplaint_cubit.dart';
import 'package:keluhanlayanan/bloc/complaintPush/addComplaint_cubit.dart';
import 'package:keluhanlayanan/pages/complaintForm.dart';
import 'package:keluhanlayanan/pages/dashboardComplaint.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/complaintForm',
      routes: {
        '/complaintForm' : (context) => BlocProvider(
            create: (context) => AddComplaintCubit(),
            child: complaintForm(),
        ),
        '/dashboardComplaint' : (context) => BlocProvider(
            create: (context) => GetComplaintCubit(),
            child: dashboardComplaint(),
        )
      },
    );
  }
}
