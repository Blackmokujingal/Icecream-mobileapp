import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/ice.dart';

class IceTile extends StatefulWidget {
  final Ice ice;
  final bool isCurrentItem; // Indicates if this tile is the currently selected item
  final void Function()? onTap;

  const IceTile({Key? key, required this.ice, required this.isCurrentItem, this.onTap}) : super(key: key);

  @override
  _IceTileState createState() => _IceTileState();
}

class _IceTileState extends State<IceTile> {
  bool _showDescription = false;

  @override
  void didUpdateWidget(covariant IceTile oldWidget) {
    if (widget.isCurrentItem != oldWidget.isCurrentItem) {
      setState(() {
        _showDescription = false; // Reset the description state when the current item changes
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200, // Set a fixed width
      child: GestureDetector(
        onTap: widget.isCurrentItem ? () {
          setState(() {
            _showDescription = !_showDescription;
          });
        } : null,
        child: Stack( 
          children: [
            Container(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 38, 39, 39),
                borderRadius: BorderRadius.circular(40),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: _buildContent(),
            ),
            if (!_showDescription && widget.isCurrentItem)
              Positioned(
                bottom: 0,
                right: 0,
                child: GestureDetector(
                  onTap: widget.onTap,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                      color: Color.fromRGBO(240, 98, 146, 1),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        bottomRight: Radius.circular(40), 
                      ),
                    ),
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent() {
    return AnimatedCrossFade(
      duration: Duration(milliseconds: 300),
      crossFadeState: _showDescription ? CrossFadeState.showSecond : CrossFadeState.showFirst,
      firstChild: _buildImageNamePrice(),
      secondChild: _buildDescription(),
    );
  }

  Widget _buildDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 200,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: Text(
                widget.ice.description,
                style: GoogleFonts.syne(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildImageNamePrice() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Ice pic
        Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Container(
            width: double.infinity,
            height: 115,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                widget.ice.imagePath,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),

        // Name
        Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 2, left: 15),
          child: Text(
            widget.ice.name,
            style: GoogleFonts.syne(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: const Color.fromARGB(255, 195, 191, 191),
            ),
          ),
        ),

        // Price
        Padding(
          padding: const EdgeInsets.only(left: 15),
          child: Text(
            '\$${widget.ice.price}',
            style: GoogleFonts.syne(
              fontWeight: FontWeight.bold,
              color: const Color.fromARGB(255, 195, 191, 191),
            ),
          ),
        ),
      ],
    );
  }
}
