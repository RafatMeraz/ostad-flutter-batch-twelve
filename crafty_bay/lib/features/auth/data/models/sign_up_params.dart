class SignUpParams {
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String city;
  final String password;

  SignUpParams({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.city,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      "first_name": firstName,
      "last_name": lastName,
      "email": email,
      "password": password,
      "phone": phone,
      "city": city
    };
  }
}
