import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/ice.dart';

class IceTile extends StatelessWidget {
  final Ice ice;
  final void Function()? onTap;

  const IceTile({Key? key, required this.ice, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 25),
      width: 280,
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Ice pic
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Image.asset(
              ice.imagePath,
              width: 280,
              height: 250,
            ),
          ),

          // Description
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              ice.description,
              style: GoogleFonts.zillaSlab(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),
          ),

          // Price + Details
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //Ice name
                    Text(
                      ice.name,
                      style: GoogleFonts.zillaSlab(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),

                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      '\$${ice.price}',
                      style: GoogleFonts.zillaSlab(
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 195, 191, 191),
                      ),
                    ),
                  ],
                ),

                // Plus button
                GestureDetector(
                  onTap: onTap,
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        bottomRight: Radius.circular(12),
                      ),
                    ),
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
