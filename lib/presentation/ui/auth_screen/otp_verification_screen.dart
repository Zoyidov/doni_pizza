// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:pizza/business_logic/bloc/auth/otp_verification_bloc.dart';
// import 'package:pizza/business_logic/bloc/auth/registration_bloc.dart';
// import 'package:pizza/presentation/ui/home_screen/home_screen.dart';
// import 'package:pizza/presentation/ui/tab_box/tab_box.dart';
// import 'package:pinput/pinput.dart';
//
// class OTPVerificationScreen extends StatelessWidget {
//   final TextEditingController _pinPutController = TextEditingController();
//   final FocusNode _pinPutFocusNode = FocusNode();
//
//   OTPVerificationScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('OTP Verification'),
//       ),
//       body: BlocListener<OTPVerificationBloc, OTPVerificationState>(
//         listener: (context, state) {
//           if (state is OTPVerificationSuccess) {
//             // Navigate to the next screen after successful OTP verification
//             Navigator.pushReplacement(
//                 context, MaterialPageRoute(builder: (context) => const TabBox()));
//           } else if (state is OTPVerificationFailure) {
//             // Display an error message to the user
//             ScaffoldMessenger.of(context)
//               ..hideCurrentSnackBar()
//               ..showSnackBar(
//                 SnackBar(
//                   content: Text(state.error),
//                   duration: const Duration(seconds: 5),
//                 ),
//               );
//           }
//         },
//         child: _buildOTPForm(context),
//       ),
//     );
//   }
//
//   Widget _buildOTPForm(BuildContext context) {
//     final otpVerificationBloc = context.read<OTPVerificationBloc>();
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: <Widget>[
//           Pinput(
//             length: 6,
//             onSubmitted: (String pin) {
//               if (context.read<RegistrationBloc>().state is RegistrationCodeSent) {
//                 final RegistrationCodeSent state =
//                     context.read<RegistrationBloc>().state as RegistrationCodeSent;
//                 otpVerificationBloc.add(VerifyOTPEvent(
//                     otpCode: pin,
//                     verificationId: state.verificationId)); // Dispatch the VerifyOTPEvent
//               } else {
//                 print('Invalid state: ${context.read<RegistrationBloc>().state}');
//               }
//             },
//             focusNode: _pinPutFocusNode,
//             controller: _pinPutController,
//           ),
//           ElevatedButton(onPressed: () {}, child: const Text("Verify OTP")),
//           // Add a Verify OTP button that triggers the OTP verification event
//         ],
//       ),
//     );
//   }
//
// // _buildLoading and _buildError widgets are similar to those in the LoginScreen
// }
