import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'pages/intro_page.dart';
import 'models/cart.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Cart(),
      child: Builder(
        builder: (context) => const MaterialApp(
          debugShowCheckedModeBanner: false,
          home: IntroPage(),
        ),
      ),
    );
  }
}
