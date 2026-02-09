import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:newsapp/core/utiles/app_assets.dart';
import 'package:newsapp/core/utiles/app_colors.dart';
import '../../../core/cubits/theme_cubit.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: const Color(0xFF171717), // Dark background
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            // Drawer Header
            DrawerHeader(
              decoration: const BoxDecoration(color: AppColors.whiteColor),
              child: Center(
                child: Text(
                  'news_app'.tr(),
                  style: TextStyle(
                    color: AppColors.black,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            // Go To Home
            ListTile(
              leading: ImageIcon(
                const AssetImage(AppAssets.homeIcon),
                color: AppColors.whiteColor,
              ),
              title: Text('go_home'.tr(),
                  style: TextStyle(color: Colors.white, fontSize: 16.sp)),
              onTap: () {
                Navigator.pop(context);
              },
            ),

            Divider(
              color: Colors.white54,
              endIndent: 16.w,
              indent: 16.w,
              thickness: 1,
            ),

            // Theme Section
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              child: Row(
                children: [
                  ImageIcon(
                    const AssetImage(AppAssets.themeIcon),
                    color: AppColors.whiteColor,
                  ),
                  Gap(8.w),
                  Text('theme'.tr(),
                      style: TextStyle(color: Colors.white, fontSize: 16.sp)),
                ],
              ),
            ),
            Container(
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
                        child: Text('light'.tr(),
                            style:
                            TextStyle(color: Colors.white, fontSize: 16.sp)),
                      ),
                      DropdownMenuItem(
                        value: ThemeMode.dark,
                        child: Text('dark'.tr(),
                            style:
                            TextStyle(color: Colors.white, fontSize: 16.sp)),
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
            ),

            SizedBox(height: 16.h),
            Divider(
              color: Colors.white54,
              endIndent: 16.w,
              indent: 16.w,
              thickness: 1,
            ),

            // Language Section
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              child: Row(
                children: [
                  ImageIcon(
                    const AssetImage(AppAssets.languageIcon),
                    color: AppColors.whiteColor,
                  ),
                  Gap(8.w),
                  Text('language'.tr(),
                      style: TextStyle(color: Colors.white, fontSize: 16.sp)),
                ],
              ),
            ),
            Container(
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
                    context.setLocale(newLocale); // triggers .tr()
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
