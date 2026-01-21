import 'package:car_rental_application/core/constants/app_colors.dart';
import 'package:car_rental_application/providers/booking_provider.dart';
import 'package:car_rental_application/widgets/custom_button.dart';
import 'package:car_rental_application/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class BookingConfirmationScreen extends StatelessWidget {
  const BookingConfirmationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final booking = context.watch<BookingProvider>().currentBooking;

    if (booking == null) {
      return const Scaffold(body: Center(child: Text("No booking found")));
    }

    return Scaffold(
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: CustomButton(
          text: 'Done',
          onPressed: () {
            Navigator.popUntil(context, (route) => route.isFirst);
          },
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 80.w,
                  height: 80.w,
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check_circle,
                    size: 60,
                    color: Colors.green,
                  ),
                ),
              ),

              SizedBox(height: 16.h),

              /// SUCCESS TEXT
              Center(
                child: CustomText(
                  text: "Booking Confirmed!",
                  fontSize: 28,
                  fontWeight: FontWeight.w600,
                  color: AppColors.black,
                ),
              ),

              SizedBox(height: 6.h),

              Center(
                child: CustomText(
                  text: "Your car has been booked successfully",
                  fontSize: 14,
                  color: AppColors.textGrey,
                ),
              ),

              SizedBox(height: 30.h),

              /// SUMMARY CARD
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Column(
                  children: [
                    _buildDetailRow(
                      icon: Icons.directions_car_rounded,
                      label: "Vehicle",
                      value: booking.car.name,
                    ),

                    _buildDetailRow(
                      icon: Icons.person_outline_rounded,
                      label: "Name",
                      value: booking.userName,
                    ),

                    _buildDetailRow(
                      icon: Icons.location_on_outlined,
                      label: "Pickup",
                      value: booking.location,
                    ),

                    _buildDetailRow(
                      icon: Icons.calendar_today_rounded,
                      label: "Duration",
                      value:
                          "${_formatDate(booking.startDate)} - ${_formatDate(booking.endDate)}",
                    ),

                    _buildDetailRow(
                      icon: Icons.payments_outlined,
                      label: "Price per day",
                      value: "₹${booking.car.pricePerDay}",
                      isPrice: true,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return "${date.day}/${date.month}/${date.year}";
  }

  Widget _buildDetailRow({
    required IconData icon,
    required String label,
    required String value,
    bool isPrice = false,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: AppColors.primaryBlue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(icon, size: 20.sp, color: AppColors.primaryBlue),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(fontSize: 12.sp, color: Colors.grey[600]),
                ),
                SizedBox(height: 2.h),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: isPrice ? FontWeight.bold : FontWeight.w600,
                    color: isPrice ? AppColors.primaryBlue : Colors.grey[900],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
