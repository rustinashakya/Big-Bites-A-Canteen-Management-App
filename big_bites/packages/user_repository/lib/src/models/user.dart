import '../entities/entities.dart';

class MyUser{
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

  MyUser({
    required this.userId, 
    required this.email, 
    required this.fname, 
    required this.lname, 
    required this.userType, 
    required this.profilePic, 
    required this.hasActiveCart,
  });

  static final empty = MyUser(
    userId: '',
    email: '',
    fname: '',
    lname: '',
    userType: '',
    profilePic: '',
    hasActiveCart: false,
  );

  MyUserEntity toEntity(){
    return MyUserEntity(
      userId: userId, 
      email: email, 
      fname: fname, 
      lname: lname, 
      userType: userType, 
      profilePic: profilePic, 
      hasActiveCart: hasActiveCart,
    );
  }

  static MyUser fromEntity(MyUserEntity entity){
    return MyUser(
      userId: entity.userId, 
      email: entity.email, 
      fname: entity.fname, 
      lname: entity.lname, 
      userType: entity.userType, 
      profilePic: entity.profilePic, 
      hasActiveCart: entity.hasActiveCart
    );
  }

  @override
  String toString(){
    return 'MyUser: $userId, $email, $fname, $lname, $userType, $profilePic, $hasActiveCart';
  }
}