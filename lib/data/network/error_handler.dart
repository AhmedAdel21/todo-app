import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:todo_app/app/error/failure.dart';
import 'package:todo_app/presentation/resources/strings_manager.dart';

class ErrorHandler implements Exception {
  late Failure failure;

  ErrorHandler.handle(dynamic error) {
    if (error is DioError) {
      failure = _handleApiError(error); // handle
    } else {
      failure = DataSource.none.getFailure();
    }
  }
}

Failure _handleApiError(DioError error) {
  switch (error.type) {
    case DioErrorType.response:
      if (error.response != null &&
          error.response?.statusCode != null &&
          error.response?.statusMessage != null) {
        return Failure(error.response?.statusCode! ?? 0,
            error.response?.statusMessage ?? "");
      } else {
        return DataSource.none.getFailure();
      }
    case DioErrorType.connectTimeout:
      return DataSource.connectionTimeOut.getFailure();
    case DioErrorType.sendTimeout:
      return DataSource.sendTimeOut.getFailure();
    case DioErrorType.receiveTimeout:
      return DataSource.receiveTimeOut.getFailure();
    case DioErrorType.cancel:
      return DataSource.cancel.getFailure();
    case DioErrorType.other:
      return DataSource.none.getFailure();
  }
}

enum DataSource {
  none,
  success,
  noContent,
  badRequest,
  forbidden,
  unauthorized,
  notFound,
  internalServerError,
  connectionTimeOut,
  cancel,
  receiveTimeOut,
  sendTimeOut,
  cacheError,
  noInternetConnection;

  Failure getFailure() {
    switch (this) {
      case DataSource.success:
        return Failure(ResponseCode.success, ResponseMessage.success.tr());
      case DataSource.noContent:
        return Failure(ResponseCode.noContent, ResponseMessage.noContent.tr());
      case DataSource.badRequest:
        return Failure(
            ResponseCode.badRequest, ResponseMessage.badRequest.tr());
      case DataSource.forbidden:
        return Failure(ResponseCode.forbidden, ResponseMessage.forbidden.tr());
      case DataSource.unauthorized:
        return Failure(
            ResponseCode.unauthorized, ResponseMessage.unauthorized.tr());
      case DataSource.notFound:
        return Failure(ResponseCode.notFound, ResponseMessage.notFound.tr());
      case DataSource.internalServerError:
        return Failure(ResponseCode.internalServerError,
            ResponseMessage.internalServerError.tr());
      case DataSource.connectionTimeOut:
        return Failure(ResponseCode.connectionTimeOut,
            ResponseMessage.connectionTimeOut.tr());
      case DataSource.cancel:
        return Failure(ResponseCode.cancel, ResponseMessage.cancel.tr());
      case DataSource.receiveTimeOut:
        return Failure(
            ResponseCode.receiveTimeOut, ResponseMessage.receiveTimeOut.tr());
      case DataSource.sendTimeOut:
        return Failure(
            ResponseCode.sendTimeOut, ResponseMessage.sendTimeOut.tr());
      case DataSource.cacheError:
        return Failure(
            ResponseCode.cacheError, ResponseMessage.cacheError.tr());
      case DataSource.noInternetConnection:
        return Failure(ResponseCode.noInternetConnection,
            ResponseMessage.noInternetConnection.tr());
      case DataSource.none:
        return Failure(ResponseCode.none, ResponseMessage.none.tr());
    }
  }
}

class ResponseCode {
  static const int success = 200; // success with data
  static const int noContent = 201; // success with no data (no content)
  static const int badRequest = 400; // failure, API rejected request
  static const int unauthorized = 401; // failure, user is not authorized
  static const int forbidden = 403; //  failure, API rejected request
  static const int notFound = 404; // failure, Not found
  static const int internalServerError = 500; // failure, crash in server side

  // local status code
  static const int connectionTimeOut = -1; //
  static const int cancel = -2; //
  static const int receiveTimeOut = -3; //
  static const int sendTimeOut = -4; //
  static const int cacheError = -5; //
  static const int noInternetConnection = -6; //
  static const int none = -7; //
}

class ResponseMessage {
  static const String success = AppStrings.success; // success with data
  static const String noContent =
      AppStrings.success; // success with no data (no content)
  static const String badRequest =
      AppStrings.badRequestError; // failure, API rejected request
  static const String unauthorized =
      AppStrings.unauthorizedError; // failure, user is not authorized
  static const String forbidden =
      AppStrings.forbiddenError; //  failure, API rejected request
  static const String notFound =
      AppStrings.internalServerError; // failure, crash in server side
  static const String internalServerError =
      AppStrings.notFoundError; // failure, crash in server side

  // local status code
  static const String connectionTimeOut = AppStrings.timeoutError; //
  static const String cancel = AppStrings.defaultError; //
  static const String receiveTimeOut = AppStrings.timeoutError; //
  static const String sendTimeOut = AppStrings.timeoutError; //
  static const String cacheError = AppStrings.cacheError; //
  static const String noInternetConnection = AppStrings.noInternetError; //
  static const String none = AppStrings.defaultError; //
}

class ApiInternalStatus {
  static const success = 0;
  static const failure = 1;
}
