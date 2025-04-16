import 'package:flutter/material.dart';
import '../model/product_model.dart';

import '../routers/app_routers.dart';
import '../widgets/appbar.dart';
import '../widgets/carousel.dart';
import '../widgets/category.dart';
import '../widgets/heading.dart';
import '../widgets/prduct_card.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  List<Product> demoProducts = [
    Product(
      id: '2001',
      name: 'Yellow Headphone',
      description: 'A stylish and comfortable headphone for high-quality sound experience.',
      price: 50,
      category: 'audio accessories',
      imageUrl: [
        'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      ],
      rating: 4.7,
      isFavorite: true,
    ),
    Product(
      id: '2002',
      name: 'Silver Headphone',
      description: 'Premium quality headphones with noise-canceling features.',
      price: 80,
      category: 'audio accessories',
      imageUrl: [
        'https://plus.unsplash.com/premium_photo-1677838847804-4054143fb91a?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTN8fGhlYWRwaG9uZXN8ZW58MHx8MHx8fDA%3D',
      ],
      rating: 4.9,
      isFavorite: true,
    ),
    Product(
      id: '2003',
      name: 'Fossil Watch',
      description: 'An elegant watch that blends style and precision.',
      price: 120,
      category: 'watches',
      imageUrl: [
        'https://images.unsplash.com/photo-1622434641406-a158123450f9?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTl8fHdhdGNofGVufDB8fDB8fHww',
      ],
      rating: 4.6,
      isFavorite: false,
    ),
    Product(
      id: '2004',
      name: 'Blue Dial Watch',
      description: 'A sophisticated timepiece with a blue dial and silver accents.',
      price: 150,
      category: 'watches',
      imageUrl: [
        'https://images.unsplash.com/photo-1523170335258-f5ed11844a49?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Nnx8d2F0Y2h8ZW58MHx8MHx8fDA%3D',
      ],
      rating: 4.8,
      isFavorite: true,
    ),
    Product(
      id: '2005',
      name: 'Coffee Box Gift',
      description: 'A premium coffee gift box with selected blends and accessories.',
      price: 40,
      category: 'gifts',
      imageUrl: [
        'https://images.unsplash.com/photo-1664849271854-26ed0d81d813?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTJ8fGdpZnQlMjBpdGVtc3xlbnwwfHwwfHx8MA%3D%3D',
      ],
      rating: 4.9,
      isFavorite: true,
    ),
    Product(
      id: '2006',
      name: 'Apple Airpod',
      description: 'Wireless earbuds with high-quality sound and seamless connectivity.',
      price: 250,
      category: 'audio accessories',
      imageUrl: [
        'https://images.unsplash.com/photo-1606741965326-cb990ae01bb2?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NTd8fGVsZWN0cm9uaWNzfGVufDB8fDB8fHww',
      ],
      rating: 4.9,
      isFavorite: false,
    ),
  ];


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: HAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
        child: SingleChildScrollView(
          child: Column(
            spacing: 16,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HHeading(title: 'Flash Sales', isSeeAll: false,icon: Icons.flash_on,),

              HCarousel(),
              HHeading(title: 'Categories',icon: Icons.category, isSeeAll: false),
              const HCategory(),
              HHeading(
                title: 'Best Sales',
                icon: Icons.favorite,
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.allProducts);
                },
              ),
              GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: const EdgeInsets.only(bottom: 16),
                itemCount: demoProducts.length,
                gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 24,
                  mainAxisSpacing: 16,
                  mainAxisExtent: 260,
                ),
                itemBuilder: (BuildContext context, int index) {
                  final product = demoProducts[index];
                  return InkWell(
                    child: ProductCard(product: product),
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        AppRoutes.productDetail,
                        arguments: product,
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
