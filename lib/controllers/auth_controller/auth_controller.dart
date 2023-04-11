import 'package:ecommerce_app/data/repository/auth_repo/auth_repo.dart';
import 'package:ecommerce_app/models/response_model/response_model.dart';
import 'package:ecommerce_app/models/sign_up_model/sign_up_model.dart';
import 'package:get/get.dart';

class AuthController extends GetxController implements GetxService {
  final AuthRepo authRepo;

  AuthController({required this.authRepo});

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Future<ResponseModel> registration(SignUpBody signUpBody) async {
    _isLoading = true;
    update();

    Response response = await authRepo.registration(signUpBody);

    late ResponseModel responseModel;
    if (response.statusCode == 200) {
      authRepo.saveUserToken(response.body["token"]);
      responseModel = ResponseModel(true, response.body["token"]);
    } else {
      responseModel = ResponseModel(false, response.statusText!);
    }

    _isLoading = false;
    update();
    return responseModel;
  }



  Future<ResponseModel> login(String email, String password) async {
    _isLoading = true;
    update();

    Response response = await authRepo.login(email, password);

    late ResponseModel responseModel;
    if (response.statusCode == 200) {
      authRepo.saveUserToken(response.body["token"]);
      responseModel = ResponseModel(true, response.body["token"]);
    } else {
      responseModel = ResponseModel(false, response.statusText!);
    }

    _isLoading = false;
    update();
    return responseModel;
  }

  void saveEmailAndPassword(String email, String password){
    authRepo.saveEmailAndPassword(email, password);
  }
}
