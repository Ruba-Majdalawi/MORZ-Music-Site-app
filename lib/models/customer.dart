// customer.dart

class Customer {
  final int id;
  final String username;
  final String password;
  final String firstName;
  final String lastName;
  final String address;
  final String email;
  final bool isAdmin;

  Customer({
    required this.id,
    required this.username,
    required this.password,
    required this.firstName,
    required this.lastName,
    required this.address,
    required this.email,
    required this.isAdmin,
  });

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      id: json['id'],
      username: json['username'],
      password: json['password'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      address: json['address'],
      email: json['email'],
      isAdmin: json['isAdmin'] == 1,
    );
  }
}
