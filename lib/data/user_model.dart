class UserModel {
  final String name;
  final String email;
  final String uid; 
  final String? userProfile;

  UserModel({
    required this.name,
    required this.email,
    required this.uid, 
    this.userProfile,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'uid': uid,   
      'userProfile': userProfile,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'],
      email: json['email'],
      uid: json['uid'], 
      userProfile: json['userProfile'],
    );
  }
}
