import 'package:ecommerce_app/models/user_model/user_model.dart';
import 'package:get/get.dart';

import '../../data/repository/account_repo/account_repo.dart';
import '../../models/response_model/response_model.dart';

class AccountController extends GetxController implements GetxService {
  final AccountRepo authRepo;

  AccountController({required this.authRepo});

  late UserModel _userModel;

  UserModel get userModel => _userModel;
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Future<ResponseModel> getUserInfo() async {



    Response response = await authRepo.getUserInfo();

    late ResponseModel responseModel;
    if (response.statusCode == 200) {
      this._userModel = UserModel.fromJson(response.body);
      responseModel = ResponseModel(true, "successfully");
      _isLoading = true;
    } else {
      responseModel = ResponseModel(false, "failed");
    }
    update();
    return responseModel;
  }
}