class UserModel {
  String? message;
  bool? status;
  User? user;

  UserModel({this.message, this.status, this.user});

  UserModel.fromJson(Map<dynamic, dynamic> json) {
    message = json['message'];
    status = json['status'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['status'] = status;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class User {
  String? id;
  String? custId;
  String? agentId;
  String? countryCode;
  String? email;
  String? mobile;

  User(
      {this.id,
      this.custId,
      this.agentId,
      this.countryCode,
      this.email,
      this.mobile});

  User.fromJson(Map<dynamic, dynamic> json) {
    id = json['id'];
    custId = json['cust_id'];
    agentId = json['agent_id'];
    countryCode = json['country_code'];
    email = json['email'];
    mobile = json['mobile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['cust_id'] = custId;
    data['agent_id'] = agentId;
    data['country_code'] = countryCode;
    data['email'] = email;
    data['mobile'] = mobile;
    return data;
  }
}
