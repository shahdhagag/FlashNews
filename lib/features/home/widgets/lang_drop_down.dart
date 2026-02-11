import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';



class LanguageDropDown extends StatelessWidget {
  const LanguageDropDown({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white54),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: DropdownButton<Locale>(
        dropdownColor: const Color(0xFF171717),
        value: context.locale,
        isExpanded: true,
        underline: const SizedBox(),
        style: TextStyle(color: Colors.white, fontSize: 16.sp),
        items: const [
          DropdownMenuItem(
            value: Locale('en', 'US'),
            child: Text('English'),
          ),
          DropdownMenuItem(
            value: Locale('ar', 'EG'),
            child: Text('العربية'),
          ),
        ],
        onChanged: (Locale? newLocale) {
          if (newLocale != null) {
            context.setLocale(newLocale);
          }
        },
      ),
    );
  }
}
