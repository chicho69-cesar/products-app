import 'package:flutter/material.dart';
import 'package:products_app/models/models.dart';

class ProductsService extends ChangeNotifier {
  final String _baseUrl = 'https://flutter-varios-35859-default-rtdb.firebaseio.com';
  final List<Product> products = [];

  // todo: Hacer fetch de productos
}
