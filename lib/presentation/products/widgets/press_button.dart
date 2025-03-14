import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:techzeramt/core/constants/app_colors.dart';
import 'package:techzeramt/data/models/product_model.dart';
import 'package:techzeramt/presentation/products/bloc/product_bloc.dart';

class PressButton extends StatelessWidget {
  const PressButton({
    super.key,
    required this.itemNameController,
    required this.salesPriceController,
    required this.quantityController,
    required this.selectedImageNotifier,
  });

  final TextEditingController itemNameController;
  final TextEditingController salesPriceController;
  final TextEditingController quantityController;
  final ValueNotifier<XFile?> selectedImageNotifier;

  void clearForm() {
    itemNameController.clear();
    salesPriceController.clear();
    quantityController.clear();
    selectedImageNotifier.value = null;
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if (itemNameController.text.isNotEmpty &&
            salesPriceController.text.isNotEmpty &&
            quantityController.text.isNotEmpty &&
            selectedImageNotifier.value != null) {
          final product = Product(
            imagePath: selectedImageNotifier.value!.path,
            itemName: itemNameController.text,
            salesPrice: double.parse(salesPriceController.text),
            quantity: int.parse(quantityController.text),
          );
          context.read<ProductBloc>().add(AddProductEvent(product));
          clearForm();
          Navigator.pop(context);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Please fill all fields'),
              backgroundColor: kRed,
            ),
          );
        }
      },
      style: ElevatedButton.styleFrom(backgroundColor: kWhite.withOpacity(0.7)),
      child: const Text(
        'Add Product',
        style: TextStyle(color: kBlack),
      ),
    );
  }
}
