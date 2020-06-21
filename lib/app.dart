import 'dart:async';
import 'package:flutter/material.dart';
import 'screens/home.dart';
import 'res/res.dart';
import 'package:connectivity/connectivity.dart';

class MyApp extends StatelessWidget {
  MyApp(this.onConnectivityChanged);

  final Stream<ConnectivityResult> onConnectivityChanged;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        accentColor: Colors.blue,
        textTheme: buildAppTextTheme(),
      ),
      home: Home(onConnectivityChanged),
    );
  }
}
