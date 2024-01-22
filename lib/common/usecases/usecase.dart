import 'package:dartz/dartz.dart';

import '../constants/app_error.dart';

abstract class UseCase<ReturnType, Params> {
  const UseCase();
  Future<Either<AppError, ReturnType>> call(Params params);
}
