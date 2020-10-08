import 'dart:collection';

import 'package:edamama_test/services/product_service.dart';
import 'package:flutter/material.dart';

class ProductModel extends ChangeNotifier {
  List<Product> _products = [];
  List<Product> _productsTemp = [];
  List<Product> _cart = [];
  bool _isLoading = false;
  bool _checkCart = false;

  UnmodifiableListView<Product> get products => UnmodifiableListView(_productsTemp);
  UnmodifiableListView<Product> get cart => UnmodifiableListView(_cart);

  bool get isLoading => _isLoading;
  bool get checkCart => _checkCart;

  void getProducts() async {
    _isLoading = true;
    var list = await ProductService().getProducts();

    if(list != null){
      _products = list;
      _productsTemp = list;
    }

    _isLoading = false;
    notifyListeners();
  }

  void addItemCount(int index) async {
    _cart[index].count = _cart[index].count + 1;
    notifyListeners();
  }

  void deductItemCount(int index) async {
    if(_cart[index].count > 0){
      _cart[index].count = _cart[index].count - 1;
      notifyListeners();
    }
  }

  void addToCart(Product product) async {
    _checkCart = true;
    product.count = 1;
    _cart.add(product);
    notifyListeners();
  }

  void searchProduct(String value) {
    var items = _products.where((element) => element.title.toLowerCase().contains(value.toLowerCase())).toList();
    if(items != null){
      _productsTemp = items;
    }
    notifyListeners();
  }

  bool foundInCart(Product product) {
    if(_cart.length <= 0){
      return false;
    }

    var item = _cart.where((element) => element.id == product.id);
    if(item != null && item.length > 0){
      return true;
    }

    return false;
  }
}

class Product {
  int id;
  String title;
  dynamic price;
  String description;
  String category;
  String image;
  int count;

  Product(
      {this.id,
        this.title,
        this.price,
        this.description,
        this.category,
        this.image,
        this.count});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    price = json['price'];
    description = json['description'];
    category = json['category'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['price'] = this.price;
    data['description'] = this.description;
    data['category'] = this.category;
    data['image'] = this.image;
    return data;
  }
}
