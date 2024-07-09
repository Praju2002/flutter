// import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'package:project/controller/product_controller.dart';
// import 'package:project/controler/product_controller.dart';
// import 'package:project/model/Product_model.dart';
import 'package:project/model/product.dart';
import 'package:provider/provider.dart';

class EditProductScreen extends StatefulWidget {
  final Product currentProduct;
  const EditProductScreen({super.key, required this.currentProduct});

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _formKey = GlobalKey<FormState>();
  var productNameController = TextEditingController();
  var productPriceController = TextEditingController();
  var productQuantityController = TextEditingController();
  var productImageUrlController = TextEditingController();

  @override
  void dispose() {
    productNameController.dispose();
    productPriceController.dispose();
    productQuantityController.dispose();
    productImageUrlController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    productNameController =
        TextEditingController(text: widget.currentProduct.name);
    productPriceController =
        TextEditingController(text: widget.currentProduct.price.toString());
    productQuantityController =
        TextEditingController(text: widget.currentProduct.quantity.toString());
    productImageUrlController =
        TextEditingController(text: widget.currentProduct.productImage);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<ProductController>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.navigate_before),
        ),
        title: const Text('Edit Product'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Product Name',
                ),
                controller: productNameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a product name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Price (Rs.)',
                ),
                keyboardType: TextInputType.number,
                controller: productPriceController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the product price';
                  }
                  try {
                    double.parse(value);
                  } catch (e) {
                    return 'Please enter a valid price';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Quantity',
                ),
                keyboardType: TextInputType.number,
                controller: productQuantityController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the product quantity';
                  }
                  try {
                    int.parse(value);
                  } catch (e) {
                    return 'Please enter a valid quantity';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      onChanged: (val) {
                        // if (val.contains('http')) {
                        setState(() {});
                        // }
                      },
                      decoration: const InputDecoration(
                        labelText: 'Image URL',
                      ),
                      controller: productImageUrlController,
                    ),
                  ),
                  if (productImageUrlController.text.isNotEmpty) ...[
                    const SizedBox(
                      width: 26,
                    ),
                    Image.network(
                      productImageUrlController.text,
                      height: 100,
                      width: 100,
                    )
                  ]
                ],
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    controller.editProduct(
                      widget.currentProduct.id,
                        productNameController.text,
                        double.parse(productPriceController.text),
                        int.parse(productQuantityController.text),
                        productImageUrlController.text);

                    Navigator.pop(context); // Navigate back to main screen
                  }
                },
                child: const Text('Edit Product'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
