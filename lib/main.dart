import "package:flutter/material.dart";
import 'package:to_do_list/pages/home_page.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "To-Do List",
      theme: ThemeData(
        primaryColor: const Color(0xFF004258),
        primarySwatch: Colors.indigo,
      ),
      home: const HomePage(),
    );
  }
}