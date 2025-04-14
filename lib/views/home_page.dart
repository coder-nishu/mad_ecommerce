import 'package:flutter/cupertino.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    final bestSellers = productProvider.bestSellers;

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
                title: 'Flash Sales',
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.allProducts);
                },
              ),
              bestSellers.isEmpty
                  ? const Center(
                child: CircularProgressIndicator(color: Colors.deepOrange),
              )
                  : GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: const EdgeInsets.only(bottom: 16),
                itemCount: bestSellers.length,
                gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 24,
                  mainAxisSpacing: 16,
                  mainAxisExtent: 260,
                ),
                itemBuilder: (BuildContext context, int index) {
                  final product = bestSellers[index];
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
