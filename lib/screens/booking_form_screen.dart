import 'package:car_rental_application/screens/booking_conformation_screen.dart';
import 'package:car_rental_application/widgets/custom_button.dart';
import 'package:car_rental_application/widgets/custom_date_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../models/car_model.dart';
import '../providers/booking_provider.dart';
import '../widgets/custom_text.dart';
import '../widgets/custom_textfield.dart';
import '../core/constants/app_colors.dart';

class BookingFormScreen extends StatefulWidget {
  final Car car;

  const BookingFormScreen({super.key, required this.car});

  @override
  State<BookingFormScreen> createState() => _BookingFormScreenState();
}

class _BookingFormScreenState extends State<BookingFormScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController locationController = TextEditingController();

  DateTime? startDate;
  DateTime? endDate;
  bool _submitted = false;

  /// DATE PICKER
  Future<void> _pickDate({required bool isStart}) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (pickedDate != null) {
      setState(() {
        if (isStart) {
          startDate = pickedDate;
        } else {
          endDate = pickedDate;
        }
      });
    }
  }

  bool get isFormValid {
    return startDate != null && endDate != null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: CustomButton(
          text: 'Confirm Booking',
          onPressed: () {
            setState(() {
              _submitted = true;
            });

            if (_formKey.currentState!.validate() && isFormValid) {
              _confirmBooking();
            }
          },
        ),
      ),
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Booking Form",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        backgroundColor: AppColors.primaryBlue,
        elevation: 0,
        foregroundColor: Colors.white,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _summaryCard(),

              SizedBox(height: 24.h),

              // NAME FIELD
              _label("Full Name"),
              CustomTextfield(
                controller: nameController,
                hintText: "Enter your full name",
                textInputAction: TextInputAction.next,
              ),

              SizedBox(height: 16.h),

              _label("Pickup Location"),
              CustomTextfield(
                controller: locationController,
                hintText: "Enter pickup location",
                textInputAction: TextInputAction.done,
              ),

              SizedBox(height: 16.h),

              // START DATE
              CustomDateField(
                label: "Start Date",
                value: startDate == null
                    ? "Select start date"
                    : _formatDate(startDate!),
                onTap: () => _pickDate(isStart: true),
                hasError: startDate == null,
              ),

              SizedBox(height: 16.h),

              // END DATE
              CustomDateField(
                label: "End Date",
                value: endDate == null
                    ? "Select end date"
                    : _formatDate(endDate!),
                onTap: () => _pickDate(isStart: false),
                hasError: endDate == null,
              ),

              SizedBox(height: 16.h),

              SizedBox(height: 30.h),
            ],
          ),
        ),
      ),
    );
  }

  void _confirmBooking() {
    Provider.of<BookingProvider>(context, listen: false).createBooking(
      car: widget.car,
      userName: nameController.text,
      location: locationController.text,
      startDate: startDate!,
      endDate: endDate!,
    );

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const BookingConfirmationScreen()),
    );
  }

  Widget _summaryCard() {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: Image.asset(
              widget.car.image,
              width: 80.w,
              height: 60.h,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: widget.car.name,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
                SizedBox(height: 4.h),
                CustomText(
                  text: "₹${widget.car.pricePerDay}/day",
                  color: AppColors.primaryBlue,
                  fontSize: 13,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _label(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 6.h),
      child: CustomText(text: text, fontSize: 14, fontWeight: FontWeight.w500),
    );
  }

  String _formatDate(DateTime date) {
    return "${date.day}/${date.month}/${date.year}";
  }
}
