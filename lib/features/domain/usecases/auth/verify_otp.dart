
import 'package:dartz/dartz.dart';
import 'package:tickets_og/features/data/models/request/request_barrel.dart';
import 'package:tickets_og/features/data/models/response/response_barrel.dart';
import 'package:tickets_og/features/domain/repository/repository_barrel.dart';
import 'package:tickets_og/features/domain/usecases/usecase_barrel.dart';
import '../../../../error/error_barrel.dart';


class VerifyOtpUseCase extends UseCase<VerifyOtpResponse, Params> {
  final Repository? repository;

  VerifyOtpUseCase({this.repository});

  @override
  Future<Either<Failure, VerifyOtpResponse>> call(Params params) async {
    final verifyOtpRequest = params.params[0] as VerifyOtpRequest;

    return repository!.verifyOtp(verifyOtpRequest);
  }
}
