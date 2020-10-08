import 'package:edamama_test/models/product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDetailsView extends StatefulWidget {
  final Product product;

  ProductDetailsView({Key key, this.product}): super(key:key);

  @override
  _ProductDetailsViewState createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<ProductDetailsView> {

  @override
  Widget build(BuildContext context) {
    Product product = widget.product;
    return Scaffold(
      appBar: AppBar(
        title: Text('', style: TextStyle(color: Colors.white),),
      ),
      body: SafeArea(
        child: Consumer<ProductModel>(
          builder: (context, data, child){
            bool foundInCart = Provider.of<ProductModel>(context, listen: false).foundInCart(product);
            return Column(
              children: [
                _productDetails(product),
                if(!foundInCart)
                  _addToCart()
              ],
            );
          },
        ),
      ),
    );
  }

  _addToCart() {
    double deviceWidth = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: deviceWidth,
        child: FlatButton(
          onPressed: () {
            Provider.of<ProductModel>(context,listen: false).addToCart(widget.product);
          },
          color: Colors.blue,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0)
          ),
          child: Text('ADD TO CART', style: TextStyle(color: Colors.white),),
        ),
      ),
    );
  }

  _productDetails(Product product) {
    double imageHeight = MediaQuery.of(context).size.height / 2;
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(child: Image(image: NetworkImage(product.image), height: imageHeight,)),
                    SizedBox(height: 10,),
                    Text('₱ ${product.price}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey[800]),),
                  ],
                ),
              ),
            ),
           
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product.title, style: TextStyle(fontSize: 15, color: Colors.grey[800]),),
                  SizedBox(height: 10,),
                  Text('${product.description}', style: TextStyle(fontSize: 13, color: Colors.grey[600])),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
