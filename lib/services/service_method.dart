import 'package:geolocator/geolocator.dart';

import '../model/branch_model/address_model.dart';
import 'location_service.dart';

class ServiceMethods {
  Future searchCoordinateAddress(context, Position position) async {
    print("Service");
    String placeAddress = "";
    String st1, st2, st3, st4;
    String url =
        "https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=AIzaSyDa3ndOn9kcJhiJqKBwi6D9WLwO_mH-_tM";

    final response = await LocationService().getRequest(url);

    print(response);
    print(url);

    if (response != "Failed") {
      st1 = response["results"][0]["address_components"][0]["long_name"];
      st2 = response["results"][0]["address_components"][1]["long_name"];
      st3 = response["results"][0]["address_components"][2]["long_name"];
      st4 = response["results"][0]["address_components"][3]["long_name"];

      placeAddress = st1 + ", " + st2 + ", " + st3 + ", " + st4;

      AddressModel userPickupAddress = AddressModel();
      userPickupAddress.placeName = placeAddress;
      userPickupAddress.latitude = position.latitude;
      userPickupAddress.longitude = position.longitude;
    }
    print("Address ${placeAddress}");
    return placeAddress;
  }
}
