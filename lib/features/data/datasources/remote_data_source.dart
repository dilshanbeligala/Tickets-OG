import 'package:tickets_og/features/data/models/request/request_barrel.dart';
import 'package:tickets_og/features/data/models/response/response_barrel.dart';

abstract class RemoteDataSource {

  Future<RotateTokenResponse?> rotateToken(RotateTokenRequest request);

  Future<LoginResponse> login(LoginRequest loginRequest);

  Future<RecoverResponse> recover(RecoverRequest recoverRequest);

  Future<VerifyOtpResponse> verifyOtp(VerifyOtpRequest verifyOtpRequest);

  Future<ResetResponse> reset(ResetRequest resetRequest);

  Future<GetTicketDetailsResponse> getTicketDetails();

}
