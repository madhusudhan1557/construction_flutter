class UserModel {
  String? uid;

  String? fullname;
  String? email;
  String? password;
  String? phone;
  String? address;
  String? role;

  UserModel({
    this.uid,
    this.fullname,
    this.email,
    this.password,
    this.phone,
    this.address,
    this.role,
  });

  factory UserModel.fromDocument(Map<String, dynamic> doc) {
    return UserModel(
      uid: doc['uid'] ?? "",
      fullname: doc['fullname'] ?? "",
      email: doc['email'] ?? "",
      password: doc['password'] ?? "",
      address: doc['address'] ?? "",
      phone: doc['phone'] ?? "",
      role: doc['role'] ?? "",
    );
  }
}
