

import 'package:dartz/dartz.dart';

import '../../../../error/failures.dart';
import '../../../data/models/response/response_barrel.dart';
import '../../repository/repository_barrel.dart';
import '../usecase_barrel.dart';

class GetTicketHistoryUseCase extends UseCase<GetTicketHistory, Params> {
  final Repository? repository;

  GetTicketHistoryUseCase({this.repository});

  @override
  Future<Either<Failure, GetTicketHistory>> call(Params params) async {
    return repository!.getTicketHistory();
  }
}