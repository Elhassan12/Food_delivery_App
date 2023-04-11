class SignUpBody{
  String? email;
  String? password;
  String? name;
  String? phone;
  SignUpBody({
    required this.email, required this.password, required this.name, required this.phone

});
  Map<String,dynamic> toJson(){
    Map<String,dynamic> data = new Map<String,dynamic>();
    data["email"] = this.email;
    data["password"] = this.password;
    data["name"] = this.name;
    data["phone"] = this.phone;
    return data;
  }

}