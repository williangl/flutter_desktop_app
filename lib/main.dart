import 'package:flutter/material.dart';
import 'package:myapp/theme/theme.dart';
import 'package:myapp/pages/home/page.dart';


void main() {
  runApp(DesktopApp());
}

class DesktopApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Desktop App',
      home: HomePage(),
      theme: AppTheme.getTheme(context),
    );
  }
}