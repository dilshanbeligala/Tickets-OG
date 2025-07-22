

import 'package:dartz/dartz.dart';

import '../../../../error/failures.dart';
import '../../../data/models/response/response_barrel.dart';
import '../../repository/repository_barrel.dart';
import '../usecase_barrel.dart';

class GetTicketDetailsUseCase extends UseCase<GetTicketDetailsResponse, Params> {
  final Repository? repository;

  GetTicketDetailsUseCase({this.repository});

  @override
  Future<Either<Failure, GetTicketDetailsResponse>> call(Params params) async {
    return repository!.getTicketDetails();
  }
}