// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:paisa/config/themes/app_themes.dart';
// import 'package:paisa/feathures/auth/presentation/state/login_state.dart';
// import 'package:paisa/feathures/auth/presentation/widget/email_password_sign_in_validators.dart';
// import 'package:paisa/feathures/auth/presentation/widget/string_validators.dart';

// class AuthTextFormFields extends ConsumerWidget
//     with EmailAndPasswordValidators {
//   final TextEditingController controller;
//   final bool obscureText;
//   final String hintText;
//   final TextInputType keyboardType;
//   final TextInputAction textInputAction;
//   final FocusScopeNode node;
//   final void Function() onEditingComplete;
//   final String? Function(String?) validator;

//   const AuthTextFormFields({
//     super.key,
//     required this.controller,
//     required this.obscureText,
//     required this.hintText,
//     required this.keyboardType,
//     required this.textInputAction,
//     required this.node,
//     required this.onEditingComplete,
//     required this.validator,
//   });

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final authState = ref.watch(authStateProvider);
//     // final value = ref.watch(someProvider);
//     // final another = ref.watch(anotherProvider);

//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: TextFormField(
//         controller: controller,
//         obscureText: obscureText,
//         keyboardType: keyboardType,
//         textInputAction: textInputAction,
//         keyboardAppearance: Brightness.light,
//         onEditingComplete: onEditingComplete,
//         autocorrect: false,
//         validator: validator,
//         inputFormatters: <TextInputFormatter>[
//           ValidatorInputFormatter(
//               editingValidator: EmailEditingRegexValidator()),
//         ],
//         decoration: InputDecoration(
//           icon: const Icon(
//             Icons.alternate_email_outlined,
//             color: AppColors.primaryColor,
//           ),
//           hintText: hintText,
//           hintStyle: GoogleFonts.poppins(
//             fontSize: 14.0,
//             fontWeight: FontWeight.w400,
//           ),
//           contentPadding:
//               const EdgeInsets.symmetric(horizontal: 15, vertical: 16),
//           enabledBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(16),
//             borderSide: const BorderSide(color: AppColors.primaryColor),
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(16),
//             borderSide: const BorderSide(color: AppColors.primaryColor),
//           ),
//           errorBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(16),
//             borderSide: const BorderSide(color: Colors.red),
//           ),
//           focusedErrorBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(16),
//             borderSide: const BorderSide(color: Colors.red),
//           ),
//         ),
//       ),
//     );
//   }
// }
