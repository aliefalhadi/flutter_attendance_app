import 'dart:async';

import 'package:attendance_app/common/extentions/date_format.dart';
import 'package:attendance_app/modules/attendance/domain/entities/list_attendance_params.codegen.dart';
import 'package:attendance_app/modules/login/domain/entity/user_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/entities/attendance_entity.codegen.dart';
import '../../../domain/usecases/get_list_attendance_usecase.dart';

part 'history_attendance_bloc.freezed.dart';
part 'history_attendance_event.dart';
part 'history_attendance_state.dart';

@injectable
class HistoryAttendanceBloc
    extends Bloc<HistoryAttendanceEvent, HistoryAttendanceState> {
  final GetListAttendanceUseCase _getListAttendanceUseCase;

  HistoryAttendanceBloc(this._getListAttendanceUseCase)
      : super(const HistoryAttendanceState()) {
    on<_InitDate>(_onInitDate);
    on<_ChangeDate>(_onChangeDate);
    on<_GetListAttendance>(_onGetListAttendance);
  }

  FutureOr<void> _onInitDate(_InitDate event, emit) {
    emit(state.copyWith(status: HistoryAttendanceStatus.loading));

    final dateNow = DateTime.now();

    emit(
      state.copyWith(
        selectedDateStart: dateNow.subtract(
          const Duration(days: 7),
        ),
        selectedDateEnd: dateNow,
        userEntity: event.userEntity,
        status: HistoryAttendanceStatus.loaded,
      ),
    );

    add(const _GetListAttendance());
  }

  FutureOr<void> _onChangeDate(_ChangeDate event, emit) {
    emit(
      state.copyWith(
        selectedDateStart: event.startDatetime,
        selectedDateEnd: event.endDatetime,
      ),
    );

    add(const _GetListAttendance());
  }

  FutureOr<void> _onGetListAttendance(_GetListAttendance event, emit) async {
    emit(state.copyWith(status: HistoryAttendanceStatus.loading));

    final res = await _getListAttendanceUseCase(
      ListAttendanceParams(
        startDate: state.selectedDateStart!.toFormatDateParams(),
        endDate: state.selectedDateEnd!.toFormatDateParams(),
        userId: state.userEntity!.id!,
        companyId: state.userEntity!.companyId!,
      ),
    );

    res.fold(
      (err) => null,
      (data) {
        emit(
          state.copyWith(
            listAttendance: data,
            status: HistoryAttendanceStatus.loaded,
          ),
        );
      },
    );
  }
}
