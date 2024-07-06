class UserModel {
  int? id;
  String? name;
  String? phone;
  String? email;
  int? orderCount;

  UserModel({this.id, this.name, this.phone, this.email, this.orderCount});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['f_name'];
    phone = json['phone'];
    email = json['email'];
    orderCount = json['order_count'];
  }

  Map<String, dynamic> toJson() {
    return{
      'id' : this.id,
      'f_name' : this.name,
      'phone' : this.phone,
      'email' : this.email,
      'order_count' : this.orderCount
    };
  }
}