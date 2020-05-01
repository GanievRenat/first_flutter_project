import 'package:flutter/material.dart';
import 'screens/feed_screen.dart';
import 'screens/photo_screen.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FullScreenImage(userName: 'kaparray'),
    );
  }
}
