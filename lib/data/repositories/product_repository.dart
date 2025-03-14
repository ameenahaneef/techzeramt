import 'package:hive/hive.dart';
import 'package:techzeramt/data/models/product_model.dart';

class ProductRepository {
  final Box<Product> productBox = Hive.box<Product>('products');

  // Add product to Hive
  Future<void> addProduct(Product product) async {
    await productBox.add(product);
  }

  // Get all products
  List<Product> getAllProducts() {
    return productBox.values.toList();
  }

   Future<void> updateProduct(int key, double newSalesPrice, int newQuantity) async {
    final product = productBox.get(key);
    if (product != null) {
      final updatedProduct = product.copyWith(
        salesPrice: newSalesPrice,
        quantity: newQuantity,
      );
      await productBox.put(key, updatedProduct);
    }
  }
}
