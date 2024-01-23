import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';

class ApiPathConstant {
  ApiPathConstant._();

  static String getReserveLocation(GeoPoint latLong) {
    return 'https://nominatim.openstreetmap.org/reverse?format=json&lat=${latLong.latitude}&lon=${latLong.longitude}&zoom=18&addressdetails=1';
  }
}
