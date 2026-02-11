import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/cubits/theme_cubit.dart';

class MainErrorWidget extends StatelessWidget {
  const MainErrorWidget({
    super.key,
    required this.errorMsg,
    required this.onTryAgain,
  });

  final String errorMsg;
  final VoidCallback onTryAgain;

  @override
  Widget build(BuildContext context) {
    bool isDark = context.watch<ThemeCubit>().isDarkMode();

    bool isNetworkError = errorMsg.toLowerCase().contains('network') ||
        errorMsg.toLowerCase().contains('connection');

    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 40.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(20.r),
              decoration: BoxDecoration(
                color: isNetworkError
                    ? Colors.blue.withOpacity(0.1)
                    : Colors.red.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                isNetworkError ? Icons.wifi_off_rounded : Icons.error_outline_rounded,
                color: isNetworkError ? Colors.blue : Colors.redAccent,
                size: 60.sp,
              ),
            ),
            Gap(24.h),

            Text(
              isNetworkError ? "Connection Error".tr() : "Something went wrong".tr(),
              style: GoogleFonts.inter(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
            Gap(12.h),

            Text(
              errorMsg,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 14.sp,
                color: isDark ? Colors.white : Colors.black54,
                height: 1.5,
              ),
            ),
            Gap(32.h),

            Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: (isDark ? Colors.white : Colors.black).withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(200.w, 50.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.r),
                  ),
                  backgroundColor: isDark ? Colors.white : Colors.black,
                  foregroundColor: isDark ? Colors.black : Colors.white,
                  elevation: 0,
                ),
                onPressed: onTryAgain,
                child: Text(
                  "Try Again".tr(),
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}