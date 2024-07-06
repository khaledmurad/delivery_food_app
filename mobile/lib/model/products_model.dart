class Product {
  int? totalSize;
  int? typeId;
  int? offset;
  late List<ProductModel> products;

  Product({this.totalSize, this.typeId, this.offset, required this.products});

  Product.fromJson(Map<String, dynamic> json) {
    totalSize = json['total_size'];
    typeId = json['type_id'];
    offset = json['offset'];
    if (json['products'] != null) {
      products = <ProductModel>[];
      json['products'].forEach((v) {
        products.add(new ProductModel.fromJson(v));
      });
    }
  }


}

class ProductModel {
  int? id;
  String? name;
  String? description;
  int? price;
  int? stars;
  String? img;
  String? location;
  String? createdAt;
  String? updatedAt;
  int? typeId;

  ProductModel(
      {this.id,
        this.name,
        this.description,
        this.price,
        this.stars,
        this.img,
        this.location,
        this.createdAt,
        this.updatedAt,
        this.typeId});

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    stars = json['stars'];
    img = json['img'];
    location = json['location'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    typeId = json['type_id'];
  }

  Map<String, dynamic> toJson(){
    return{
      'id' : this.id,
      'name' : this.name,
      'description' : this.description,
      'price' : this.price,
      'stars' : this.stars,
      'img' : this.img,
      'location' : this.location,
      'created_at' : this.createdAt,
      'updated_at' : this.updatedAt,
      'type_id' : this.typeId,
    };
  }

}