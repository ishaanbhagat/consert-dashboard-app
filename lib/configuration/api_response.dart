import 'package:dio/dio.dart';

class ApiRepoResponse {
  final Response response;
  final dynamic error;

  ApiRepoResponse(this.response, this.error);

  ApiRepoResponse.withError(dynamic errorValue)
      // : response = null,
      : response = errorValue,
        error = errorValue;

  ApiRepoResponse.withSuccess(Response responseValue)
      : response = responseValue,
        error = null;
}
