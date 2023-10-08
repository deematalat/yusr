import 'package:flutter/material.dart';
import '../models/trip_model.dart';
import '../services/trip_service.dart';
import 'notify_controller.dart';


class TripProvider extends ChangeNotifier {
  final TripService tripService = TripService();
     late Future<List<Trip>?>? trips;
  late Future<List<Trip>?>? tripsHistory;
   String _status="";
   String get status=>_status;
  Future<List<Trip>?>? fetchAndSortTrips(BuildContext context,int sort_by_option) async {
     final trips=   tripService.fetchAndSortTrips(context,sort_by_option);
     print("this trips$trips");
   return trips;
  }
  Future<List<Trip>?>? fetchAndSortTripsByStatus(BuildContext context,int sort_by_option) async {
    final trips=  tripService.fetchAndSortTripsByStatus(context,sort_by_option);
    return trips;
  }
  Future<List<Trip>?> fetchAndSortTripsHistory(BuildContext context, int sort_by_option) async {
      tripsHistory= tripService.fetchAndSortTripsHistory(context,sort_by_option);
       return tripsHistory;
  }
  Future<void>getTripData(tripId, context) async{
   Trip? x= await tripService.fetchTripData(tripId, context);
   _status= x!.status;
   notifyListeners();
  }





  Future<void> updateTrip(int tripId, tripDate, tripTime, tripStatus, context) async {
      await tripService.updateTrip(tripId, tripDate, tripTime, tripStatus, context);
      notifyListeners();

  }
}
