class RegisterReqParams {
  String email;
  String password;
  String firstName;
  String lastName;

  RegisterReqParams({required this.email, required this.password, required this.firstName, required this.lastName});

  Map<String, dynamic> toJson() {
    return {"firstName": firstName, "lastName": lastName, "email": email, "password": password};
  }
}
