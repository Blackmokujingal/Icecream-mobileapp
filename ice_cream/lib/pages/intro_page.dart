import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ice_cream/pages/home_page.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({Key? key}) : super(key: key);

  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // Animation setup
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0, end: 15).animate(_controller);
  }

  void openHomePage(BuildContext context) {
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => const HomePage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onHorizontalDragEnd: (details) {
          if (details.primaryVelocity! < 0) {
            // Swipe left, open the home page with a left-to-right slide
            openHomePage(context);
          }
        },
        child: Stack(
          children: [
            // Background Image
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('lib/images/cloud-background.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            Scaffold(
              backgroundColor: Colors.transparent,
              body: Stack(
                alignment: Alignment.topCenter,
                children: [
                  // Logo
                  Transform.scale(
                    scale: 1.3,
                    child: Image.asset(
                      'lib/images/logo-small.png',
                      height: 300,
                    ),
                  ),

                  // Animated 3D ice cream pot with vertical movement
                  AnimatedBuilder(
                    animation: _animation,
                    builder: (context, child) {
                      return Positioned(
                        top: 225 + _animation.value,
                        child: Image.asset(
                          'lib/images/3d-pot.png',
                          height: 300,
                        ),
                      );
                    },
                  ),

                  // Add vertical padding
                  const SizedBox(height: 16),

                  // Text
                  Positioned(
                    bottom: 200,
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Peace, Love & Ice Cream',
                        style: GoogleFonts.zillaSlab(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),

                  // Footer
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Image.asset(
                      'lib/images/grass.png',
                      fit: BoxFit.cover,
                    ),
                  ),

                  // Leftward Arrow with Text
                  Positioned(
                    bottom: 60,
                    child: Row(
                      children: [
                        const Text(
                          'Find your flavor',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Transform.translate(
                          offset: Offset(-_animation.value, 0),
                          child: const Icon(
                            Icons.arrow_forward_ios,
                            size: 40,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

void main() {
  runApp(const MaterialApp(
    home: IntroPage(),
  ));
}
