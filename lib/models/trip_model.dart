class Trip {
  final int id;
  final String userId;
  final String driverId;
  final String? carId;
  final String? countryId;
  final String? stateId;
  final String? surveyId;
  final String fullname;
  final String phone;
  final String typeTour;
  final String returnOption;
  final DateTime? returnDateTime;
  final String reason;
  final String needs;
  final String dateTour;
  final String timeDateTour;
  final String startLat;
  final String endLat;
  final String startLong;
  final String endLong;
  final String startAddress;
  final String endAddress;
  final String address;
  final String notes;
  final String fees;
  final String cost;
  final String distanceTime;
  final String distanceKilo;
  final String status;
  final String slug;
  final String changeTime;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;

  Trip({
    required this.id,
    required this.userId,
    required this.driverId,
    this.carId,
    this.countryId,
    this.stateId,
    this.surveyId,
    required this.fullname,
    required this.phone,
    required this.typeTour,
    required this.returnOption,
    this.returnDateTime,
    required this.reason,
    required this.needs,
    required this.dateTour,
    required this.timeDateTour,
    required this.startLat,
    required this.endLat,
    required this.startLong,
    required this.endLong,
    required this.startAddress,
    required this.endAddress,
    required this.address,
    required this.notes,
    required this.fees,
    required this.cost,
    required this.distanceTime,
    required this.distanceKilo,
    required this.status,
    required this.slug,
    required this.changeTime,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  factory Trip.fromJson(Map<String, dynamic> json) {
    return Trip(
      id: json['id'],
      userId: json['user_id'],
      driverId: json['driver_id'],
      carId: json['car_id'],
      countryId: json['country_id'],
      stateId: json['state_id'],
      surveyId: json['survey_id'],
      fullname: json['fullname'],
      phone: json['phone'],
      typeTour: json['type_tour'],
      returnOption: json['return_option'],
      returnDateTime: json['return_date_time'] != null
          ? _parseDateTime(json['return_date_time'])
          : null,
      reason: json['reason'],
      needs: json['needs'],
      dateTour: json['date_tour'],
      timeDateTour: json['time_date_tour'],
      startLat: json['start_lat'],
      endLat: json['end_lat'],
      startLong: json['start_long'],
      endLong: json['end_long'],
      startAddress: json['start_address'],
      endAddress: json['end_address'],
      address: json['address']??'',
      notes: json['notes'],
      fees: json['fees'],
      cost: json['cost'],
      distanceTime: json['distance_time'],
      distanceKilo: json['distance_kilo'],
      status: json['status'],
      slug: json['slug'],
      changeTime: json['change_time'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      deletedAt: json['deleted_at'] != null
          ? DateTime.parse(json['deleted_at'])
          : null,
    );
  }
}
DateTime? _parseDateTime(String? dateString) {
  try {
    if (dateString != null) {
      return DateTime.parse(dateString);
    }
  } catch (e) {
    // Handle the invalid date format gracefully, e.g., log the error or return a default value.
    print('Error parsing date: $dateString');
  }
  return null; // Return null or a default DateTime in case of an error.
}