import 'dart:async';

import 'package:flutter/material.dart';
import 'main.dart';
import 'screens/home.dart';
import 'res/res.dart';
import 'package:connectivity/connectivity.dart';

class MyApp extends StatefulWidget {
  MyApp(this.onConnectivityChanged);

  final Stream<ConnectivityResult> onConnectivityChanged;

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  StreamSubscription subscription;
  var connectiveOverlay = ConnectivityOverlay();

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  BuildContext _contextForOverlay;

  @override
  void initState() {
    super.initState();
    subscription = widget.onConnectivityChanged.listen((ConnectivityResult result) {
      switch (result) {
        case ConnectivityResult.wifi:
          // Вызовете удаление Overlay тут
          connectiveOverlay.removeOverlay(_contextForOverlay);
          break;
        case ConnectivityResult.mobile:
          // Вызовете удаление Overlay тут
          connectiveOverlay.removeOverlay(_contextForOverlay);
          break;
        case ConnectivityResult.none:
          // Вызовете отображения Overlay тут
          connectiveOverlay.showOverlay(_contextForOverlay, Text('No internet connection'));
          break;
      }
    });
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        accentColor: Colors.blue,
        textTheme: buildAppTextTheme(),
      ),
      home: Builder(
        builder: (context) {
          _contextForOverlay = context;
          return Home();
        },
      ),
    );
  }
}
