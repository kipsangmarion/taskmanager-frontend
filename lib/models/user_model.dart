class user_model {
  String? username;
  String? password;
  String? password2;
  String? email;
  String? firstName;
  String? lastName;

  user_model(
      {this.username,
        this.password,
        this.password2,
        this.email,
        this.firstName,
        this.lastName});

  user_model.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    password = json['password'];
    password2 = json['password2'];
    email = json['email'];
    firstName = json['first_name'];
    lastName = json['last_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['password'] = this.password;
    data['password2'] = this.password2;
    data['email'] = this.email;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    return data;
  }
}


