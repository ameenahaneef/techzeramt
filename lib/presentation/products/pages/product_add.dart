import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:techzeramt/core/constants/app_colors.dart';
import 'package:techzeramt/presentation/products/widgets/item_fields.dart';
import 'package:techzeramt/presentation/products/widgets/press_button.dart'; // Your ProductBloc

class AddProductScreen extends StatelessWidget {
  const AddProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController itemNameController = TextEditingController();
    TextEditingController salesPriceController = TextEditingController();
    TextEditingController quantityController = TextEditingController();

    ValueNotifier<XFile?> selectedImageNotifier = ValueNotifier<XFile?>(null);

    Future<void> pickImage() async {
      final ImagePicker picker = ImagePicker();
      final XFile? pickedFile =
          await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        selectedImageNotifier.value = pickedFile;
      }
    }

    return Scaffold(
      backgroundColor: kBlack,
      appBar: AppBar(
        foregroundColor: kWhite,
        backgroundColor: kBlack,
        title: const Text('Add Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
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
            height16,
            ItemField(labelText: 'Item Name', controller: itemNameController),
            height16,
            ItemField(
                labelText: 'Sales Price', controller: salesPriceController),
            height16,
            ItemField(labelText: 'Quantity', controller: quantityController),
            const SizedBox(height: 15),
            PressButton(
                itemNameController: itemNameController,
                salesPriceController: salesPriceController,
                quantityController: quantityController,
                selectedImageNotifier: selectedImageNotifier),
          ],
        ),
      ),
    );
  }
}
