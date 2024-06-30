import 'package:flutter/material.dart';
import 'package:project/View/widget/product_item.dart';
import 'package:project/controller/product_controller.dart';
import 'package:provider/provider.dart'; //stl

class ProductList extends StatelessWidget {
  const ProductList({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<ProductController>(context, listen: true);
    return Scaffold(
      body: ListView.builder(
        itemBuilder: (context, index) => ProductItem(
          product: controller.myProducts[index],
        ),
        itemCount: controller.myProducts.length,
      ),
    );
  }
}
