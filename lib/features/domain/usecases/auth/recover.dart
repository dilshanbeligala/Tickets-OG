import 'package:class_q/features/data/models/request/request_barrel.dart';
import 'package:class_q/features/data/models/response/response_barrel.dart';
import 'package:class_q/features/domain/repository/repository_barrel.dart';
import 'package:class_q/features/domain/usecases/usecase_barrel.dart';
import 'package:dartz/dartz.dart';
import '../../../../error/error_barrel.dart';


class RecoverUseCase extends UseCase<RecoverResponse, Params> {
  final Repository? repository;

  RecoverUseCase({this.repository});

  @override
  Future<Either<Failure, RecoverResponse>> call(Params params) async {
    final recoverRequest = params.params[0] as RecoverRequest;

    return repository!.recover(recoverRequest);
  }
}
