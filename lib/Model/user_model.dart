class UserModel {
  String email;
  String userid;
  UserModel({
    required this.email,
    required this.userid,
  });
  factory UserModel.fromJson(Map<String, dynamic> json) =>
      UserModel(email: json['email'], userid: json['userid']);
  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data["email"] = email;
    data['userid'] = userid;
    return data;
  }
}
