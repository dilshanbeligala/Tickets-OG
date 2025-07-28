
import 'package:dartz/dartz.dart';
import 'package:tickets_og/features/data/models/request/request_barrel.dart';
import 'package:tickets_og/features/data/models/response/response_barrel.dart';
import 'package:tickets_og/features/domain/repository/repository_barrel.dart';
import 'package:tickets_og/features/domain/usecases/usecase_barrel.dart';
import '../../../../error/error_barrel.dart';


class ScanUseCase extends UseCase<ScanResponse, Params> {
  final Repository? repository;

  ScanUseCase({this.repository});

  @override
  Future<Either<Failure, ScanResponse>> call(Params params) async {
    final qrRequest = params.params[0] as QrRequest;

    return repository!.qrScan(qrRequest);
  }
}
