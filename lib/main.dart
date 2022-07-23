import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_search_users_app/cubit/user_cubit.dart';
import 'package:github_search_users_app/ui/pages/user_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => UserCubit(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: UserPage(),
      ),
    );
  }
}
