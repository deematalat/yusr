import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import '../helper/config/api_endpoints.dart';
import '../helper/core/cache_manager.dart';
import '../models/trip_model.dart';
import 'package:http/http.dart' as http;

class TripService {
  final String apiUrl = ApiEndpoint.api;
  final String passwordApi = ApiEndpoint.password;

  Future<List<Trip>?> fetchAndSortTrips(BuildContext context, int sortOption) async {
    try {
      final apiToken = await CacheManager.readData("plainTextToken");
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiToken',
      };

      final response = await _sendRequest(
        "${ApiEndpoint.trips}?sort_by_option=$sortOption&password_api=$passwordApi",
        {'sort_by_option': sortOption.toString()},
        headers,
      );

      if (response != null) {
        final jsonData = json.decode(response);

        if (jsonData['status'] == 200) {
          final List<dynamic> tripListData = jsonData['data'];
          final List<Trip> trips = tripListData.map((tripData) {
            return Trip.fromJson(tripData);
          }).toList();

          return trips;
        } else {
          _handleError(context, jsonData);
        }
      }
    } catch (e) {
      _handleError(context, e);
    }

    return null;
  }

  Future<List<Trip>?> fetchAndSortTripsByStatus(BuildContext context, int status) async {
    try {
      final apiToken = await CacheManager.readData("plainTextToken");
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiToken',
      };

      final response = await _sendRequest(
        "${ApiEndpoint.trips}?status=$status&password_api=$passwordApi",
        {'status': status.toString(), 'from': '0', 'to': '0'},
        headers,
      );

      if (response != null) {
        final jsonData = json.decode(response);

        if (jsonData['status'] == 200) {
          final List<dynamic> tripListData = jsonData['data'];
          final List<Trip> trips = tripListData.map((tripData) {
            return Trip.fromJson(tripData);
          }).toList();

          return trips;
        } else {
          _handleError(context, jsonData);
        }
      }
    } catch (e) {
      _handleError(context, e);
    }

    return null;
  }

  Future<List<Trip>?> fetchAndSortTripsHistory(BuildContext context, int sortOption) async {
    try {
      final apiToken = await CacheManager.readData("plainTextToken");
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiToken',
      };

      final response = await _sendRequest(
        "${ApiEndpoint.tripHistory}?sort_by_option=$sortOption&password_api=$passwordApi",
        {'sort_by_option': sortOption.toString(), 'from': '0', 'to': '0'},
        headers,
      );

      if (response != null) {
        final jsonData = json.decode(response);

        if (jsonData['status'] == 200) {
          final List<dynamic> tripListData = jsonData['data'];
          final List<Trip> trips = tripListData.map((tripData) {
            return Trip.fromJson(tripData);
          }).toList();

          return trips;
        } else {
          _handleError(context, jsonData);
        }
      }
    } catch (e) {
      _handleError(context, e);
    }

    return null;
  }
  Future<Trip?> fetchTripData(int tripId, BuildContext context) async {
    try {
      final apiToken = await CacheManager.readData("plainTextToken");
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiToken',
      };

      final response = await _sendGetRequest(
        'trip/$tripId?password_api=$passwordApi',
        headers,
      );

      if (response != null) {
        final jsonData = json.decode(response);

        if (jsonData['status'] == 200) {
          final Map<String, dynamic> data = jsonData['data'];
          return Trip.fromJson(data);
        } else {
          _handleError(context, jsonData);
        }
      }
    } catch (e) {
      _handleError(context, e);
    }

    return null;
  }
  Future<void> updateTrip(int tripId, tripDate, tripTime, status, BuildContext context) async {
    try {
      final apiToken = await CacheManager.readData("plainTextToken");
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiToken',
      };

      final response = await _sendPutRequest(
        'trip/update/$tripId?password_api=$passwordApi',
        json.encode({
          "trip_date": tripDate,
          "trip_hours_date": tripTime,
          "status": status,
          "password_api": passwordApi,
        }),
        headers,
      );

      if (response != null) {
        if (response.statusCode == 200) {
          final responseBody = await response.stream.bytesToString();
        } else {
          _handleError(context, {
            'message': response.reasonPhrase,
            'status': response.statusCode,
          });
        }
      }
    } catch (e) {
      _handleError(context, e);
    }
  }
  Future<String?> _sendGetRequest(String endpoint, Map<String, String> headers) async {
    final uri = Uri.parse('$apiUrl$endpoint');
    final request = http.Request('GET', uri);
    request.headers.addAll(headers);

    final response = await request.send();
    if (response.statusCode == 200) {
      return await response.stream.bytesToString();
    }

    return null;
  }
  Future<String?> _sendRequest(String endpoint, Map<String, dynamic> params, Map<String, String> headers) async {
    final uri = Uri.parse('$apiUrl$endpoint');
    uri.replace(queryParameters: params);
    final request = http.Request('GET', uri);
    request.headers.addAll(headers);

    final response = await request.send();
    if (response.statusCode == 200) {
      return await response.stream.bytesToString();
    }

    return null;
  }
  Future<http.StreamedResponse> _sendPutRequest(String endpoint, String body, Map<String, String> headers) async {
    final uri = Uri.parse('$apiUrl$endpoint');
    final request = http.Request('PUT', uri);
    request.body = body;
    request.headers.addAll(headers);

    return await request.send();
  }
  void _handleError(BuildContext context, dynamic error) {
    if (error is SocketException) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("No network connection. Please check your internet connection."),
        ),
      );
    } else if (error is Map<String, dynamic>) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("${error['message']}"),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("An error occurred while making the request. Please try again."),
        ),
      );
    }
  }
}

// class TripService {
//   Future<List<Trip>?> fetchAndSortTrips(
//       BuildContext context, int sort_by_option) async {
//     final apiToken = await CacheManager.readData("plainTextToken");
//     var headers = {
//       'Content-Type': 'application/json',
//       'Authorization': 'Bearer $apiToken',
//     };
//
//     var request = http.Request(
//         'GET',
//         Uri.parse(
//             'https://yusrapp.com/api/home?password_api=AaIMWSJIO21890&sort_by_option=$sort_by_option&from&to'));
//     request.headers.addAll(headers);
//     try {
//       http.StreamedResponse response = await request.send();
//       if (response.statusCode == 200) {
//         final responseBody = await response.stream.bytesToString();
//         final jsonData = json.decode(responseBody);
//         print("Response Body: $responseBody");
//         print("JSON Data: $jsonData");
//         if (jsonData['status'] == 200) {
//           final List<dynamic> tripListData = jsonData['data'];
//           print("this tripdata $tripListData");
//           final List<Trip> trips = tripListData.map((tripData) {
//             return Trip.fromJson(tripData);
//           }).toList();
//
//           print("this tripdata $trips");
//           return trips;
//         } else {
//           // Handle non-200 status codes gracefully
//           //print(" failed with status code: ${jsonData['message']}");
//           ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//             content: Text("${response.reasonPhrase}"),
//           ));
//           return null;
//         }
//       }
//     } catch (e) {
//       if (e is SocketException) {
//         print("No network connection");
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text(
//                 "No network connection. Please check your internet connection."),
//           ),
//         );
//       } else {
//         print("Error: $e");
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text(
//                 "An error occurred while making the request. Please try again."),
//           ),
//         );
//       }
//     }
//   }
//
//   Future<List<Trip>?> fetchAndSortTripsByStatus(
//       BuildContext context, int status) async {
//     final apiToken = await CacheManager.readData("plainTextToken");
//     var headers = {
//       'Content-Type': 'application/json',
//       'Authorization': 'Bearer $apiToken'
//     };
//     try {
//       var request = http.Request(
//           'GET',
//           Uri.parse(
//               'https://yusrapp.com/api/home?password_api=AaIMWSJIO21890&status=$status&from=0&to=0'));
//       request.headers.addAll(headers);
//
//       http.StreamedResponse response = await request.send();
//       if (response.statusCode == 200) {
//         final responseBody = await response.stream.bytesToString();
//         final jsonData = json.decode(responseBody);
//         if (jsonData['status'] == 200) {
//           final List<dynamic> tripListData = jsonData['data'];
//           final List<Trip> trips = tripListData.map((tripData) {
//             return Trip.fromJson(tripData);
//           }).toList();
//           return trips;
//         } else {
//           // Handle non-200 status codes gracefully
//           //print(" failed with status code: ${jsonData['message']}");
//           ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//             content: Text("${response.reasonPhrase}"),
//           ));
//           return null;
//         }
//       }
//     } catch (e) {
//       if (e is SocketException) {
//         print("No network connection");
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text(
//                 "No network connection. Please check your internet connection."),
//           ),
//         );
//       } else {
//         print("Error: $e");
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text(
//                 "An error occurred while making the request. Please try again."),
//           ),
//         );
//       }
//     }
//   }
//
//   Future<List<Trip>?> fetchAndSortTripsHistory(
//       BuildContext context, int sort_by_option) async {
//     final apiToken = await CacheManager.readData("plainTextToken");
//     var headers = {
//       'Content-Type': 'application/json',
//       'Authorization': 'Bearer $apiToken'
//     };
//
//     var request = http.Request(
//         'GET',
//         Uri.parse(
//             'https://yusrapp.com/api/history/trips?password_api=AaIMWSJIO21890&sort_by_option=$sort_by_option&from&to'));
//
//     request.headers.addAll(headers);
//     try {
//       http.StreamedResponse response = await request.send();
//       if (response.statusCode == 200) {
//         final responseBody = await response.stream.bytesToString();
//         final jsonData = json.decode(responseBody);
//         if (jsonData['status'] == 200) {
//           final List<dynamic> tripListData = jsonData['data'];
//           final List<Trip> trips = tripListData.map((tripData) {
//             return Trip.fromJson(tripData);
//           }).toList();
//           print(trips);
//           // You now have a list of Trip objects
//           return trips;
//         } else {
//           // Handle non-200 status codes gracefully
//           print(" failed with status code: ${jsonData['message']}");
//           ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//             content: Text("${jsonData['message']}"),
//           ));
//           return null;
//         }
//       }
//     } catch (e) {
//       if (e is SocketException) {
//         print("No network connection");
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text(
//                 "No network connection. Please check your internet connection."),
//           ),
//         );
//       } else {
//         print("Error: $e");
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text(
//                 "An error occurred while making the request. Please try again."),
//           ),
//         );
//       }
//     }
//   }
//
//   Future<Trip?> fetchTripData(int tripId, BuildContext context) async {
//     final apiToken = await CacheManager.readData("plainTextToken");
//     var headers = {
//       'Content-Type': 'application/json',
//       'Authorization': 'Bearer $apiToken'
//     };
//     try {
//       var request = http.Request(
//           'GET',
//           Uri.parse(
//               'https://yusrapp.com/api/trip/$tripId?password_api=AaIMWSJIO21890'));
//
//       request.headers.addAll(headers);
//
//       http.StreamedResponse response = await request.send();
//       if (response.statusCode == 200) {
//         final responseBody = await response.stream.bytesToString();
//
//         final jsonData = json.decode(responseBody);
//
//         if (response.statusCode == 200) {
//           final Map<String, dynamic> data = jsonData['data'];
//           // Handle the data as needed
//           print(data);
//           return Trip.fromJson(data);
//         } else {
//           // Handle errors here
//           print('Error: ${response.statusCode}');
//           print(response.reasonPhrase);
//           ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//             content: Text("${jsonData['message']}"),
//           ));
//           return null;
//         }
//       }
//     } catch (e) {
//       if (e is SocketException) {
//         print("No network connection");
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text(
//                 "No network connection. Please check your internet connection."),
//           ),
//         );
//       } else {
//         print("Error: $e");
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text(
//                 "An error occurred while making the request. Please try again."),
//           ),
//         );
//       }
//     }
//   }
//
//   Future<void> updateTrip(
//       int tripId, tripDate, tripTime, status, BuildContext context) async {
//     final apiToken = await CacheManager.readData("plainTextToken");
//     var headers = {
//       'Content-Type': 'application/json',
//       'Authorization': 'Bearer $apiToken'
//     };
//     try {
//       var request = http.Request(
//           'PUT',
//           Uri.parse(
//               'https://yusrapp.com/api/trip/update/$tripId?password_api=AaIMWSJIO21890'));
//       request.body = json.encode({
//         "trip_date": tripDate,
//         "trip_hours_date": tripTime,
//         "status": status,
//         "password_api": "AaIMWSJIO21890"
//       });
//       request.headers.addAll(headers);
//       http.StreamedResponse response = await request.send();
//       if (response.statusCode == 200) {
//         final responseBody = await response.stream.bytesToString();
//       } else {
//         // Handle errors here
//         print('Error: ${response.statusCode}');
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//           content: Text("${response.reasonPhrase}"),
//         ));
//       }
//     } catch (e) {
//       if (e is SocketException) {
//         print("No network connection");
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text(
//                 "No network connection. Please check your internet connection."),
//           ),
//         );
//       } else {
//         print("Error: $e");
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text(
//                 "An error occurred while making the request. Please try again."),
//           ),
//         );
//       }
//     }
//   }
// }
