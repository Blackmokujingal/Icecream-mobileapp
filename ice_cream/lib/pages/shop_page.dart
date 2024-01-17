import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ice_cream/_components/ice_tile.dart';
import 'package:ice_cream/models/ice.dart';
import 'package:provider/provider.dart';

import '../models/cart.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => ShopPageState();
}

class ShopPageState extends State<ShopPage> {
  final TextEditingController _searchController = TextEditingController();

  // Filtering logic for ice cream name
  List<Ice> filterIceList(String query, List<Ice> iceList) {
    return iceList
        .where((ice) => ice.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  // Add ice to cart
  void addIceToCart(Ice ice) {
    Provider.of<Cart>(context, listen: false).addItemToCart(ice);

    // Show a SnackBar with a success message at the top
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Padding(
          padding: const EdgeInsets.all(3),
          child: Text(
            'Ice cream successfully added to your cart!',
            textAlign: TextAlign.center,
            style: GoogleFonts.zillaSlab(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        backgroundColor: Colors.green,
      ),
    );
  }

  // Search logic
  void performSearch() {
    setState(() {
      // Trigger the search logic here
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Cart>(
      builder: (context, value, child) {
        List<Ice> filteredIceList =
            filterIceList(_searchController.text, value.getIceList());

        return Scaffold(
          body: Column(
            children: [
              // Padding for the status bar
              SizedBox(
                height: MediaQuery.of(context).padding.top,
              ),

              // Search bar
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 2),
                margin: const EdgeInsets.symmetric(horizontal: 25),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: const Color.fromARGB(255, 241, 237, 237),
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

              // Hot picks
              Padding(
                padding: const EdgeInsets.only(top: 30, left: 35),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('Hot Picks 🍦',
                        style: GoogleFonts.zillaSlab(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        )),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text('See all',
                          style: GoogleFonts.zillaSlab(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          )),
                    )
                  ],
                ),
              ),

              const SizedBox(height: 10),
              // List of ice cream for sale
              Expanded(
                child: ListView.builder(
                  itemCount: filteredIceList.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    // Get an ice cream from the filtered list
                    Ice ice = filteredIceList[index];

                    // Return the ice cream
                    return IceTile(
                      ice: ice,
                      onTap: () => addIceToCart(ice),
                    );
                  },
                ),
              ),

              const Padding(
                padding: EdgeInsets.only(top: 25, left: 25, right: 25),
                child: Divider(
                  color: Colors.white,
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
