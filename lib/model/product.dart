class Product {
  String id;
  String? productImage;
  String? name;
  double? price;
  int? quantity;
  bool isFavorite;
  bool isAddToCart;

  Product(
      {this.isAddToCart=false,
      this.isFavorite=false,
      this.name,
      this.price,
      this.productImage,
      this.quantity,
      required this.id});
}
