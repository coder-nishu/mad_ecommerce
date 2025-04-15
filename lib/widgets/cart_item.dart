import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CartItem extends StatelessWidget {
  const CartItem({super.key, this.isCountVisible = true});

  final bool isCountVisible;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.15,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,

        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.15,
            width: MediaQuery.of(context).size.width * 0.3,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              border: Border.all(color: Colors.grey[300]!),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                bottomLeft: Radius.circular(16),
              ),
            ),
            child: Center(
              child: Image.asset("assets/watch.jpg", fit: BoxFit.contain),
            ),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              itemNameCategory(context),

              Row(
                children: [
                  SizedBox(
                    width: 50,
                    child: Text(
                      "৳ 5000",
                      style: GoogleFonts.quicksand(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepOrange,
                      ),
                    ),
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.1),
                  if (isCountVisible)
                    SizedBox(
                      width: 85,
                      child: Row(
                        children: [
                          Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(Icons.remove, size: 16),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            "1",
                            style: GoogleFonts.quicksand(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                              color: Colors.deepOrange[100],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(Icons.add, size: 16),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Column itemNameCategory(BuildContext context) {
    return Column(
      spacing: 8,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.5,
          child: Text(
            "Rolex Watch silver black dial",
            style: GoogleFonts.quicksand(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Text(
          "Watch",
          style: GoogleFonts.quicksand(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.grey[600],
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}

// Center(
//           child: Text(
//             'Your Cart is Empty',
//             style: GoogleFonts.quicksand(fontSize: 20, color: Colors.grey[700]),
//           ),
//         ),

//
