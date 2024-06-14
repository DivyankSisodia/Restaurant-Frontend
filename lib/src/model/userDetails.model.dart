class UserDetailsModel {
  final String id;
  final String userName;
  final String email;
  final List<dynamic> address;
  final String phone;
  final String profile;

  UserDetailsModel({
    required this.id,
    required this.userName,
    required this.email,
    required this.address,
    required this.phone,
    required this.profile,
  });

  factory UserDetailsModel.fromMap(Map<String, dynamic> json) {
    return UserDetailsModel(
      id: json['_id'],
      userName: json['userName'],
      email: json['email'],
      address: json['address'],
      phone: json['phone'],
      profile: json['profile'],
    );
  }
}
