class UserModel {
  String? userName;
  String? dogName;

  UserModel({this.userName, this.dogName});

  UserModel.fromJson(Map<String, dynamic> json) {
    userName = json['userName'];
    dogName = json['dogName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userName'] = userName;
    data['dogName'] = dogName;

    return data;
  }
}
