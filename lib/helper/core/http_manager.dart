import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:yusr/helper/core/cache_manager.dart';
import '../config/api_endpoints.dart';


class MLApi {
  postData(data, apiUrl) async {
    var fullUrl = apiUrl;
    try {
      final apiToken = await CacheManager.readData("plainTextToken");
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiToken'
      };
      return await http
          .post(
        Uri.parse(fullUrl),
        body: jsonEncode(data),
        headers:headers,
      )
          .timeout(
        const Duration(seconds: 10),
      );
    } on TimeoutException catch (e) {
      return http.Response(jsonEncode({"success": false, "code": 404}), 404);
    } on Exception catch (e) {
      return http.Response(jsonEncode({"success": false, "code": 404}), 404);
    }
  }

  getData(apiUrl) async {
    var fullUrl = apiUrl;
    try {
      final apiToken = await CacheManager.readData("plainTextToken");
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiToken'
      };
      final response = await http
          .get(
        Uri.parse(fullUrl),
        headers: headers,
      )
          .timeout(
        const Duration(seconds: 15),
      );
      return response;
    } on TimeoutException catch (e) {
      return http.Response(jsonEncode({"success": false, "code": 404}), 404);
    } on Exception catch (e) {
      return http.Response(jsonEncode({"success": false, "code": 404}), 404);
    }
  }


  putData(String apiPath, Map<String, dynamic> body) async {
    try {
      final apiToken = await CacheManager.readData("plainTextToken");
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiToken'
      };
      final response = await http.put(
        Uri.parse(apiPath),
        headers: headers,
        body: jsonEncode(body),
      ).timeout(
        const Duration(seconds: 15),
      );

      return response;
    } on TimeoutException catch (_) {
      return http.Response(jsonEncode({"success": false, "code": 404}), 404);
    } on Exception catch (_) {
      return http.Response(jsonEncode({"success": false, "code": 404}), 404);
    }
  }
}
// _getToken() async {
//   SharedPreferences localStorage = await SharedPreferences.getInstance();
//   return localStorage.getString('token');
// }