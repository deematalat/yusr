class User {
  final int id;
  final String name;
  final String phone;
  final String email;
  final String? googleId;
  final String deviceToken;
  final String vip;
  final String block;
  final String membership;


  User(  {

    required this.id,
    required this.name,
    required this.phone,
    required this.email,
    this.googleId,
    required this.deviceToken,
    required this.vip,
    required this.block,
    required this.membership,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      name: json['name'] as String,
      phone: json['phone'] as String,
      email: json['email'] ?? '',
      googleId: json['google_id'] != null ? json['google_id'] ??"" : null,
      deviceToken: json['device_token'] ??"",
      vip: json['vip'] ??"",
      block: json['block']??"",
      membership: json['membership'] ??"",
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

