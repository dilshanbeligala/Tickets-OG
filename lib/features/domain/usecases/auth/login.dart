import 'package:class_q/features/data/models/request/request_barrel.dart';
import 'package:class_q/features/data/models/response/response_barrel.dart';
import 'package:class_q/features/domain/repository/repository_barrel.dart';
import 'package:class_q/features/domain/usecases/usecase_barrel.dart';
import 'package:dartz/dartz.dart';
import '../../../../error/error_barrel.dart';


class LoginUseCase extends UseCase<LoginResponse, Params> {
  final Repository? repository;

  LoginUseCase({this.repository});

  @override
  Future<Either<Failure, LoginResponse>> call(Params params) async {
    final loginRequest = params.params[0] as LoginRequest;

    return repository!.login(loginRequest);
  }
}
