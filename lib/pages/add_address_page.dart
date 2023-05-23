import 'package:ecommerce_app/constants/constants.dart';
import 'package:ecommerce_app/controllers/account_controller/account_controller.dart';
import 'package:ecommerce_app/controllers/auth_controller/auth_controller.dart';
import 'package:ecommerce_app/controllers/location_controller/location_controller.dart';
import 'package:ecommerce_app/utils/colors.dart';
import 'package:ecommerce_app/utils/dimensions.dart';
import 'package:ecommerce_app/widgets/app_text_field.dart';
import 'package:ecommerce_app/widgets/big_text.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:get/get.dart';

class AddAddressPage extends StatefulWidget {
  const AddAddressPage({Key? key}) : super(key: key);

  @override
  State<AddAddressPage> createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {
  TextEditingController addressController = TextEditingController();
  TextEditingController _contactPersonNameController = TextEditingController();
  TextEditingController _contactPersonNumberController =
      TextEditingController();
  CameraPosition _cameraPosition =
      CameraPosition(target: LatLng(48.798181, 12.082474), zoom: 17);
  late LatLng _initialPosition = LatLng(48.798181, 12.082474);
  late bool _isLogged;

  @override
  void initState() {
    _isLogged = Get.find<AuthController>().isUserLoggedIn();

    if (_isLogged && Get.find<AccountController>().userModel == null) {
      Get.find<AccountController>().getUserInfo();
    }

    if (Get.find<LocationController>().addressList.isNotEmpty) {
      _cameraPosition = CameraPosition(
          target: LatLng(Get.find<LocationController>().getAddress["latitude"],
              Get.find<LocationController>().getAddress["longitude"]));
    }
    // _initialPosition = LatLng(double.parse(Get
    //     .find<LocationController>()
    //     .getAddress["latitude"]), double.parse(Get
    //     .find<LocationController>()
    //     .getAddress["longitude"]));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Address page"),
        backgroundColor: AppColors.mainColor,
      ),
      body:GetBuilder<AccountController>(builder: (userController){
        // if(userController.userModel != null && _contactPersonNameController.text.isEmpty) {
        //   _contactPersonNameController.text = userController.userModel.name;
        //   _contactPersonNumberController.text = userController.userModel.phone;
        // }
          if(Get.find<LocationController>().addressList.isEmpty){
           // addressController.text = Get.find<LocationController>().getUserAddress().address;
          }


        return GetBuilder<LocationController>(builder: (locationController){
          addressController.text = '${locationController.placemark[0].name?? ''} '
              '${locationController.placemark[0].locality?? ''} '
              '${locationController.placemark[0].postalCode?? ''} '
              '${locationController.placemark[0].country?? ''}';
          print('address form my view is ${addressController.text}');
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 140,
                  width: Dimensions.screenWidth,
                  margin: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border:
                    Border.all(width: 2, color: AppColors.mainColor),
                  ),
                  child: Stack(
                    children: [
                      GoogleMap(
                        initialCameraPosition:
                        CameraPosition(target: _initialPosition, zoom: 13),
                        mapType: MapType.normal,
                        compassEnabled: false,
                        zoomControlsEnabled: false,
                        mapToolbarEnabled: false,
                        indoorViewEnabled: true,
                        onCameraIdle: ((){
                          locationController.updatePosition(_cameraPosition,true);
                          print("camera is idle");
                        }),
                        onCameraMove: (position){
                          _cameraPosition = position;
                        },
                        onMapCreated: (GoogleMapController _controller){
                          locationController.setMapController(_controller);

                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: Dimensions.height20,),
                Padding(
                  padding: EdgeInsets.only(left: Dimensions.width20),
                  child: BigText(text: "Delivery Address"),
                ),
                SizedBox(height: Dimensions.height20,),
                AppTextField(textFieldController: addressController, hintText: "type your address", prefixIcon: Icons.map),
                SizedBox(height: Dimensions.height20,),
                Padding(
                  padding: EdgeInsets.only(left: Dimensions.width20),
                  child: BigText(text: "Contact Name"),
                ),
                SizedBox(height: Dimensions.height20,),
                AppTextField(textFieldController: _contactPersonNameController, hintText: "name", prefixIcon: Icons.person),
                SizedBox(height: Dimensions.height20,),
                Padding(
                  padding: EdgeInsets.only(left: Dimensions.width20),
                  child: BigText(text: "Contact Number"),
                ),
                SizedBox(height: Dimensions.height20,),
                AppTextField(textFieldController: _contactPersonNumberController, hintText: "phone", prefixIcon: Icons.phone),
              ],
            ),
          );
        });
      }) ,
    );
  }
}
