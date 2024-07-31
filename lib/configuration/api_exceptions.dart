import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:grid_app/helpers/pateint_helper.dart';
import 'package:grid_app/main.dart';

class ApiException {
  static void getMessage(error, [bool canPop = true, bool showMessage = true]) {
    if(canPop){
      Navigator.pop(navigatorKey.currentState!.context);
    }
    dynamic errorDescription = "";
    if (error is Exception) {
      try {
        if (error is DioException) {
          switch (error.type) {
            case DioExceptionType.cancel:
              errorDescription = "Request to API server was cancelled";
              break;
            case DioExceptionType.connectionTimeout:
              errorDescription = "Connection timeout with API server";
              break;
            case DioExceptionType.connectionError:
              errorDescription = "Internet not available";
              break;
            case DioExceptionType.unknown:
              errorDescription =
                  // "Connection to API server failed due to internet connection";
                  "Internet not available";
              break;
            case DioExceptionType.receiveTimeout:
              errorDescription =
                  "Receive timeout in connection with API server";
              break;
            case DioExceptionType.badCertificate:
              errorDescription = "Invalid certificate";
              break;
            case DioExceptionType.badResponse:
              switch (error.response?.statusCode) {
                case 404:
                case 500:
                case 503:
                case 403:
                case 409:
                case 400:
                  errorDescription = error.response;
                  break;
                default:
                  // ErrorResponse errorResponse =
                  // ErrorResponse.fromJson(error.response.data);
                  // if (errorResponse.errors != null &&
                  //     errorResponse.errors.length > 0)
                  //   errorDescription = errorResponse;
                  // else
                  //   errorDescription =
                  "Failed to load data - status code: ${error.response?.statusCode}";
              }
              break;
            case DioExceptionType.sendTimeout:
              errorDescription = "Send timeout with server";
              break;
          }
        } else {
          errorDescription = "Unexpected error occured";
        }
      } on FormatException catch (e) {
        errorDescription = e.toString();
      }
    } else {
      errorDescription = "is not a subtype of exception";
    }
    Future.delayed(Duration.zero, () {
      if(showMessage) {
        PateintHelper.showBottomText(
        title: errorDescription.toString(),
      );
      }
    });
  }
}
