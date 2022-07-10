import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:object_detection/ui/home_view.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  log("Start");
  MyApp.imgDir = (await getExternalStorageDirectory()).path;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static String imgDir;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Real_you',
      theme: ThemeData(
        primarySwatch: Colors.grey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeView(),
    );
  }
}
