

class SignUpBody {
  late String name;
  late String email;
  late String password;
  late String birthOfDate;

  SignUpBody({required this.name, required this.email, required this.password, required this.birthOfDate});

  // SignUpBody.fromJson(Map<String, dynamic> json) {
  //   fName = json['first_name'];
  //   lName = json['last_name'];
  //   phone = json['phone'];
  //   password = json['password'];
  //   confirmPassword = json['confirm_password'];
  //   email = json['email'];
  //   address = json['address'];
  //   identificationType = json['identification_type'];
  //   identityNumber = json['identification_number'];
  //   deviceToken = json['fcm_token'];
  // }


  // Map<String, String> toJson() {
  //   final Map<String, String> data = <String, String>{};
  //   data['first_name'] = fName!;
  //   data['last_name'] = lName!;
  //   data['phone'] = phone!;
  //   data['password'] = password!;
  //   data['confirm_password'] = confirmPassword!;
  //   data['email'] = email!;
  //   data['address'] = address!;
  //   data['identification_type'] = identificationType!;
  //   data['identification_number'] = identityNumber!;
  //   data['fcm_token'] = deviceToken??'';
  //   data['service'] = jsonEncode(services);
  //   return data;
  // }
}
