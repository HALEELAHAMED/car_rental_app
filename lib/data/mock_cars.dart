import 'package:car_rental_application/models/car_model.dart';

final List<Car> mockCars = [
  Car(
    name: 'Toyota Corolla',
    image: 'assets/images/toyota.jpg',
    pricePerDay: 2500,
    available: true,
    transmission: 'Automatic',
    fuelType: 'Petrol',
    seats: 5,
    maxSpeed: 180,
  ),
  Car(
    name: 'BMW',
    image: 'assets/images/bmw.jpg',
    pricePerDay: 3000,
    available: true,
    transmission: 'Automatic',
    fuelType: 'Diesel',
    seats: 5,
    maxSpeed: 220,
  ),
  Car(
    name: 'Vintage Benz',
    image: 'assets/images/benz.jpg',
    pricePerDay: 3000,
    available: true,
    transmission: 'Manual',
    fuelType: 'Petrol',
    seats: 5,
    maxSpeed: 120,
  ),
];
