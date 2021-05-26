import 'dart:io';
import 'package:flutter/material.dart';
import 'package:weather_submit/common/pages/connectSocket.dart';
import 'package:window_size/window_size.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isWindows) {
    setWindowTitle('Login');
    setWindowMinSize(const Size(1200, 1000));
    setWindowMaxSize(Size.infinite);
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Connect to server',
      debugShowCheckedModeBanner: false,
      home: ConnectSocket(),
    );
  }
}
