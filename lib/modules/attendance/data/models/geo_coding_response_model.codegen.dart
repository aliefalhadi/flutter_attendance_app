// To parse this JSON data, do
//
//     final geoCodingResponseModel = geoCodingResponseModelFromJson(jsonString);

import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/place_search_entity.codegen.dart';

part 'geo_coding_response_model.codegen.freezed.dart';
part 'geo_coding_response_model.codegen.g.dart';

@freezed
class GeoCodingResponseModel with _$GeoCodingResponseModel {
  const factory GeoCodingResponseModel({
    int? placeId,
    String? licence,
    String? osmType,
    int? osmId,
    String? lat,
    String? lon,
    String? geoCodingResponseModelClass,
    String? type,
    int? placeRank,
    double? importance,
    String? addresstype,
    String? name,
    String? displayName,
    Address? address,
    List<String>? boundingbox,
  }) = _GeoCodingResponseModel;

  factory GeoCodingResponseModel.fromJson(Map<String, dynamic> json) =>
      _$GeoCodingResponseModelFromJson(json);
}

@freezed
class Address with _$Address {
  const factory Address({
    String? road,
    String? village,
    String? city,
    String? county,
    String? state,
    String? iso31662Lvl4,
    String? region,
    String? iso31662Lvl3,
    String? postcode,
    String? country,
    String? countryCode,
  }) = _Address;

  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);
}

extension GeoCodingResponseModelX on GeoCodingResponseModel {
  PlaceSearchEntity toDomain(
    GeoPoint coordinate,
  ) {
    print("asdasd");
    print(displayName);
    return PlaceSearchEntity(
      placeName: name ?? '',
      placeAddress: displayName ?? '',
      latitude: coordinate.latitude,
      longitude: coordinate.longitude,
      provinces: address?.state ?? '',
      city: address?.city ?? '',
      district: address?.county ?? '',
      postalCode: address?.postcode ?? '',
    );
  }
}
