import 'package:dartz/dartz.dart';

import '../constants/app_error.dart';

abstract class NoParamsUseCase<ReturnType> {
  const NoParamsUseCase();

  Future<Either<AppError, ReturnType>> call();
}
