part of 'product_bloc.dart';

@immutable
sealed class ProductEvent {}

class AddProductEvent extends ProductEvent {
  final Product product;
  AddProductEvent(this.product);
}

class LoadProductsEvent extends ProductEvent {}

class UpdateProductEvent extends ProductEvent {
  final int index;
  final double newSalesPrice;
  final int newQuantity;

  UpdateProductEvent({
    required this.index,
    required this.newSalesPrice,
    required this.newQuantity,
  });
}
