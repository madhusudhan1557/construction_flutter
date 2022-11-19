class UserModel {
  String? uid;
  String? firstname;
  String? lastname;
  String? email;
  String? password;
  String? phone;
  String? address;
  String? role;

  UserModel({
    this.uid,
    this.firstname,
    this.lastname,
    this.email,
    this.password,
    this.phone,
    this.address,
    this.role,
  });

  factory UserModel.fromDocument(Map<String, dynamic> doc) {
    return UserModel(
      uid: doc['uid'] ?? "",
      firstname: doc['firstname'] ?? "",
      lastname: doc['lastname'] ?? "",
      email: doc['email'] ?? "",
      password: doc['password'] ?? "",
      address: doc['address'] ?? "",
      phone: doc['phone'] ?? "",
      role: doc['role'] ?? "",
    );
  }
}
