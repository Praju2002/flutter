import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:project/model/product.dart';
import 'package:http/http.dart' as http;

class ProductController extends ChangeNotifier {
  final myServerUrl = "https://online-shop-e1128-default-rtdb.firebaseio.com/";
  List<Product> myProducts = [
    // Product(
    //   id: "1",
    //   name: 'Product 1',
    //   price: 100,
    //   quantity: 1,
    //   productImage: 'https://picsum.photos/id/1/200/300',
    //   isFavorite: false,
    //   isAddToCart: false,
    // ),
    // Product(
    //   id: "2",
    //   name: 'Product 2',
    //   price: 200,
    //   quantity: 3,
    //   productImage:
    //       'https://fastly.picsum.photos/id/10/2500/1667.jpg?hmac=J04WWC_ebchx3WwzbM-Z4_KC_LeLBWr5LZMaAkWkF68',
    //   isFavorite: false,
    //   isAddToCart: false,
    // ),
    // Product(
    //   id: "3",
    //   name: 'Product 3',
    //   price: 300,
    //   quantity: 2,
    //   productImage:
    //       'https://fastly.picsum.photos/id/5/5000/3334.jpg?hmac=R_jZuyT1jbcfBlpKFxAb0Q3lof9oJ0kREaxsYV3MgCc',
    //   isFavorite: false,
    //   isAddToCart: false,
    // ),
    // Product(
    //   id: "4",
    //   name: 'Product 4',
    //   price: 400,
    //   quantity: 4,
    //   productImage:
    //       'https://fastly.picsum.photos/id/6/5000/3333.jpg?hmac=pq9FRpg2xkAQ7J9JTrBtyFcp9-qvlu8ycAi7bUHlL7I',
    //   isFavorite: false,
    //   isAddToCart: false,
    // ),
    // Product(
    //   id: "5",
    //   name: 'Product 5',
    //   price: 400,
    //   quantity: 4,
    //   productImage:
    //       'https://fastly.picsum.photos/id/6/5000/3333.jpg?hmac=pq9FRpg2xkAQ7J9JTrBtyFcp9-qvlu8ycAi7bUHlL7I',
    //   isFavorite: false,
    //   isAddToCart: false,
    // ),
    // Product(
    //   id: "6",
    //   name: 'Product 6',
    //   price: 400,
    //   quantity: 4,
    //   productImage:
    //       'https://fastly.picsum.photos/id/6/5000/3333.jpg?hmac=pq9FRpg2xkAQ7J9JTrBtyFcp9-qvlu8ycAi7bUHlL7I',
    //   isFavorite: false,
    //   isAddToCart: false,
    // ),
  ];
  void toggleFavorite(int index) {
    myProducts[index].isFavorite = !myProducts[index].isFavorite;
    notifyListeners();
  }

  void toggleAddToCart(int index) {
    myProducts[index].isAddToCart = !myProducts[index].isAddToCart;
  }

  Future<void> addProduct(
      String name, double price, int quantity, String imageUrl) async {
    try {
      final prodId = DateTime.now().microsecondsSinceEpoch.toString();
      Product newProduct = Product(
          id: prodId,
          productImage: imageUrl,
          name: name,
          price: price,
          quantity: quantity);

      final uri = '${myServerUrl}products.json';
      final response = await http.post(Uri.parse(uri),
          body: json.encode({
            "id": prodId,
            "ProductImage": imageUrl,
            "ProductName": name,
            "Price": price.toString(),
            "Quantity": quantity.toString()
          }));
      if (response.statusCode >= 200) {
        myProducts.add(newProduct);
      } else {
        throw Exception('Failed to add product');
      }
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  Future<void> editProduct(String id, String name, double price, int quantity,String imageUrl) 
  async {
    final uri = '${myServerUrl}products/$id.json';
    final response = await http.put(Uri.parse(uri),
        body: json.encode({
          "id": id,
          "ProductImage": imageUrl,
          "ProductName": name,
          "Price": price.toString(),
          "Quantity": quantity.toString()
        }));
    if (response.statusCode >= 200) {
      var currentProduct = myProducts.firstWhere((element) => element.id == id);
      int selectedProductIndex = myProducts.indexOf(currentProduct);
      Product editedProduct = Product(
          id: id,
          name: name,
          price: price,
          productImage: imageUrl,
          quantity: quantity);

      myProducts[selectedProductIndex] = editedProduct;
      notifyListeners();
    }
  }

  Future<void> deleteProduct(String id) async {
    final uri = '${myServerUrl}products/$id.json';
    final response = await http.delete(Uri.parse(uri));
    if (response.statusCode >= 200) {
      myProducts.removeWhere((element) => element.id == id);

      notifyListeners();
    }
  }

  Future<void> getAllProducts() async {
    try {
      final uri = '${myServerUrl}products.json';
      final response = await http.get(Uri.parse(uri));
      if (response.statusCode >= 200) {
        Map<String, dynamic> extractedData = json.decode(response.body);

        extractedData.forEach((key, value) {
          final id = key;
          final name = value['ProductName'];
          final price = double.parse(value['Price']);
          final quantity = int.parse(value['Quantity']);
          final imageUrl = value['ProductImage'];
          final newProduct = Product(
            id: id,
            name: name,
            price: price,
            quantity: quantity,
            productImage: imageUrl,
          );
          myProducts.add(newProduct);
          notifyListeners();
        });
      }
    } catch (error) {
      throw error;
    }
  }
}
