import 'package:flutter/material.dart';
import 'package:gateway/config/themes/gateway_color.dart';

class CardSetup extends StatelessWidget {
  const CardSetup({Key? key, required this.contentCard}) : super(key: key);
  final Widget contentCard;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      //padding: const EdgeInsets.only(left: 24, top: 3, bottom: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        // border: Border.all(
        //     color: ColorAndTextStyleMode().disableButtonBackground),
        borderRadius: BorderRadius.circular(10.0),
        gradient: LinearGradient(stops: [
          0.013,
          0.013
        ], colors: [
          GatewayColors.buttonBgLight,
          Colors.white,
        ]),
      ),
      height: 340,
      child: contentCard,
    );
  }
}
