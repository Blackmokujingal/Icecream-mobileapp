import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ice_cream/_components/bottom_navbar.dart';
import 'package:ice_cream/pages/cart_page.dart';
import 'package:ice_cream/pages/shop_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _pages = [
    const ShopPage(),
    const CartPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: Colors.black),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
      ),
      drawer: Drawer(
        child: Container(
          color: Colors.blue[700],
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  DrawerHeader(
                    decoration: BoxDecoration(
                      color: Colors.blue[700],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          'lib/images/logo-small.png',
                          height: 80,
                        ),
                      ],
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.home, color: Colors.white),
                    title: Text(
                      'Home',
                      style: GoogleFonts.zillaSlab(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        _selectedIndex = 0;
                        Navigator.pop(context); // Close the drawer
                      });
                    },
                  ),
                  ListTile(
                    leading:
                        const Icon(Icons.shopping_cart, color: Colors.white),
                    title: Text(
                      'Cart',
                      style: GoogleFonts.zillaSlab(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        _selectedIndex = 1;
                        Navigator.pop(context); // Close the drawer
                      });
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.info, color: Colors.white),
                    title: Text(
                      'Info',
                      style: GoogleFonts.zillaSlab(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onTap: () {},
                  ),
                ],
              ),
              ListTile(
                leading: const Padding(
                  padding: EdgeInsets.only(bottom: 15),
                  child: Icon(Icons.logout, color: Colors.white),
                ),
                title: Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: Text(
                    'Logout',
                    style: GoogleFonts.zillaSlab(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                onTap: () {
                  // Add your logout logic here
                },
              ),
            ],
          ),
        ),
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: MyBottomNavBar(
        onTabChange: navigateBottomBar,
      ),
    );
  }
}
