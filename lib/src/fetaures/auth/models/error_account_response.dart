import 'package:orgasync/src/fetaures/auth/auth.dart';

class ErrorAccountResponse{
  final String message;
  final TypeAccount typeAccount;

  ErrorAccountResponse(this.typeAccount,{this.message = ""});
}