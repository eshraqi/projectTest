import 'package:flutter/material.dart';
import 'main_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'taskArmanAmin',
      theme: ThemeData(
        fontFamily: 'vazirmatn',
        primaryColor: const Color(0xff075E54),
      ),
      debugShowCheckedModeBanner: false,
      home: const MainScreen(),
    );
  }


}

