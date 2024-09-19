
import 'package:dartz/dartz.dart';
import 'package:tickets_og/features/data/models/request/request_barrel.dart';
import 'package:tickets_og/features/data/models/response/response_barrel.dart';
import 'package:tickets_og/features/domain/repository/repository_barrel.dart';
import 'package:tickets_og/features/domain/usecases/usecase_barrel.dart';
import '../../../../error/error_barrel.dart';


class ResetUseCase extends UseCase<ResetResponse, Params> {
  final Repository? repository;

  ResetUseCase({this.repository});

  @override
  Future<Either<Failure, ResetResponse>> call(Params params) async {
    final resetRequest = params.params[0] as ResetRequest;

    return repository!.reset(resetRequest);
  }
}
