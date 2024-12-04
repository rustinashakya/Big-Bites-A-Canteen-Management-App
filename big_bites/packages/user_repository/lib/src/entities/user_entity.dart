class MyUserEntity{
  String userId; 
  String email; 
  String fname; 
  String lname; 
  String userType;
  // can't add password to firebase 
  // String password; 
  // String cpassword; 
  String profilePic;  

  //dunno 
  bool hasActiveCart; 

  MyUserEntity({
    required this.userId, 
    required this.email, 
    required this.fname, 
    required this.lname, 
    required this.userType, 
    required this.profilePic, 
    required this.hasActiveCart,
  });

  Map<String, Object?> toDocument(){
    return {
      'userId': userId, 
      'email': email, 
      'fname': fname, 
      'lname': lname,
      'userType': userType, 
      'profilePic': profilePic, 
      'hasActiveCart': hasActiveCart 
    };
  }

  static MyUserEntity fromDocument(Map<String, dynamic> doc){
    return MyUserEntity(userId: doc['userId'], email: doc['email'], fname: doc['fname'], lname: doc['lname'], userType: doc['userType'], profilePic: doc['profilePic'], hasActiveCart: doc['hasActiveCart']);
  }
}