import 'package:flutter_complete_guide/models/product.dart';

final List<Product> _dummyData = [
  Product(
    id: 'p1',
    title: 'Red Shirt',
    description: 'A red shirt - it is pretty red!',
    price: 29.99,
    imageUrl:
        'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
  ),
  Product(
    id: 'p2',
    title: 'Trousers',
    description: 'A nice pair of trousers.',
    price: 59.99,
    imageUrl:
        'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
  ),
  Product(
    id: 'p3',
    title: 'Yellow Scarf',
    description: 'Warm and cozy - exactly what you need for the winter.',
    price: 19.99,
    imageUrl: 'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
  ),
  Product(
    id: 'p4',
    title: 'A Pan',
    description: 'Prepare any meal you want.',
    price: 49.99,
    imageUrl:
        'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
  ),
];

class ProductRepository {
  List<Product> get getAllProduct => [..._dummyData];

  List<Product> get getFavoriteProduct =>
      [..._dummyData.where((v) => v.isFavorite)];

  void setIsFavorite(String productId, bool isFavorite) {
    _dummyData.firstWhere((v) => v.id == productId).isFavorite = isFavorite;
  }

  List<Product> getProductByIds(List<String> ids) {
    return _dummyData.where((v) => ids.contains(v.id));
  }

  Product getProductById(String productId) {
    return _dummyData.firstWhere((v) => v.id == productId, orElse: () => null);
  }

  void addNewProduct(Product newProduct) {
    _dummyData.add(newProduct);
  }

  void updateProduct(Product product) {
    var idx = _dummyData.indexWhere((v) => v.id == product.id);
    if (idx != null) {
      _dummyData[idx] = product;
    }
  }

  void deleteProduct(String productId) {
    _dummyData.removeWhere((v) => v.id == productId);
  }
}
