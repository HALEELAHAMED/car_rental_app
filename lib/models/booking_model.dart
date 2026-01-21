import 'car_model.dart';

class Booking {
  final Car car;
  final String userName;
  final String location;
  final DateTime startDate;
  final DateTime endDate;

  Booking({
    required this.car,
    required this.userName,
    required this.location,
    required this.startDate,
    required this.endDate,
  });
}
