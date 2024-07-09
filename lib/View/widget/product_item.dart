import 'package:flutter/material.dart';
import 'package:project/View/edit_product_screen.dart';
import 'package:project/model/product.dart';

class ProductItem extends StatelessWidget {
  final Product product;
  const ProductItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      width: MediaQuery.of(context).size.width,
      color: Colors.green,
      margin: const EdgeInsets.only(left: 14, right: 14, bottom: 14),
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(product.name ?? ''),
          Row(
            children: [
              IconButton(
                onPressed: () {Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => EditProductScreen(
                            currentProduct: product,
                          )),
                );},
                icon: const Icon(Icons.edit),
                color: Colors.white,
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.delete),
                color: Colors.red,
              ),
            ],
          )
        ],
      ),
    );
  }
}
