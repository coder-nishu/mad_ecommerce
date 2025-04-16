import 'package:device_preview/device_preview.dart';
import 'package:ecommerce/providers/bottom_nav_provider.dart';
import 'package:ecommerce/providers/cart_provider.dart';
import 'package:ecommerce/providers/category_product_provider.dart';
import 'package:ecommerce/providers/login_provider.dart';
import 'package:ecommerce/providers/product_detail_provider.dart';
import 'package:ecommerce/providers/signup_provider.dart';
import 'package:ecommerce/routers/route_generator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'app.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: 'EzzyShop',
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BottomNavProvider()),
        ChangeNotifierProvider(create: (_) => ProductDetailProvider()),
        ChangeNotifierProvider(create: (_) => SignUpProvider()),
        ChangeNotifierProvider(create: (_) => LoginProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
      ],

      // child: DevicePreview(
      //   enabled: true,
      //   storage: DevicePreviewStorage.none(),
      //   defaultDevice: Devices.ios.iPhone12ProMax,
      //   builder: (context) {
      //     return const MyApp();
      //   },
      // ),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ecommerce EzzyBuy',
      home: const EzzyShopSpp(),
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
