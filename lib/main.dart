import 'package:edamama_test/models/product.dart';
import 'package:edamama_test/routes/router_constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'routes/router.dart' as router;

void main() {
  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider( create: (context) => ProductModel()),
        ],
        child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Edamama Test',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      onGenerateRoute: router.generateRoute,
      initialRoute: ProductsRoute,
    );
  }
}
