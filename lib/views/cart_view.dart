import 'package:edamama_test/models/product.dart';
import 'package:edamama_test/routes/router_constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartView extends StatefulWidget {
  @override
  _CartViewState createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart Items', style: TextStyle(color: Colors.white),),
      ),
      body: Column(
        children: [
          _cartList()
        ],
      )
    );
  }

  _cartList() {
    return Expanded(
        child: Consumer<ProductModel>(
            builder: (context, data, child) {
              if(data.isLoading){
                return Center(child: CircularProgressIndicator(strokeWidth: 2,));
              }

              if(data.cart.length <= 0){
                return Center(child: Text('No items available.'));
              }
              return ListView.builder(
                itemCount: data.cart.length,
                  itemBuilder: (context, index){
                    return _cartItems(data.cart[index], index);
              });
            })
    );
  }

  _cartItems(Product product, int index) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 0, 0, 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _productDetails(product, index)
        ],
      ),
    );
  }

  Widget _productDetails(Product product, int index){
    var price = product.price * product.count;
    return Expanded(
      child: Card(
        margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5)
          ),
          padding: EdgeInsets.all(10.0),
          margin: EdgeInsets.all(3),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: Image(image: NetworkImage(product.image), height: 100, width: 100,)),
              SizedBox(width: 5,),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text('₱ $price', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.grey[600]),),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text('Quantity', style: TextStyle(fontSize: 13, color: Colors.grey[600]),),
                              SizedBox(width: 5,),
                              Text('${product.count}', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.grey[800]))
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 10,),
                    Text(product.title, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey[600]),),
                    SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        _deductButton(index),
                        SizedBox(width: 5,),
                        _addButton(index),
                      ],
                    )
                    // Text(product.description, style: TextStyle(fontSize: 10, color: Colors.grey[600]),)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _deductButton(int index) {
    return SizedBox(
      height: 20,
      width: 40,
      child: FlatButton(
        color: Colors.redAccent,
        onPressed: () => Provider.of<ProductModel>(context, listen: false).deductItemCount(index),
        child: Text('-', style: TextStyle(color: Colors.white),),
      ),
    );
  }

  _addButton(int index) {
    return SizedBox(
      height: 20,
      width: 40,
      child: FlatButton(
        color: Colors.green,
        onPressed: () => Provider.of<ProductModel>(context, listen: false).addItemCount(index),
        child: Text('+', style: TextStyle(color: Colors.white),),
      ),
    );
  }
}
