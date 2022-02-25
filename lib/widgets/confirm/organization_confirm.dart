import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gateway/config/themes/gateway_color.dart';

class OrganizationConfirm extends StatelessWidget {
  const OrganizationConfirm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 277.w,
          height: 138.h,
          child: Image.asset(
            'assets/images/hoasen.png',
            fit: BoxFit.cover,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.h, vertical: 16.h),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Name',
                    style: TextStyle(
                      color: GatewayColors.textDefaultBgLight,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    'Hoa Sen university',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 18.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Organization ID',
                    style: TextStyle(
                      color: GatewayColors.textDefaultBgLight,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    'HSU',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24.h),
              Align(
                alignment: Alignment.bottomRight,
                child: InkWell(
                  onTap: () {},
                  child: Container(
                    width: 186.w,
                    height: 36.h,
                    decoration: BoxDecoration(
                      color: GatewayColors.bgButtonColorHaveBorder,
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(
                        color: GatewayColors.buttonBgLight,
                        width: 1.h,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'This is my organization',
                        style: TextStyle(
                          color: GatewayColors.buttonBgLight,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          //  Row(
          //   //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   //crossAxisAlignment: CrossAxisAlignment.center,
          //   children: [
          //     Column(
          //       crossAxisAlignment: CrossAxisAlignment.start,
          //       mainAxisAlignment: MainAxisAlignment.start,
          //       children: [
          //         Text(
          //           'Name',
          //           style: TextStyle(
          //             color: GatewayColors.textDefaultBgLight,
          //             fontSize: 13.sp,
          //             fontWeight: FontWeight.w700,
          //           ),
          //         ),
          //         SizedBox(height: 14.h),
          //         Text(
          //           'Version',
          //           style: TextStyle(
          //             color: GatewayColors.textDefaultBgLight,
          //             fontSize: 13.sp,
          //             fontWeight: FontWeight.w700,
          //           ),
          //         ),
          //       ],
          //     ),
          //     Column(
          //       children: [
          //         Text(
          //           'Name',
          //           style: TextStyle(
          //             color: GatewayColors.textDefaultBgLight,
          //             fontSize: 13.sp,
          //             fontWeight: FontWeight.w700,
          //           ),
          //         ),
          //         SizedBox(height: 14.h),
          //         Text(
          //           'Version',
          //           style: TextStyle(
          //             color: GatewayColors.textDefaultBgLight,
          //             fontSize: 13.sp,
          //             fontWeight: FontWeight.w700,
          //           ),
          //         ),
          //         Text(
          //           'Version',
          //           style: TextStyle(
          //             color: GatewayColors.textDefaultBgLight,
          //             fontSize: 13.sp,
          //             fontWeight: FontWeight.w700,
          //           ),
          //         ),
          //       ],
          //     ),
          //     // Column(
          //     //   crossAxisAlignment: CrossAxisAlignment.end,
          //     //   mainAxisAlignment: MainAxisAlignment.start,
          //     //   children: [
          //     //     Text(
          //     //       'Hoa Sen university',
          //     //       style: TextStyle(
          //     //         color: Colors.black,
          //     //         fontSize: 14.sp,
          //     //         fontWeight: FontWeight.w700,
          //     //       ),
          //     //     ),
          //     //     SizedBox(height: 14.h),
          //     //     Text(
          //     //       'HSU',
          //     //       style: TextStyle(
          //     //         color: Colors.black,
          //     //         fontSize: 14.sp,
          //     //         fontWeight: FontWeight.w700,
          //     //       ),
          //     //     ),
          //     //     SizedBox(height: 14.h),
          //     //     Container(
          //     //       width: 186.w,
          //     //       height: 36.h,
          //     //       decoration: BoxDecoration(
          //     //         color: GatewayColors.bgButtonColorHaveBorder,
          //     //         borderRadius: BorderRadius.circular(6.r),
          //     //         border: Border.all(
          //     //           color: GatewayColors.buttonBgLight,
          //     //           width: 1.h,
          //     //         ),
          //     //       ),
          //     //     ),
          //     //   ],
          //     // ),
          //   ],
          // ),
        ),
      ],
    );
  }
}
