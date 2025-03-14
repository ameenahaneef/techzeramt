import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:techzeramt/core/constants/app_colors.dart';
import 'package:techzeramt/data/models/product_model.dart';
import 'package:techzeramt/presentation/products/bloc/product_bloc.dart';
import 'package:techzeramt/presentation/products/pages/product_add.dart';
import 'package:techzeramt/presentation/products/widgets/card_widget.dart';
import 'package:techzeramt/presentation/products/widgets/logout_dialog.dart';
import 'package:techzeramt/presentation/products/widgets/product_options.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

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
                showDialog(
                  context: context,
                  builder: (context) {
                    return const LogoutDialog();
                  },
                );
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
                    containerColors[index % containerColors.length];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      showProductOptions(context, product, index);
                    },
                    child: CardWidget(
                        containerColor: containerColor, product: product),
                  ),
                );
              },
            );
          } else {
            return const Text('Error');
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return const AddProductScreen();
            }));
          },
          child: const Icon(Icons.add)),
    );
  }
}
