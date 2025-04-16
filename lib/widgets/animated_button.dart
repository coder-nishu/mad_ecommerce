import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:slide_to_act/slide_to_act.dart';

class HAnimatedButton extends StatelessWidget {
  const HAnimatedButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final GlobalKey<SlideActionState> key = GlobalKey();
        return Padding(
          padding: const EdgeInsets.all(6.0),
          child: SlideAction(
            text: 'Pay Now',
            textStyle: GoogleFonts.quicksand(
              fontSize: 22,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
            textColor: Colors.black,
            innerColor: Colors.white,
            outerColor: Colors.deepOrange,
            sliderButtonIcon: const Icon(
              Icons.arrow_forward,
              color: Colors.black,
            ),
            key: key,
            onSubmit: () {
              Future.delayed(
                const Duration(seconds: 1),
                () => key.currentState!.reset(),
              );
              return null;
            },
          ),
        );
      },
    );
  }
}
