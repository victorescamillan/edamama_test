import 'package:edamama_test/models/product.dart';
import 'package:edamama_test/routes/router_constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductsView extends StatefulWidget {
  @override
  _ProductsViewState createState() => _ProductsViewState();
}

class _ProductsViewState extends State<ProductsView> {

  final searchFieldController = TextEditingController();
  bool _showClearButton = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<ProductModel>(context, listen: false).getProducts();
    searchFieldController.addListener(() {
      setState(() {
        _showClearButton = searchFieldController.text.length > 0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Products', style: TextStyle(color: Colors.white),),
        actions: [
          IconButton(
            onPressed: () => Navigator.pushNamed(context, CartRoute),
            icon: Icon(Icons.shopping_cart),
          )
        ],
      ),
      body: Column(
        children: [
          _productList()
        ],
      )
    );
  }

  _productList() {
    return Expanded(
        child: Consumer<ProductModel>(
            builder: (context, data, child) {
              if(data.isLoading){
                return Center(child: CircularProgressIndicator(strokeWidth: 2,));
              }
              return Column(
                children: [
                  _searchBar(),
                  Expanded(
                    child: GridView.count(
                        crossAxisCount: 2,
                        children: List.generate(data.products.length, (index) {
                          return _productItems(data.products[index]);
                        }),
                    ),
                  ),
                ],
              );
            })
    );
  }

  _searchBar() {
    return Container(
      color: Colors.blue,
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextField(
            controller: searchFieldController,
            onChanged: (value) {
              _onSearch(value);
            },
            decoration: _searchBarDecoration(),

          ),
        ],
      ),
    );
  }

  Widget _clearButton() {
    if (!_showClearButton) {
      return null;
    }
    return IconButton(
      onPressed: () {
        searchFieldController.clear();
        Provider.of<ProductModel>(context, listen: false).searchProduct('');
      },
      icon: Icon(Icons.clear),
    );
  }

  void _onSearch(String value) {
    Provider.of<ProductModel>(context, listen: false).searchProduct(value);
  }

  _searchBarDecoration() {
    return InputDecoration(
        filled: true,
        fillColor: Colors.grey[200],
        contentPadding: EdgeInsets.all(5.0),
        prefixIcon: Icon(Icons.search, color: Colors.grey,),
        suffixIcon: _clearButton(),
        hintText: 'Search Product',
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: BorderSide(color: Colors.grey)
        ),
        border: OutlineInputBorder(
            borderRadius:
            BorderRadius.all(Radius.circular(20.0)),
            borderSide: BorderSide(color: Colors.grey)));
  }

  _productItems(Product product) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 0, 0, 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _productDetails(product)
        ],
      ),
    );
  }

  Widget _productDetails(Product product){
    return Expanded(
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, ProductDetailsRoute, arguments: product);
        },
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5)
          ),
          padding: EdgeInsets.all(10.0),
          margin: EdgeInsets.all(3),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: Center(child: Image(image: NetworkImage(product.image),))),
              SizedBox(height: 10,),
              Text('₱ ${product.price}', style: TextStyle(fontSize: 15, color: Colors.grey[600]),),
              SizedBox(height: 10,),
              Text(product.title, style: TextStyle(fontSize: 12, color: Colors.grey[600]),)
            ],
          ),
        ),
      ),
    );
  }
}
