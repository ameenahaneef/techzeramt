import 'dart:io';

import 'package:flutter/material.dart';
import 'package:techzeramt/core/constants/app_colors.dart';
import 'package:techzeramt/data/models/product_model.dart';

class CardWidget extends StatelessWidget {
  const CardWidget({
    super.key,
    required this.containerColor,
    required this.product,
  });

  final Color containerColor;
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: containerColor,
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Color.fromARGB(255, 208, 207, 208)),
                child: product.imagePath.isNotEmpty
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: Image.file(
                          File(product.imagePath),
                          fit: BoxFit.cover,
                        ))
                    : const Center(child: Icon(Icons.image))),
            const SizedBox(width: 30),
            // Product Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.itemName,
                    style: const TextStyle(
                      color: kBlack,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.currency_rupee),
                      Text(
                        '${product.salesPrice}',
                        style: const TextStyle(
                          fontSize: 18,
                          color: kBlack,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Qty: ${product.quantity}',
                    style: const TextStyle(
                      fontSize: 16,
                      color: kBlack,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
