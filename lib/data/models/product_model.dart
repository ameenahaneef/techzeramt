import 'package:hive/hive.dart';

part 'product_model.g.dart'; 

@HiveType(typeId: 1)
class Product {
  @HiveField(0)
  final String imagePath;

  @HiveField(1)
  final String itemName;

  @HiveField(2)
  final double salesPrice;

  @HiveField(3)
  final int quantity;

  Product({
    required this.imagePath,
    required this.itemName,
    required this.salesPrice,
    required this.quantity,
  });

  Product copyWith({
    int? id,
    String? itemName,
    double? salesPrice,
    int? quantity,
    String? imagePath,
  }) {
    return Product(
      itemName: itemName ?? this.itemName,
      salesPrice: salesPrice ?? this.salesPrice,
      quantity: quantity ?? this.quantity,
      imagePath: imagePath ?? this.imagePath,
    );
  }
}
