import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/cubits/theme_cubit.dart';

class ThemeDropDown extends StatelessWidget {
  const ThemeDropDown({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white54),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeState) {
          return DropdownButton<ThemeMode>(
            dropdownColor: const Color(0xFF171717),
            value: themeState,
            iconSize: 35.sp,
            iconEnabledColor: Colors.white,
            isExpanded: true,
            underline: const SizedBox(),
            style: TextStyle(color: Colors.white, fontSize: 16.sp),
            items: [
              DropdownMenuItem(
                value: ThemeMode.light,
                child: Text(
                  'light'.tr(),
                  style: TextStyle(color: Colors.white, fontSize: 16.sp),
                ),
              ),
              DropdownMenuItem(
                value: ThemeMode.dark,
                child: Text(
                  'dark'.tr(),
                  style: TextStyle(color: Colors.white, fontSize: 16.sp),
                ),
              ),
            ],
            onChanged: (ThemeMode? newMode) {
              if (newMode != null) {
                context.read<ThemeCubit>().setTheme(newMode);
              }
            },
          );
        },
      ),
    );
  }
}
