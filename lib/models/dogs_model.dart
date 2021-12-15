class Dogs {
  Dogs({
    required this.message,
    required this.status,
  });

  final String message;
  final String status;

  factory Dogs.fromJson(dynamic json) {
    return Dogs(
      message: json['message'],
      status: json['status'],
    );
  }

  @override
  String toString() {
    return 'image: $message, status: $status';
  }
}
