import 'package:dio/dio.dart';
import 'package:todo_app/data/network/rest_api/network_constants.dart';

class TokenInterceptor extends Interceptor {
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    super.onError(err, handler);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (options.path != RESTPaths.loginPath) {
      // String cookie = DI.getItInstance<AppCache>().getCookie();
      // options.headers['Cookie'] = cookie;
    }
    super.onRequest(options, handler);
  }
}
