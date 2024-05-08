class User {
  String username;
  String email;
  String password;
  List<int> groups = [];

  User({required this.username, required this.email, required this.password});


  User.fromJson(Map<String, dynamic> json) 
  :
    username = json['username'] as String,
    email = json['email'] as String,
    password = json['password'] as String,
    groups = (json['groups'] as List<dynamic>).map((item) => item as int).toList();
  
  Map<String, dynamic> toJson() => {
    'username': username,
    'email': email,
    'password': password,
    'groups': groups,
  };
  
  
  
}





