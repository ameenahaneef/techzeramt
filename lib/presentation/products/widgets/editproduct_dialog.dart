import 'package:flutter/material.dart';
import 'package:techzeramt/data/models/product_model.dart';
import 'package:techzeramt/presentation/products/bloc/product_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:techzeramt/core/constants/app_colors.dart';

class EditProductDialog extends StatelessWidget {
  final Product product;
  final int index;

  const EditProductDialog(
      {super.key, required this.product, required this.index});

  @override
  Widget build(BuildContext context) {
    final TextEditingController priceController = TextEditingController(
      text: product.salesPrice.toString(),
    );
    final TextEditingController quantityController =
        TextEditingController(text: product.quantity.toString());

    return AlertDialog(
      backgroundColor: kBlack.withOpacity(0.8),
      title: const Center(
          child: Text(
        "Edit Product",
        style: TextStyle(color: kWhite),
      )),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: priceController,
            keyboardType: TextInputType.number,
            style: const TextStyle(color: kWhite),
            decoration: const InputDecoration(
                labelText: "Sales Price", labelStyle: TextStyle(color: kWhite)),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: quantityController,
            keyboardType: TextInputType.number,
            style: const TextStyle(color: kWhite),
            decoration: const InputDecoration(
                labelText: "Quantity", labelStyle: TextStyle(color: kWhite)),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text(
            "Cancel",
            style: TextStyle(color: kRed),
          ),
        ),
        TextButton(
          onPressed: () {
            final double? newPrice = double.tryParse(priceController.text);
            final int? newQuantity = int.tryParse(quantityController.text);

            if (newPrice != null && newQuantity != null) {
              context.read<ProductBloc>().add(UpdateProductEvent(
                  index: index,
                  newSalesPrice: newPrice,
                  newQuantity: newQuantity));
              Navigator.pop(context);
            }
          },
          child: const Text(
            "Update",
            style: TextStyle(color: kGreen),
          ),
        ),
      ],
    );
  }
}
