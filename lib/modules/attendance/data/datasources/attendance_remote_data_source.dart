import 'package:dio/dio.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:injectable/injectable.dart';

import '../../../../common/constants/api_path_constant.dart';
import '../models/geo_coding_response_model.codegen.dart';

abstract class AttendanceRemoteDataSource {
  Future<GeoCodingResponseModel> convertCoordinateToAddress(GeoPoint latLng);
}

@LazySingleton(as: AttendanceRemoteDataSource)
class AttendanceRemoteDataSourceImpl extends AttendanceRemoteDataSource {
  final Dio _dio;

  AttendanceRemoteDataSourceImpl(this._dio);

  @override
  Future<GeoCodingResponseModel> convertCoordinateToAddress(
    GeoPoint latLng,
  ) async {
    //when using full url with protocol, dio will use this new url on this request only
    final res = await _dio.get(
      ApiPathConstant.getReserveLocation(latLng),
    );

    GeoCodingResponseModel responseModel =
        GeoCodingResponseModel.fromJson(res.data);

    return responseModel;
  }
}
