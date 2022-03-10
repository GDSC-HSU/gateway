import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gateway/config/themes/gateway_color.dart';
import 'package:gateway/model/language.dart';

class BuildAppBar extends StatelessWidget implements PreferredSizeWidget {
  const BuildAppBar({
    Key? key,
    required this.languageModel,
    required this.title,
  }) : super(key: key);

  final LanguageModel languageModel;
  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      shadowColor: Colors.transparent,
      elevation: 0.0,
      backgroundColor: GatewayColors.scaffoldBgLight,
      title: Padding(
        padding: EdgeInsets.only(left: 103.w),
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      actions: [
        PopupMenuButton<TypeLanguage>(
          child: Row(
            children: [
              Image.asset(
                languageModel.imagePath,
                width: 33.h,
                height: 20.h,
                fit: BoxFit.cover,
              ),
              SizedBox(width: 5.h),
              Text(
                languageModel.shortName,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500),
              ),
              Icon(
                Icons.arrow_drop_down,
                color: Colors.black,
              ),
              SizedBox(width: 5.h),
            ],
          ),
          onSelected: (value) async {
            if (value == TypeLanguage.en) {
              await context.setLocale(const Locale('en'));
            } else if (value == TypeLanguage.vi) {
              await context.setLocale(const Locale('vi'));
            }
          },
          itemBuilder: (context) => [
            PopupMenuItem(
              value: TypeLanguage.en,
              child: Row(
                children: [
                  Image.asset(
                    'assets/images/en_flag.png',
                    width: 36.h,
                    height: 23.h,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(width: 16.h),
                  Text(
                    'English',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
            PopupMenuItem(
              value: TypeLanguage.vi,
              child: Row(
                children: [
                  Image.asset(
                    'assets/images/vn_flag.png',
                    width: 36.h,
                    height: 23.h,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(width: 16.h),
                  Text(
                    'Vietnamese',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(42.h);
}
