import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';

import '../../../../domain/entities/place_search_entity.codegen.dart';
import '../../../../domain/usecases/convert_coordinate_to_address_usecase.dart';

part 'attendance_submit_location_bloc.freezed.dart';
part 'attendance_submit_location_event.dart';
part 'attendance_submit_location_state.dart';

@injectable
class AttendanceSubmitLocationBloc
    extends Bloc<AttendanceSubmitLocationEvent, AttendanceSubmitLocationState> {
  final ConvertCoordinateToAddressUseCase _coordinateToAddressUseCase;
  AttendanceSubmitLocationBloc(this._coordinateToAddressUseCase)
      : super(const AttendanceSubmitLocationState()) {
    on<_GetLocation>(_onGetLocation);
    on<_GetAddress>(_onGetAddress);
  }

  FutureOr<void> _onGetLocation(_GetLocation event, emit) async {
    emit(
      state.copyWith(
        status: AttendanceSubmitLocationStatus.loading,
      ),
    );

    Position position = await Geolocator.getCurrentPosition();

    add(
      _GetAddress(
        latLng: GeoPoint(
          latitude: position.latitude,
          longitude: position.longitude,
        ),
      ),
    );
  }

  FutureOr<void> _onGetAddress(_GetAddress event, emit) async {
    emit(state.copyWith(status: AttendanceSubmitLocationStatus.loading));

    final res = await _coordinateToAddressUseCase(event.latLng);

    res.fold((l) => null, (data) {
      emit(
        state.copyWith(
            placeSearchEntity: data,
            coordinateLocation: event.latLng,
            status: AttendanceSubmitLocationStatus.loaded),
      );
    });
  }
}
