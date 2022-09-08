import 'package:flutter/material.dart';
import 'package:product_test/application/di/app_locator.dart';

import '../presentation/screens/products_screen.dart';

class Application extends StatefulWidget {
  const Application({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  @override
  void initState() {
    AppLocator.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ProductsScreen(),
    );
  }

  @override
  void dispose() {
    AppLocator.dispose();
    super.dispose();
  }
}
