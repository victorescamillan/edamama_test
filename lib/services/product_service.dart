import 'package:edamama_test/models/product.dart';
import 'package:edamama_test/services/network.dart';

class ProductService {
  Network _network = Network();

  Future<List<Product>> getProducts() async{
    final response = await _network.getRequest('products');

    if(response != null){
      List<dynamic> eventsRes = response;

      return eventsRes.map((dynamic item) => Product.fromJson(item)).toList();
    }
    return null;
  }
}