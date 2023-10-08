



class CustomNotification   {
  final String title;
  final String message;


  CustomNotification({
    required this.title,
    required this.message,
  });
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'message': message,
    };
  }

  static CustomNotification fromJson(Map<String, dynamic> json) {
    return CustomNotification(
      title: json['title'],
      message: json['message'],
    );
  }

}
