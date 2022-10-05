import 'package:flutter/material.dart';
import 'package:products_app/models/models.dart';

import 'package:provider/provider.dart';

import 'package:products_app/screens/screens.dart';
import 'package:products_app/services/services.dart';
import 'package:products_app/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static String routeName = 'home';

  @override
  Widget build(BuildContext context) {
    final productsService = Provider.of<ProductsService>(context);
    final authService = Provider.of<AuthService>(context, listen: false);

    if (productsService.isLoading) {
      return const LoadingScreen();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Productos'),
        leading: IconButton(
          onPressed: ()  {
            authService.logout();
            Navigator.pushReplacementNamed(context, LoginScreen.routeName);
          },
          icon: const Icon(Icons.logout_outlined),
        ),
      ),
      body: ListView.builder(
        itemCount: productsService.products.length,
        itemBuilder: (BuildContext context, int index) => GestureDetector(
          onTap: () {
            productsService.selectedProduct = productsService.products[index].copy();
            Navigator.of(context).pushNamed(ProductScreen.routeName);
          },
          child: ProductCard(
            product: productsService.products[index],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          productsService.selectedProduct = Product(
            avaliable: false, 
            name: '', 
            price: 0
          );

          Navigator.pushNamed(context, ProductScreen.routeName);
        },
      ),
    );
  }
}
