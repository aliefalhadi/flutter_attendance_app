import 'dart:async';

import 'package:attendance_app/common/extentions/date_format.dart';
import 'package:attendance_app/modules/attendance/domain/entities/attendance_entity.codegen.dart';
import 'package:attendance_app/modules/attendance/domain/entities/list_attendance_params.codegen.dart';
import 'package:attendance_app/modules/login/domain/entity/user_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/usecases/get_list_attendance_usecase.dart';

part 'attendance_home_bloc.freezed.dart';
part 'attendance_home_event.dart';
part 'attendance_home_state.dart';

@injectable
class AttendanceHomeBloc
    extends Bloc<AttendanceHomeEvent, AttendanceHomeState> {
  final GetListAttendanceUseCase _getListAttendanceUseCase;

  AttendanceHomeBloc(this._getListAttendanceUseCase)
      : super(const AttendanceHomeState()) {
    on<_GetListAttendanceToday>(_onGetListAttendanceToday);
  }

  FutureOr<void> _onGetListAttendanceToday(
      _GetListAttendanceToday event, emit) async {
    emit(state.copyWith(status: AttendanceHomeStatus.loading));

    DateTime dateTimeNow = DateTime.now();
    String dateNowString = dateTimeNow.toFormatDateParams();

    final res = await _getListAttendanceUseCase(
      ListAttendanceParams(
        startDate: dateNowString,
        endDate: dateNowString,
        userId: event.userEntity.id!,
        companyId: event.userEntity.companyId!,
      ),
    );

    res.fold((l) => null, (data) {
      emit(state.copyWith(
        listAttendance: data,
        dateTimeNow: dateTimeNow,
        status: AttendanceHomeStatus.loaded,
      ));
    });
  }
}
