class HttpUtil {
  HttpUtil._();

  // TODO: wrap Error
  static bool emptyResponse(dynamic data) {
    if (data == '') return true;
    throw data;
  }
}
