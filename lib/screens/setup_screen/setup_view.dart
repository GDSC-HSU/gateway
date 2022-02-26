import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gateway/config/themes/gateway_color.dart';
import 'package:gateway/widgets/confirm/confirm_screen.dart';
import 'package:gateway/widgets/connect/connect_screen.dart';
import 'package:gateway/widgets/scan/scan_screen.dart';

class SetupView extends StatefulWidget {
  SetupView({Key? key}) : super(key: key);

  @override
  _SetupViewState createState() => _SetupViewState();
}

class _SetupViewState extends State<SetupView> {
  late PageController _pageController;

  final _duration = const Duration(milliseconds: 500);
  final _curve = Curves.ease;
  int _currentPage = 0;
  List<Widget> _buildListScreen() {
    return [ScanScreen(), ConnectScreen(), ConfirmScreen()];
  }

  @override
  void didChangeDependencies() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      if (_pageController.hasClients) _pageController.jumpToPage(_currentPage);
    });
    super.didChangeDependencies();
  }

  @override
  void initState() {
    _pageController = PageController();

    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          //margin: EdgeInsets.only(top: 8 + MediaQuery.of(context).padding.top),
          //padding: EdgeInsets.only(top: 20.h, bottom: 0.h),
          height: 44.h,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 14.h,
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(left: 12.h, right: 20.h),
                  child: Stack(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.symmetric(horizontal: 12.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            for (var i = 0;
                                i < _buildListScreen().length - 1;
                                i++)
                              Flexible(
                                child: Container(
                                  height: 2.h,
                                  decoration: BoxDecoration(
                                    color: i <= _currentPage - 1
                                        ? GatewayColors.buttonBgLight
                                        : GatewayColors.textDefaultBgLight,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            for (var i = 0; i < _buildListScreen().length; i++)
                              InkWell(
                                onTap: () {
                                  _onClickSelectPage(i);
                                },
                                child: Container(
                                  height: 16.h,
                                  width: 16.h,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: i <= _currentPage
                                        ? GatewayColors.buttonBgLight
                                        : GatewayColors.textDefaultBgLight,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            for (var i = 0; i < _buildListScreen().length; i++)
                              InkWell(
                                onTap: () {
                                  _onClickSelectPage(i);
                                },
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    left: i == 0 ? 5.h : 0.h,
                                    right: i == 1 ? 5.h : 5.h,
                                  ),
                                  child: Text(
                                    (i + 1).toString(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 16.h),
                child: Text(
                  '${_currentPage + 1}' + '/${_buildListScreen().length}',
                  style: Theme.of(context).textTheme.headline3?.copyWith(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w500,
                        color: GatewayColors.textDefaultBgLight,
                      ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: PageView(
            controller: _pageController,
            physics: NeverScrollableScrollPhysics(),
            onPageChanged: _onPageViewChange,
            children: _buildListScreen(),
          ),
        ),
      ],
    );
  }

  _onPageViewChange(int pageIndex) {
    print("Current Page: " + pageIndex.toString());
    _currentPage = pageIndex;
  }

  _onClickSelectPage(int i) {
    if (i == 0) {
      if (_currentPage == 1) {
        _pageController.previousPage(duration: _duration, curve: _curve);
      } else if (_currentPage == 2) {
        _pageController.jumpToPage(0);
      }
      setState(() {
        _currentPage = 0;
      });
    } else if (i == 2) {
      if (_currentPage == 0) {
        _pageController.jumpToPage(2);
      } else if (_currentPage == 1) {
        _pageController.nextPage(duration: _duration, curve: _curve);
      }
      setState(() {
        _currentPage = 2;
      });
    } else if (i == 1) {
      if (_currentPage == 0) {
        _pageController.nextPage(duration: _duration, curve: _curve);
      } else if (_currentPage == 2) {
        _pageController.previousPage(duration: _duration, curve: _curve);
      }
      setState(() {
        _currentPage = 1;
      });
    }
  }
}
