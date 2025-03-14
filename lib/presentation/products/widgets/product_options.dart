import 'package:flutter/material.dart';
import 'package:techzeramt/core/constants/app_colors.dart';
import 'package:techzeramt/data/models/product_model.dart';
import 'package:techzeramt/presentation/products/widgets/editproduct_dialog.dart';

void showProductOptions(BuildContext context, Product product, int index) {
  showModalBottomSheet(
    context: context,
    backgroundColor: kGrey.withOpacity(0.4),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
    ),
    builder: (context) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.edit, color: kDeepOrange),
              title: const Text(
                'Edit Product',
                style: TextStyle(color: kWhite),
              ),
              onTap: () {
                Navigator.pop(context);
                showDialog(
                  context: context,
                  builder: (context) {
                    return EditProductDialog(product: product, index: index);
                  },
                );
              },
            ),
          ],
        ),
      );
    },
  );
}
