import 'package:car_rental_application/screens/booking_form_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:car_rental_application/core/constants/app_colors.dart';
import 'package:car_rental_application/models/car_model.dart';
import 'package:car_rental_application/widgets/custom_text.dart';

class CarDetailScreen extends StatelessWidget {
  final Car car;

  const CarDetailScreen({super.key, required this.car});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Stack(
            children: [
              Image.asset(
                car.image,
                width: double.infinity,
                height: 260.h,
                fit: BoxFit.cover,
              ),

              Positioned(
                top: 40.h,
                left: 16.w,
                child: _circleIcon(
                  icon: Icons.arrow_back,
                  onTap: () => Navigator.pop(context),
                ),
              ),

              Positioned(
                top: 40.h,
                right: 16.w,
                child: _circleIcon(icon: Icons.share, onTap: () {}),
              ),
            ],
          ),

          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// TITLE + PRICE
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: CustomText(
                          text: car.name,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      CustomText(
                        text: "₹${car.pricePerDay}/day",
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryBlue,
                      ),
                    ],
                  ),

                  SizedBox(height: 8.h),

                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 16),
                      SizedBox(width: 4.w),
                      const Text(
                        "4.5 (120 Reviews)",
                        style: TextStyle(fontSize: 13),
                      ),
                      SizedBox(width: 10.w),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.w,
                          vertical: 4.h,
                        ),
                        decoration: BoxDecoration(
                          color: car.available
                              ? Colors.green.withOpacity(0.1)
                              : Colors.red.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                        child: Text(
                          car.available ? "Available" : "Not Available",
                          style: TextStyle(
                            fontSize: 12,
                            color: car.available ? Colors.green : Colors.red,
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 20.h),

                  _sectionTitle("Car Information"),
                  _infoRow("Fuel", car.fuelType),
                  _infoRow("Transmission", car.transmission),
                  _infoRow("Seats", car.seats.toString()),
                  _infoRow("Top Speed", "${car.maxSpeed} km/h"),

                  SizedBox(height: 20.h),

                  _sectionTitle("Rental Details"),
                  _infoRow("Pickup Location", "City Center"),
                  _infoRow("Minimum Rental", "1 Day"),
                  _infoRow("Insurance", "Included"),

                  SizedBox(height: 30.h),
                ],
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.all(16.w),
            child: SizedBox(
              width: double.infinity,
              height: 48.h,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryBlue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => BookingFormScreen(car: car),
                    ),
                  );
                },
                child: const Text(
                  "Book Now",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _circleIcon({required IconData icon, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(8.w),
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 6),
          ],
        ),
        child: Icon(icon, size: 20),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: CustomText(text: title, fontSize: 16, fontWeight: FontWeight.w600),
    );
  }

  Widget _infoRow(String title, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        children: [
          Expanded(
            child: Text(title, style: const TextStyle(color: Colors.grey)),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}
