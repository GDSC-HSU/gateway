// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:gateway/blocs/ble_sensor_controller/bloc/gateway_controller_bloc.dart';
// import 'package:gateway/di/di_ble_sensor.dart';

// class HexoStateTest extends StatefulWidget {
//   const HexoStateTest({Key? key}) : super(key: key);

//   @override
//   _HexoStateTestState createState() => _HexoStateTestState();
// }

// class _HexoStateTestState extends State<HexoStateTest> {
//   @override
//   Widget build(BuildContext context) {
//     return AppBLESensorDependencyProvider(
//       child: Container(
//         child: Column(
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Builder(builder: (context) {
//                   return TextButton(
//                       child: Text("Validate hexo state"),
//                       onPressed: () => {
//                             // context
//                             //     .read<GatewayControllerBloc>()
//                             //     .hexoStateProcessing
//                             //     .processState()
//                           });
//                 }),
//                 Builder(builder: (context) {
//                   return TextButton(
//                       child: Text("Hexo resest"),
//                       onPressed: () => {
//                             context
//                                 .read<GatewayControllerBloc>()
//                                 .add(BleSensorControllerResetEvent())
//                           });
//                 }),
//               ],
//             ),
//             Builder(builder: (context) {
//               return BlocBuilder<GatewayControllerBloc, GatewayControllerState>(
//                   builder: (builder, state) {
//                 if (state is BleSensorControllerValidState) {
//                   print(state.hexoState.listOfSensorState
//                       .map((e) => e.sensor.data.toString()));
//                 }
//                 return Container();
//               });
//             })
//           ],
//         ),
//       ),
//     );
//   }
// }
