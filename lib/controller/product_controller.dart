import 'package:flutter/material.dart';
import 'package:project/model/product.dart';

class ProductController extends ChangeNotifier {
  List<Product> myProducts = [
    Product(
      name: 'Product 1',
      price: 100,
      quantity: 1,
      productImage: 'https://picsum.photos/id/1/200/300',
      isFavorite: false,
      isAddToCart: false,
    ),
    Product(
      name: 'Product 2',
      price: 200,
      quantity: 3,
      productImage:
          'https://fastly.picsum.photos/id/10/2500/1667.jpg?hmac=J04WWC_ebchx3WwzbM-Z4_KC_LeLBWr5LZMaAkWkF68',
      isFavorite: false,
      isAddToCart: false,
    ),
    Product(
      name: 'Product 3',
      price: 300,
      quantity: 2,
      productImage:
          'https://fastly.picsum.photos/id/5/5000/3334.jpg?hmac=R_jZuyT1jbcfBlpKFxAb0Q3lof9oJ0kREaxsYV3MgCc',
      isFavorite: false,
      isAddToCart: false,
    ),
    Product(
      name: 'Product 4',
      price: 400,
      quantity: 4,
      productImage:
          'https://fastly.picsum.photos/id/6/5000/3333.jpg?hmac=pq9FRpg2xkAQ7J9JTrBtyFcp9-qvlu8ycAi7bUHlL7I',
      isFavorite: false,
      isAddToCart: false,
    ),
  ];
  void toggleFavorite(int index) {
    myProducts[index].isFavorite = !myProducts[index].isFavorite;
    notifyListeners();
  }

  void toggleAddToCart(int index) {
    myProducts[index].isAddToCart = !myProducts[index].isAddToCart;
  }

  
}
