import 'package:class_q/features/data/models/request/request_barrel.dart';
import 'package:class_q/features/data/models/response/response_barrel.dart';
import 'package:class_q/features/domain/repository/repository_barrel.dart';
import 'package:class_q/features/domain/usecases/usecase_barrel.dart';
import 'package:dartz/dartz.dart';
import '../../../../error/error_barrel.dart';


class RegisterUseCase extends UseCase<RegisterResponse, Params> {
  final Repository? repository;

  RegisterUseCase({this.repository});

  @override
  Future<Either<Failure, RegisterResponse>> call(Params params) async {
    final registerRequest = params.params[0] as RegisterRequest;

    return repository!.register(registerRequest);
  }
}
