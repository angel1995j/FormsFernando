class FormModel {
  FormModel({
    this.id,
    this.name,
    this.age,
    this.email,
    this.phone,
    this.address,
    this.street,
    this.zip,
    this.signature,
  });

  final String? id;
  final String? name;
  final String? age;
  final String? email;
  final String? phone;
  final String? address;
  final String? street;
  final String? zip;
  final String? signature;

  FormModel copyWith({
    String? id,
    String? name,
    String? age,
    String? email,
    String? phone,
    String? address,
    String? street,
    String? zip,
    String? signature,
  }) =>
      FormModel(
        id: id ?? this.id,
        name: name ?? this.name,
        age: age ?? this.age,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        address: address ?? this.address,
        street: street ?? this.street,
        zip: zip ?? this.zip,
        signature: signature ?? this.signature,
      );

  factory FormModel.fromJson(Map<String, dynamic> json) => FormModel(
        id: json["id"],
        name: json["name"],
        age: json["age"],
        email: json["email"],
        phone: json["phone"],
        address: json["address"],
        street: json["street"],
        zip: json["zip"],
        signature: json["signature"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "age": age,
        "email": email,
        "phone": phone,
        "address": address,
        "street": street,
        "zip": zip,
        "signature": signature,
      };
}
