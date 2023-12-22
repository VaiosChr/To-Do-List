import "package:flutter/material.dart";
import 'package:to_do_list/pages/home_page.dart';
import 'package:provider/provider.dart';

import 'package:to_do_list/notifier.dart';
void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => MyNotifier(),
      child: const MyApp(),
    ),
  );
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
