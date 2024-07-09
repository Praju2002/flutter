import 'package:flutter/material.dart';
import 'package:project/View/add_product_from.dart';
import 'package:project/View/product_list.dart';
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
      floatingActionButton: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green
        ),
      onPressed: (){
        Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProductList()),
              );
      },
      child: const Text("show all products",style: TextStyle(color: Colors.white),)),
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
                    crossAxisCount: 2, childAspectRatio: 7 / 10),
                itemBuilder: (context, index) {
                  return Center(
                    child:
                        card(controller.myProducts[index], controller, index),
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
      margin: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        color: Colors.white,
        // borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: SizedBox(
                height: 140,
                width: 200,
                child: FadeInImage(
                  imageErrorBuilder: (context, e, _) =>
                      Image.asset("assets/logo.jpg"),
                  placeholder: const AssetImage("assets/logo.jpg"),
                  image: NetworkImage(
                    product.productImage ?? '',
                  ),
                ),
              )),
          const SizedBox(
            height: 8,
          ),
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
              const SizedBox(
                height: 8,
              ),
              SizedBox(
                width: 200,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Quantity: ${(product.quantity ?? 0).toString()}',
                      style: const TextStyle(fontSize: 12),
                    ),
                    Row(
                      children: [
                        GestureDetector(
                            onTap: () {
                              setState(() {
                                controller.toggleFavorite(index);
                              });
                            },
                            child: Icon(
                              product.isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: Colors.red,
                            )),
                        const SizedBox(
                          width: 6,
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              controller.toggleAddToCart(index);
                            });
                          },
                          child: Icon(
                            product.isAddToCart
                                ? Icons.shopping_cart
                                : Icons.add_shopping_cart,
                            color: Colors.indigo,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

