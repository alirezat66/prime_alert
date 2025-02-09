import 'dart:convert';

class TimedNumber {
  final int number;
  final DateTime responseDate;

  TimedNumber({
    required this.number,
    required this.responseDate,
  });

  factory TimedNumber.fromJson(Map<String, dynamic> json) {
    return TimedNumber(
      number: json['number'],
      responseDate: DateTime.parse(json['responseDate']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'number': number,
      'responseDate': responseDate.toIso8601String(),
      'type': 'found',
    };
  }

  factory TimedNumber.fromStringJson(String jsonString) {
    final Map<String, dynamic> json = jsonDecode(jsonString);
    return TimedNumber(
      number: json['number'],
      responseDate: DateTime.parse(json['responseDate']),
    );
  }

  String toStringJson() {
    final Map<String, dynamic> json = {
      'number': number,
      'responseDate': responseDate.toIso8601String(),
    };
    return jsonEncode(json);
  }
}
