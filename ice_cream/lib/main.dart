import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'pages/home_page.dart';
import 'models/cart.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => Cart(), 
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Cart(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
        textTheme: GoogleFonts.syneTextTheme(),
      ),
        home: Scaffold(
          body: Stack(
            children: [
              // Background image
              Positioned.fill(
                child: Image.asset(
                  'lib/images/gradient_background.jpg', 
                  fit: BoxFit.cover,
                ),
              ),
              //  App content
              const HomePage(),
            ],
          ),
        ),
      ),
    );
  }
}
