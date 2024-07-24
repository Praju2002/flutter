import 'package:flutter/material.dart';
import 'package:project/controller/product_controller.dart';
import 'package:provider/provider.dart';

class AddProductForm extends StatefulWidget {
  const AddProductForm({super.key});

  @override
  State<AddProductForm> createState() => _AddProductFormState();
}

class _AddProductFormState extends State<AddProductForm> {
  final _formKey = GlobalKey<FormState>();
  final productNameController = TextEditingController();
  final productPriceController = TextEditingController();
  final productQuantityController = TextEditingController();
  final productImageUrlController = TextEditingController();

  @override
  void dispose() {
    productNameController.dispose();
    productPriceController.dispose();
    productQuantityController.dispose();
    productImageUrlController.dispose();
    super.dispose();
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
        title: const Text('Add Product'),
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
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    // Handle form submission
                    // You'll need to interact with ProductController here
                    // to add the new product (e.g., call addProduct method)
                    await controller.addProduct(
                        productNameController.text,
                        double.parse(productPriceController.text),
                        int.parse(productQuantityController.text),
                        productImageUrlController.text);
                    // Navigator.pop(context); // Navigate back to main screen
                  }
                },
                child: const Text('Add Product'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}