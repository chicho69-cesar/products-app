import 'package:flutter/material.dart';

import 'package:products_app/widgets/widgets.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({Key? key}) : super(key: key);

  static String routeName = 'product';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: const [
                ProductImage(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}