import 'package:flutter/material.dart';
import 'package:gateway/config/themes/gateway_color.dart';
import 'package:gateway/widgets/common/card_setup.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({Key? key}) : super(key: key);

  @override
  _ScanScreenState createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Text(
            'Scaning',
            style: TextStyle(
              color: GatewayColors.textDefaultBgLight,
              fontSize: 15,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        CardSetup(
          contentCard: Center(
            child: Text(
              'Now press the scan button to find the device',
              style: TextStyle(
                color: GatewayColors.textDefaultBgLight,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        SizedBox(height: 40),
        Container(
          height: 45,
          width: 300,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            color: GatewayColors.buttonBgLight,
          ),
          child: Center(
            child: Row(
              children: [
                Icon(
                  Icons.flip,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 10,
                ),
                Text('Scan')
              ],
            ),
          ),
        )
      ],
    );
  }
}
