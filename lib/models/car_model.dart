class Car {
  final String name;
  final String image;
  final double pricePerDay;
  final bool available;

  // Structured data
  final String transmission; // Automatic / Manual
  final String fuelType;     // Petrol / Diesel
  final int seats;
  final int maxSpeed;        // km/h

  Car({
    required this.name,
    required this.image,
    required this.pricePerDay,
    required this.available,
    required this.transmission,
    required this.fuelType,
    required this.seats,
    required this.maxSpeed,
  });

  /// UI-friendly computed property
  String get specs =>
      '$transmission • $fuelType • $seats Seats';
}
