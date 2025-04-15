
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:shimmer/shimmer.dart';

class HCarousel extends StatefulWidget {
  const HCarousel({super.key});

  @override
  State<HCarousel> createState() => _HCarouselState();
}

class _HCarouselState extends State<HCarousel> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    // List of asset images
    final imageUrls = [
      'assets/carousal1.jpg',
      'assets/carousal2.jpg',
      'assets/carousal3.jpg',
      'assets/carousal4.jpg',
      'assets/carousal5.jpg',
    ];

    return Column(
      children: [
        CarouselSlider.builder(
          itemCount: imageUrls.length,
          options: CarouselOptions(
            height: 180,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 4),
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            enlargeCenterPage: true,
            viewportFraction: 0.75,
            autoPlayCurve: Curves.fastOutSlowIn,
            onPageChanged: (index, reason) {
              setState(() => _currentIndex = index);
            },
          ),
          itemBuilder: (context, index, realIndex) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: FutureBuilder(
                future: precacheImage(AssetImage(imageUrls[index]), context),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        width: double.infinity,
                        height: 180,
                        color: Colors.white,
                      ),
                    );
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    return Image.asset(
                      imageUrls[index],
                      fit: BoxFit.cover,
                      height: 180,
                      width: double.infinity,
                    );
                  } else {
                    return const Icon(Icons.error, size: 50, color: Colors.red);
                  }
                },
              ),
            );
          },
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(imageUrls.length, (index) {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: _currentIndex == index ? 20 : 9,
              height: 9,
              decoration: BoxDecoration(
                color: _currentIndex == index ? Colors.deepOrange : Colors.grey[400],
                borderRadius: BorderRadius.circular(4),
              ),
            );
          }),
        ),
      ],
    );
  }
}