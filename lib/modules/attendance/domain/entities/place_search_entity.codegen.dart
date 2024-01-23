import 'package:freezed_annotation/freezed_annotation.dart';

part 'place_search_entity.codegen.freezed.dart';

@freezed
class PlaceSearchEntity with _$PlaceSearchEntity {
  const factory PlaceSearchEntity({
    required String placeName,
    required String placeAddress,
    required double latitude,
    required double longitude,
    required String provinces,
    required String city,
    required String district,
    required String postalCode,
  }) = _PlaceSearchEntity;
}
