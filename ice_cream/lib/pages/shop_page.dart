import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ice_cream/_components/ice_tile.dart';
import 'package:ice_cream/models/ice.dart';
import 'package:provider/provider.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';
import 'package:carousel_slider/carousel_slider.dart';


import '../models/cart.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => ShopPageState();
}

class ShopPageState extends State<ShopPage> {
  final TextEditingController _searchController = TextEditingController();
  IceType? _selectedIceType;
  int _center = 0; // Initialize center index for carousel

  // Filtering logic for ice cream name
  List<Ice> filterIceList(String query, List<Ice> iceList) {
    return iceList
        .where((ice) => ice.name.toLowerCase().contains(query.toLowerCase()))
        .where((ice) => _selectedIceType == null || ice.type == _selectedIceType)
        .toList();
  }

  // Add ice to cart
  void addIceToCart(Ice ice) {
    Provider.of<Cart>(context, listen: false).addItemToCart(ice);

    // Show a SnackBar with a success message at the top
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Padding(
          padding: const EdgeInsets.all(1),
          child: Text(
            'Ice cream successfully added to your cart!',
            textAlign: TextAlign.center,
            style: GoogleFonts.syne(
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        duration: const Duration(seconds: 1),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        backgroundColor: Colors.green,
      ),
    );
  }

  // Search logic
  void performSearch() {
    setState(() {
      // Reset _center index to 0 when performing a search/filtering
      _center = 0;
    });
  }

  // Handle tap on Ice Type
  void _handleIceTypeTap(IceType iceType) {
    setState(() {
      if (_selectedIceType == iceType) {
        _selectedIceType = null;
      } else {
        _selectedIceType = iceType;
      }
      // Reset _center index to 0 regardless of filtering or unfiltering
      _center = 0; 
    });
  }

  Widget _buildIceTypeAvatar(String imagePath, IceType iceType) {
    final bool isSelected = _selectedIceType == iceType;

    return GestureDetector(
      onTap: () => _handleIceTypeTap(iceType),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        transform: isSelected ? Matrix4.identity() : Matrix4.identity()..scale(0.9),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 3,
              offset: const Offset(0, 2),
            ),
          ],
          border: !isSelected ? Border.all(color: Colors.white, width: 0.2) : null,
        ),
        child: GlassContainer(
          borderRadius: BorderRadius.circular(50),
          blur: 30,
          shadowStrength: 3,
          child: CircleAvatar(
            radius: isSelected ? 45 : 35,
            backgroundColor: isSelected ? const Color.fromARGB(255, 38, 39, 39) : Colors.transparent,
            backgroundImage: AssetImage(imagePath),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Cart>(
      builder: (context, value, child) {
        List<Ice> filteredIceList =
            filterIceList(_searchController.text, value.getIceList());

        return Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Padding for the status bar
                SizedBox(
                  height: MediaQuery.of(context).padding.top,
                ),

                //Search bar
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 2),
                  margin: const EdgeInsets.symmetric(horizontal: 25),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 3,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Form(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _searchController,
                            decoration: const InputDecoration(
                              hintText: 'Search',
                              border: InputBorder.none,
                            ),
                            onFieldSubmitted: (value) {
                              performSearch();
                            },
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.search, color: Colors.grey),
                          onPressed: performSearch,
                        ),
                      ],
                    ),
                  ),
                ),

                 // Image and Text
                Padding(
                  padding: const EdgeInsets.only(top: 30, left: 30, right: 30),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color.fromARGB(255, 38, 39, 39),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 3,
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 25, right: 25),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.asset(
                                    'lib/images/text.png',
                                    height: 70,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 2),
                            child: Transform.rotate(
                              angle: -0.15,
                              child: Image.asset(
                                'lib/images/ice_cream_car.png',
                                height: 110,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                // Ice Picks
                Padding(
                  padding: const EdgeInsets.only(left: 30, top: 20),
                  child: Text('Ice Picks 🍦',
                      style: GoogleFonts.syne(
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 38, 39, 39),
                        fontSize: 16,
                      )),
                ),

                // Ice Selection
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  child: GlassContainer(
                    borderRadius: BorderRadius.circular(15),
                    blur: 30,
                    shadowStrength: 9,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10, left: 35),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildIceTypeAvatar(
                            'lib/images/cone.png',
                            IceType.cone,
                          ),
                          _buildIceTypeAvatar(
                            'lib/images/pot.png',
                            IceType.pot,
                          ),
                          _buildIceTypeAvatar(
                            'lib/images/stick.png',
                            IceType.stick,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // Goodies and See All
                Padding(
                  padding: const EdgeInsets.only(left: 30, top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Goodies',
                        style: GoogleFonts.syne(
                          fontWeight: FontWeight.bold,
                          color: const Color.fromARGB(255, 38, 39, 39),
                          fontSize: 16,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: Text(
                          'See all',
                          style: GoogleFonts.syne(
                            fontWeight: FontWeight.bold,
                            color: Colors.pink[400],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Ice carousel
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        height: 250,
                        width: MediaQuery.of(context).size.width,
                        child: filteredIceList.isEmpty
                            ? const Center(
                                child: Text(
                                  'No items found',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey,
                                  ),
                                ),
                              )
                            : CarouselSlider.builder(
                                itemCount: filteredIceList.length,
                                itemBuilder: (context, index, realIndex) {
                                  Ice ice = filteredIceList[index];
                                  double scaleFactor = (1 - ((index - _center).abs() * 0.1)).clamp(0.95, 1.05);
                                  return Transform.scale(
                                    scale: scaleFactor,
                                    child: IceTile(
                                      ice: ice,
                                      onTap: () => addIceToCart(ice),
                                      isCurrentItem: index == _center,
                                    ),
                                  );
                                },
                                options: CarouselOptions(
                                  aspectRatio: 1.9,
                                  enlargeCenterPage: true,
                                  enableInfiniteScroll: _selectedIceType == null && _searchController.text.isEmpty,
                                  initialPage: _selectedIceType == null ? 0 : _center,
                                  autoPlay: false,
                                  viewportFraction: 0.45,
                                  onPageChanged: (index, _) {
                                    setState(() {
                                      _center = index;
                                    });
                                  },
                                ),
                              ),
                      ),
                    ],
                  ),
                ),

              ],
            ),
          ),
        );
      },
    );
  }
}
