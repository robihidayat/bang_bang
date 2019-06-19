
class Response {
  final String status;
  final String message;

  Response({this.status, this.message});

  factory Response.fromJson(Map<String, dynamic> json) {
    return Response(
      status: json['status'],
      message: json['message'],
    );
  }
}