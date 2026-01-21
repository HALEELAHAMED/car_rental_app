import 'package:car_rental_application/models/booking_model.dart';
import 'package:car_rental_application/models/car_model.dart';
import 'package:flutter/material.dart';

class BookingProvider with ChangeNotifier {
  Booking? currentBooking;

  void createBooking({
    required Car car,
    required String userName,
    required String location,
    required DateTime startDate,
    required DateTime endDate,
  }) {
    currentBooking = Booking(
      car: car,
      userName: userName,
      location: location,
      startDate: startDate,
      endDate: endDate,
    );
    notifyListeners();
  }
}
