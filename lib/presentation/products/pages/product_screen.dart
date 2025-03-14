import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:techzeramt/core/constants/app_colors.dart';
import 'package:techzeramt/data/models/product_model.dart';
import 'package:techzeramt/presentation/login/bloc/login_bloc.dart';
import 'package:techzeramt/presentation/login/pages/login_screen.dart';
import 'package:techzeramt/presentation/products/bloc/product_bloc.dart';
import 'package:techzeramt/presentation/products/pages/product_add.dart';

class ProductScreen extends StatelessWidget {
  ProductScreen({super.key});
  final List<Color> _containerColors = [
    Color.fromRGBO(37, 113, 128, 1.0),
    Color.fromRGBO(242, 229, 191, 1.0),
    Color.fromRGBO(253, 139, 81, 1.0),
    Color.fromRGBO(190, 168, 162, 1),
  ];

  @override
  Widget build(BuildContext context) {
    context.read<ProductBloc>().add(LoadProductsEvent());
    return Scaffold(
      backgroundColor: kBlack,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        foregroundColor: kWhite,
        backgroundColor: kBlack,
        title: const Text(
          'Discover',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
              onPressed: () async {
                _showLogoutDialog(context);
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is ProductLoading) {
            return const CircularProgressIndicator();
          } else if (state is ProductLoaded) {
            final products = state.products;
            if (products.isEmpty) {
              return const Center(
                  child: Text("No products available",
                      style: TextStyle(color: kWhite)));
            }

            return ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                final Product product = products[index];
                final containerColor =
                    _containerColors[index % _containerColors.length];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      _showProductOptions(context, product, index);
                    },
                    child: Card(
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
                                    : Center(child: Icon(Icons.image))),
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
                                      Icon(Icons.currency_rupee),
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
                    ),
                  ),
                );
              },
            );
          } else {
            return Text('www');
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return AddProductScreen();
            }));
          },
          child: Icon(Icons.add)),
    );
  }

  void _showProductOptions(BuildContext context, Product product, int index) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.edit, color: Colors.blue),
                title: const Text('Edit Product'),
                onTap: () {
                  Navigator.pop(context);
                  _showEditDialog(context, product, index);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showEditDialog(BuildContext context, Product product, int index) {
    final TextEditingController priceController = TextEditingController(
      text: product.salesPrice.toString(),
    );
    final TextEditingController quantityController =
        TextEditingController(text: product.quantity.toString());

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: kBlack.withOpacity(0.8),
          title: Center(
              child: const Text(
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
                    labelText: "Sales Price",
                    labelStyle: TextStyle(color: kWhite)),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: quantityController,
                keyboardType: TextInputType.number,
                style: const TextStyle(color: kWhite),
                decoration: const InputDecoration(
                    labelText: "Quantity",
                    labelStyle: TextStyle(color: kWhite)),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                "Cancel",
                style: TextStyle(color: Colors.red),
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
      },
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Logout"),
          content: const Text("Are you sure you want to log out?"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                // Trigger logout event
                context.read<LoginBloc>().add(LogoutButtonPressed());
                Navigator.of(context).pop();
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              },
              child: const Text("Logout"),
            ),
          ],
        );
      },
    );
  }
}
