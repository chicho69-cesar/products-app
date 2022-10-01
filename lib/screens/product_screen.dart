import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:products_app/ui/input_decorations.dart';
import 'package:products_app/services/services.dart';
import 'package:products_app/widgets/widgets.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({Key? key}) : super(key: key);

  static String routeName = 'product';

  @override
  Widget build(BuildContext context) {
    final productService = Provider.of<ProductsService>(context);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  ProductImage(
                    url: productService.selectedProduct.picture,
                  ),
      
                  Positioned(
                    top: 60,
                    left: 20,
                    child: IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      }, 
                      icon: const Icon(Icons.arrow_back_ios_new, size: 40, color: Colors.white),
                    ),
                  ),

                  Positioned(
                    top: 60,
                    right: 20,
                    child: IconButton(
                      onPressed: () {
                        // todo: camera or gallery
                      }, 
                      icon: const Icon(Icons.camera_alt_outlined, size: 40, color: Colors.white),
                    ),
                  ),
                ],
              ),

              const _ProductForm(),
              
              const SizedBox(height: 100)
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // todo: Store the product
        },
        child: const Icon(Icons.save_outlined),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }
}

class _ProductForm extends StatelessWidget {
  const _ProductForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        decoration: _buildBoxDecoration(),
        child: Form(
          child: Column(
            children: [
              const SizedBox(height: 10),

              TextFormField(
                decoration: InputDecorations.authInputDecoration(
                  hintText: 'Nombre del producto', 
                  labelText: 'Nombre: '
                ),
              ),

              const SizedBox(height: 30),

              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecorations.authInputDecoration(
                  hintText: '\$150', 
                  labelText: 'Precio: '
                ),
              ),

              const SizedBox(height: 30),

              SwitchListTile.adaptive(
                value: true, 
                title: const Text('Disponible'),
                activeColor: Colors.indigo,
                onChanged: (value) {
                  // todo: Pending
                }
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() => BoxDecoration(
    color: Colors.white,
    borderRadius: const BorderRadius.only(
      bottomLeft: Radius.circular(25),
      bottomRight: Radius.circular(25)
    ),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.5),
        blurRadius: 5,
        offset: const Offset(0, 5)
      ),
    ],
  );
}
