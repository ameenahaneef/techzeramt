import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:techzeramt/core/constants/app_colors.dart';
import 'package:techzeramt/core/constants/app_styles.dart';
import 'package:techzeramt/data/models/product_model.dart';
import 'package:techzeramt/presentation/products/bloc/product_bloc.dart'; // Your ProductBloc

class AddProductScreen extends StatelessWidget {
  const AddProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController itemNameController = TextEditingController();
    TextEditingController salesPriceController = TextEditingController();
    TextEditingController quantityController = TextEditingController();

    // ValueNotifier for the selected image
    ValueNotifier<XFile?> selectedImageNotifier = ValueNotifier<XFile?>(null);

    // Function to pick image from gallery
    Future<void> pickImage() async {
      final ImagePicker picker = ImagePicker();
      final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        selectedImageNotifier.value = pickedFile;
      }
    }

    // Function to clear the form after saving the product
    void clearForm() {
      itemNameController.clear();
      salesPriceController.clear();
      quantityController.clear();
      selectedImageNotifier.value = null;
    }

    return Scaffold(
      backgroundColor: kBlack,
      appBar: AppBar(
        foregroundColor: kWhite,
        backgroundColor: kBlack,
        title: const Text('Add Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: pickImage,
              child: Container(
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.grey[200],
                ),
                child: ValueListenableBuilder<XFile?>(
                  valueListenable: selectedImageNotifier,
                  builder: (context, selectedImage, child) {
                    return selectedImage == null
                        ? const Center(child: Icon(Icons.add))
                        : Image.file(
                            File(selectedImage.path),
                            fit: BoxFit.cover,
                          );
                  },
                ),
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              style: style1,
              controller: itemNameController,
              decoration:  InputDecoration(
                labelText: 'Item Name',
                labelStyle: TextStyle(color: kWhite),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30)
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: kWhite)),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: kWhite)),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
                            style: style1,

              controller: salesPriceController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Sales Price',
                labelStyle: TextStyle(color: kWhite),
                border: OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: kWhite)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: kWhite)),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
                            style: style1,

              controller: quantityController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Quantity',
                labelStyle: TextStyle(color: kWhite),
                border: OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: kWhite)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: kWhite)),
              ),
            ),
            const SizedBox(height: 15),
            ElevatedButton(
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
                  print(
                      "Saving product: ${product.itemName}, Price: ${product.salesPrice}, Quantity: ${product.quantity}, Image: ${product.imagePath}");
                  // Use BLoC to add the product
                  context.read<ProductBloc>().add(AddProductEvent(product));

                  // Clear the form after saving the product
                  clearForm();
                  Navigator.pop(context);
                }
              },
              child: const Text('Add Product'),
            ),
          ],
        ),
      ),
    );
  }
}
