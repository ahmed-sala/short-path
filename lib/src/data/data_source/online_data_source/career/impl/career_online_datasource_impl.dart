import 'dart:io';

import 'package:dio/dio.dart' as dio;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

import '../../../../../../config/helpers/shared_pref/shared_pre_keys.dart';
import '../../../../../../dependency_injection/di.dart';
import '../../../../api/core/constants/apis_baseurl.dart';
import '../../../../api/core/constants/apis_end_points.dart';
import '../contract/career_online_datasource.dart';

@Injectable(as: CareerOnlineDatasource)
class CareerOnlineDatasourceImpl implements CareerOnlineDatasource {
  @override
  Future<void> downloadFile() async {
    try {
      String? token = await getIt<FlutterSecureStorage>()
          .read(key: SharedPrefKeys.userToken);

      // Initialize Dio with a connection timeout of 10 seconds
      dio.Dio client = dio.Dio(
        dio.BaseOptions(
          connectTimeout: const Duration(seconds: 10),
        ),
      );

      dio.Response<dio.ResponseBody> response = await client.get(
        '${ApisBaseurl.baseUrl}${ApisEndPoints.downloadCv}',
        options: dio.Options(
          responseType: dio.ResponseType.stream,
          headers: {
            "Authorization": "Bearer $token",
          },
        ),
      );

      // Determine the directory to store the file.
      Directory directory;
      if (Platform.isAndroid) {
        // On Android, use the public Downloads directory.
        // NOTE: This is a hard-coded path and may need to be adjusted for different devices.
        // Alternatively, consider using a package like 'downloads_path_provider_28' for a more robust solution.
        directory = Directory('/storage/emulated/0/Download');
      } else {
        // For iOS or other platforms, use the app's document directory.
        directory = await getApplicationDocumentsDirectory();
      }

      // Create the file path using the determined directory.
      String filePath = path.join(directory.path, 'file.pdf');
      File file = File(filePath);

      // Write the stream to the file.
      IOSink sink = file.openWrite();
      await for (var chunk in response.data!.stream) {
        sink.add(chunk);
      }
      await sink.close();

      final fileSize = await file.length();
      print('File saved at: $filePath, size: $fileSize bytes');
      print('Download completed');
    } catch (e) {
      print('Download failed: $e');
    }
  }
}
