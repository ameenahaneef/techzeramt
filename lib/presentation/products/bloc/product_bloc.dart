import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:techzeramt/data/models/product_model.dart';
import 'package:techzeramt/data/repositories/product_repository.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository productRepository = ProductRepository();

  ProductBloc() : super(ProductInitial()) {
    on<AddProductEvent>((event, emit) async {
      await productRepository.addProduct(event.product);
      List<Product> products = productRepository.getAllProducts();
      emit(ProductLoaded(products));
    });

    on<LoadProductsEvent>((event, emit) {
      List<Product> products = productRepository.getAllProducts();
      emit(ProductLoaded(products));
    });

    on<UpdateProductEvent>((event, emit) async {
      await productRepository.updateProduct(
          event.index, event.newSalesPrice, event.newQuantity);
      List<Product> products = productRepository.getAllProducts();
      emit(ProductLoaded(products));
    });
  }
}
