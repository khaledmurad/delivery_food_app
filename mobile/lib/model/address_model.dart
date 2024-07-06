class AddressModel {
  int? id;
  String? addressType;
  String? contactPhoneNo;
  String? contactPersonName;
  String? address;
  String? latitude;
  String? longitude;

  AddressModel({this.id, this.addressType, this.contactPhoneNo, this.contactPersonName,
    this.address, this.latitude, this.longitude});

  AddressModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    addressType = json['addressType'];
    contactPhoneNo = json['contactPhoneNo'];
    contactPersonName = json['contactPersonName'];
    address = json['address'];
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    return{
      'id' : this.id,
      'addressType' : this.addressType,
      'contactPhoneNo' : this.contactPhoneNo,
      'contactPersonName' : this.contactPersonName,
      'address' : this.address,
      'latitude' : this.latitude,
      'longitude' : this.longitude
    };
  }
}