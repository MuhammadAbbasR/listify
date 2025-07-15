import 'package:flutter/material.dart';
import 'package:listify/ui/Splash_Screen.dart';
import 'package:listify/view_model/Quote_viewModel.dart';
import 'package:listify/view_model/Task_View_model.dart';


import 'package:provider/provider.dart';

void main() => runApp(MultiProvider(
  providers: [
    ChangeNotifierProvider(
      create: (_) => Quote_ViewModel(),
    ),
    ChangeNotifierProvider(
      create: (_) => TaskViewModel(),
    )
  ],
  child: MyApp(),
));

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}
