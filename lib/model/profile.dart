class Profile {
  Content? content;

  Profile({this.content});

  Profile.fromJson(Map<String, dynamic> json) {
    content =
    json['content'] != null ? new Content.fromJson(json['content']) : null;
  }
}

class Content {
  Customer? customer;

  Content({this.customer});

  Content.fromJson(Map<String, dynamic> json) {
    customer = json['customer'] != null
        ? new Customer.fromJson(json['customer'])
        : null;
  }
}

class Customer {
  int? uId;
  String? uName;
  String? uEmail;
  String? uGender;
  String? uRole;

  Customer({this.uId, this.uName, this.uEmail, this.uGender, this.uRole});

  Customer.fromJson(Map<String, dynamic> json) {
    uId = json['u_id'];
    uName = json['u_name'];
    uEmail = json['u_email'];
    uGender = json['u_gender'];
    uRole = json['u_role'];
  }
}
