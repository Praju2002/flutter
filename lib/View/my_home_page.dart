import 'package:flutter/material.dart';
import 'package:project/View/add_product_from.dart';
import 'package:project/controller/product_controller.dart';
import 'package:project/model/product.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton.icon(
            icon: const Icon(Icons.add),
            label: const Text('Add Product'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AddProductForm()),
              );
            },
          ),
        ],
        title: const Text(
          "Hamro Online Shop",
          style: TextStyle(
              color: Color.fromARGB(255, 146, 206, 148),
              fontSize: 13.0,
              fontWeight: FontWeight.bold),
        ),
        leading: const Icon(
          Icons.safety_check,
          color: Colors.red,
        ),
      ),
      body: Consumer<ProductController>(
        builder: (context, controller, child) => SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 200,
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: const Color.fromARGB(255, 211, 125, 154),
                ),
                child: Row(
                  children: [
                    Image.network(
                      "https://fastly.picsum.photos/id/5/5000/3334.jpg?hmac=R_jZuyT1jbcfBlpKFxAb0Q3lof9oJ0kREaxsYV3MgCc",
                      height: 200,
                      width: 200,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(width: 14),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Praju",
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'pokhara',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w400),
                          ),
                          Text(
                            '9809090909090',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.myProducts.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemBuilder: (context, index) {
                  return Center(
                    child: card(controller.myProducts[index], controller, index),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget card(Product product, ProductController controller, int index) {
    return Container(
      height: 200,
      width: 200,
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 255, 255, 255),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              product.productImage ?? '',
              height: 140,
              width: 200,
              fit: BoxFit.fitWidth,
            ),
          ),
          const SizedBox(height: 8),
          Column(
            children: [
              SizedBox(
                width: 200,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(product.name ?? ''),
                    Text('Rs ${product.price.toString()}'),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: 200,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Quantity: ${product.quantity.toString()}',
                      style: const TextStyle(fontSize: 12),
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            controller.toggleFavorite(index);
                          },
                          child: Icon(
                            product.isFavorite
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: Colors.red,
                          ),
                        ),
                        const SizedBox(width: 6),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              controller.toggleAddToCart(index);
                            });
                          },
                          child: Icon(
                            product.isAddToCart
                                ? Icons.shopping_cart
                                : Icons.shopping_cart_outlined,
                            color: Colors.indigo,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
