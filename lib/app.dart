import 'package:atw_task/ui/auth/view_models/auth_cubit.dart';
import 'package:atw_task/ui/auth/views/pages/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
      create: (context) => AuthCubit(),
      child: MaterialApp(
        home:SignIn(),
      ),
    );
  }
}