import 'package:short_path/core/common/api/api_result.dart';

abstract interface class CareerRepository {
  Future<ApiResult<String>> downloadFile();
}
