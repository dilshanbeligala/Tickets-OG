import 'package:class_q/features/data/models/request/request_barrel.dart';
import 'package:class_q/features/data/models/response/response_barrel.dart';

abstract class RemoteDataSource {

  Future<RegisterResponse> register(RegisterRequest registerRequest);

  Future<LoginResponse> login(LoginRequest loginRequest);

  Future<RecoverResponse> recover(RecoverRequest recoverRequest);

  Future<VerifyOtpResponse> verifyOtp(VerifyOtpRequest verifyOtpRequest);

  Future<ResetResponse> reset(ResetRequest resetRequest);

}
