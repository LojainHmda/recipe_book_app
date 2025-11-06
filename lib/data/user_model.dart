class UserModel {
   String name;
   String email;
  final String uid; 
   String userProfile;
   List<String> fav;

  UserModel({
    required this.name,
    required this.email,
    required this.uid, 
    this.userProfile="",
    this.fav = const [],
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'uid': uid,   
      'userProfile': userProfile,
      'fav': fav,
    };
  }

factory UserModel.fromJson(Map<String, dynamic> json) {
  return UserModel(
    uid: json['uid'] ?? '',
    name: json['name'] ?? '',
    email: json['email'] ?? '',
    userProfile: json['userProfile'] ?? '',
    fav: List<String>.from(json['fav'] ?? []),
  );
}

}
