import 'package:edamama_test/models/product.dart';
import 'package:edamama_test/routes/router_constants.dart';
import 'package:edamama_test/views/cart_view.dart';
import 'package:edamama_test/views/product_details_view.dart';
import 'package:edamama_test/views/products_view.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings settings){
  switch(settings.name){
    case CartRoute:
      return MaterialPageRoute(builder: (context) => CartView());
    case ProductsRoute:
      return MaterialPageRoute(builder: (context) => ProductsView());
    case ProductDetailsRoute:
      Product productArgument = settings.arguments;
      return MaterialPageRoute(builder: (context) => ProductDetailsView(product: productArgument,));
    default:
      return MaterialPageRoute(builder: (context) => ProductsView());
  }
}