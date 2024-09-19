import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../error/failures.dart';

// Updated UseCase class to accept any number of parameters
abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}


class Params extends Equatable {
  final List<dynamic> params;

  const Params(this.params);

  @override
  List<Object?> get props => [params];
}


class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}