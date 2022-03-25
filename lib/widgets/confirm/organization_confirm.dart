import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gateway/config/themes/gateway_color.dart';
import 'package:gateway/generated/locale_keys.g.dart';
import 'package:gateway/model/organization_info.dart';
import 'package:shimmer/shimmer.dart';

class OrganizationConfirm extends StatefulWidget {
  const OrganizationConfirm({
    Key? key,
    required this.organizationInfo,
    required this.callBack,
  }) : super(key: key);
  final Function callBack;
  final OrganizationInfo organizationInfo;

  @override
  State<OrganizationConfirm> createState() => _OrganizationConfirmState();
}

class _OrganizationConfirmState extends State<OrganizationConfirm> {
  bool thisOrganization = true;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 277.w,
          height: 138.h,
          child: CachedNetworkImage(
            imageUrl: widget.organizationInfo.imageUrl.toString(),
            fit: BoxFit.cover,
            placeholder: (context, url) {
              return Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  width: 277.w,
                  height: 138.h,
                ),
              );
            },
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
                    LocaleKeys.name.tr(),
                    style: TextStyle(
                      color: GatewayColors.textDefaultBgLight,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    widget.organizationInfo.name.toString(),
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
                    LocaleKeys.organization_id.tr(),
                    style: TextStyle(
                      color: GatewayColors.textDefaultBgLight,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    widget.organizationInfo.oid.toString(),
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24.h),
              thisOrganization
                  ? Align(
                      alignment: Alignment.bottomRight,
                      child: InkWell(
                        onTap: () {
                          widget.callBack();
                          setState(() {
                            thisOrganization = !thisOrganization;
                          });
                        },
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
                              LocaleKeys.this_is_my_organization.tr(),
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
      ],
    );
  }
}
