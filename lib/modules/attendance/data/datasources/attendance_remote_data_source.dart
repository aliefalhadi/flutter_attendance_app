import 'dart:io';

import 'package:attendance_app/common/extentions/string.dart';
import 'package:attendance_app/modules/attendance/domain/entities/post_attendance_params.codegen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart' as osm;
import 'package:injectable/injectable.dart';

import '../../../../common/constants/api_path_constant.dart';
import '../models/geo_coding_response_model.codegen.dart';

abstract class AttendanceRemoteDataSource {
  Future<GeoCodingResponseModel> convertCoordinateToAddress(
    osm.GeoPoint latLng,
  );
  Future<bool> submitAttendance(SubmitAttendanceParams attendanceParams);
  Future<String> uploadImage(String imagePath);
}

@LazySingleton(as: AttendanceRemoteDataSource)
class AttendanceRemoteDataSourceImpl extends AttendanceRemoteDataSource {
  final Dio _dio;
  final FirebaseFirestore _firestore;
  final FirebaseStorage _reference;

  AttendanceRemoteDataSourceImpl(this._dio, this._firestore, this._reference);

  @override
  Future<GeoCodingResponseModel> convertCoordinateToAddress(
    osm.GeoPoint latLng,
  ) async {
    //when using full url with protocol, dio will use this new url on this request only
    final res = await _dio.get(
      ApiPathConstant.getReserveLocation(latLng),
    );

    GeoCodingResponseModel responseModel =
        GeoCodingResponseModel.fromJson(res.data);

    return responseModel;
  }

  @override
  Future<bool> submitAttendance(SubmitAttendanceParams attendanceParams) async {
    await _firestore.collection('attendances').add(attendanceParams.toJson());

    return true;
  }

  @override
  Future<String> uploadImage(String imagePath) async {
    String fileName = DateTime.now().microsecondsSinceEpoch.toString();

    Reference referenceRoot = _reference.ref();
    Reference referenceDireImages = referenceRoot.child('images');

    Reference referenceImageToUpload =
        referenceDireImages.child(fileName + imagePath.getFileExtension());

    await referenceImageToUpload.putFile(File(imagePath));

    // We have successfully upload the image now
    // make this upload image link in firebase database

    String urlImage = await referenceImageToUpload.getDownloadURL();

    return urlImage;
  }
}
