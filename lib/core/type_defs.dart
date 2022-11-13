import 'package:fpdart/fpdart.dart';
import 'package:shoes_app_ui_training/core/failure.dart';

typedef FutureEither<T> = Future<Either<Failure, T>>;
typedef FutureVoid = FutureEither<void>;
