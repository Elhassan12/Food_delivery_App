import 'dart:convert';

import 'package:ecommerce_app/data/repository/location_repo/location_repo.dart';
import 'package:ecommerce_app/models/address_model/address_model.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationController extends GetxController implements GetxService {
  LocationRepo locationRepo;

  LocationController({required this.locationRepo});

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  late Position _position;

  List<Placemark> get pickPlacemark => _pickPlacemark;
  late Position _pickPosition;

  Position get position => _position;

  Position get pickPosition => _pickPosition;

  List<Placemark> _placeMark = [] ;
  List<Placemark> _pickPlacemark = [];

  List<AddressModel> _addressList = [];
  late List<AddressModel> _allAddressList;

  List<String> _addressType = ["home", "office", "work"];
  int _addressTypeIndex = 0;


  List<AddressModel> get addressList => _addressList;

  List<Placemark> get placemark => _placeMark;

  List<String> get addressType => _addressType;

  late GoogleMapController mapController;

  void setMapController(GoogleMapController googleMapController) {
    mapController = googleMapController;
  }

  bool _updateAddressData = true;
  bool _changeAddress = true;

  void updatePosition(
      CameraPosition cameraPosition, bool fromAddAddress) async {
    if (_updateAddressData) {
      try {
        if (fromAddAddress) {
          _position = Position(
              longitude: cameraPosition.target.longitude,
              latitude: cameraPosition.target.latitude,
              timestamp: DateTime.now(),
              accuracy: 1,
              altitude: 1,
              heading: 1,
              speed: 1,
              speedAccuracy: 1);
        } else {
          _pickPosition = Position(
              longitude: cameraPosition.target.longitude,
              latitude: cameraPosition.target.latitude,
              timestamp: DateTime.now(),
              accuracy: 1,
              altitude: 1,
              heading: 1,
              speed: 1,
              speedAccuracy: 1);
        }
        if (_changeAddress) {
          List<Placemark> _address = await getAddressFromGeocoding(LatLng(
              cameraPosition.target.latitude, cameraPosition.target.longitude));
          print(_address);
          _placeMark = _address;
        }
      } catch (e) {
        print("add address error / " + e.toString());
      }
    }
    update();
  }

  Future<List<Placemark>> getAddressFromGeocoding(LatLng position) async {
    List<Placemark> _address ;
    // Response response = await locationRepo.getAddressFromGeocoding(position);
    // if (response.body['status'] == "ok") {
    //   _address = response.body['result'][0]['formatted_address'].toString();
    // } else {
    //   print('error to getting address');
    // }
    _address = (await placemarkFromCoordinates(
        position.latitude, position.longitude));

    return _address;
  }


  late Map<String, dynamic> _getAddress;

  Map<String, dynamic> get getAddress => _getAddress;

 AddressModel  getUserAddress(){
     late AddressModel _addressModel;
     _getAddress = jsonDecode(locationRepo.getUserAddress());
     try{
       _addressModel = AddressModel.fromJson(_getAddress);
     }catch(e){
       print('error while getting address form sharedPref '+ e.toString());
     }
     return _addressModel;
   }
}
