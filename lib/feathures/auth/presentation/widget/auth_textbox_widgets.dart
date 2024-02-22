import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:paisa/config/themes/app_themes.dart';

//couldn't fix callback issue so created new way
// class AuthTextField extends StatelessWidget {
//   final TextEditingController controller;
//   final String hintText;
//   final void Function(String) onEditingComplete;
//   final String? Function(String?)? validator;
//   final TextInputType keyboardType;
//   final bool obscureText;
//   final void Function(bool)? onToggleVisibility;

//   const AuthTextField({
//     super.key,
//     required this.controller,
//     required this.hintText,
//     required this.onEditingComplete,
//     this.validator,
//     this.keyboardType = TextInputType.text,
//     this.obscureText = false,
//     this.onToggleVisibility,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: TextFormField(
//           keyboardType: keyboardType,
//           textInputAction: TextInputAction.next,
//           keyboardAppearance: Brightness.light,
//           onEditingComplete: () => onEditingComplete(controller.text),
//           autocorrect: false,
//           controller: controller,
//           validator: validator,
//           obscureText: obscureText,
//           decoration: InputDecoration(
//             icon: const Icon(
//               Icons.alternate_email_outlined,
//               color: AppColors.primaryColor,
//             ),
//             hintText: hintText,
//             hintStyle: GoogleFonts.poppins(
//               fontSize: 14.0,
//               fontWeight: FontWeight.w400,
//             ),
//             contentPadding:
//                 const EdgeInsets.symmetric(horizontal: 15, vertical: 16),
//             enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(16),
//               borderSide: const BorderSide(
//                 color: AppColors.primaryColor,
//               ),
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(16),
//               borderSide: const BorderSide(
//                 color: AppColors.primaryColor,
//               ),
//             ),
//             errorBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(16),
//               borderSide: const BorderSide(color: Colors.red),
//             ),
//             focusedErrorBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(16),
//               borderSide: const BorderSide(color: Colors.red),
//             ),
//             suffixIcon: onToggleVisibility != null
//                 ? IconButton(
//                     icon: Icon(
//                       obscureText ? Icons.visibility : Icons.visibility_off,
//                       color: AppColors.primaryColor,
//                     ),
//                     onPressed: () {
//                       onToggleVisibility?.call(!obscureText);
//                     },
//                   )
//                 : null,
//           ),
//         ));
//   }
// }

//new way
InputDecoration buildInputDecoration({
  required Icon icon,
  required String hintText,
  void Function()? onSuffixIconPressed,
  required bool obscureText,
}) {
  return InputDecoration(
    icon: icon,
    hintText: hintText,
    hintStyle: GoogleFonts.poppins(
      fontSize: 14.0,
      fontWeight: FontWeight.w400,
    ),
    contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: const BorderSide(
        color: AppColors.primaryColor,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: const BorderSide(
        color: AppColors.primaryColor,
      ),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: const BorderSide(color: Colors.red),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: const BorderSide(color: Colors.red),
    ),
    errorStyle: GoogleFonts.poppins(
      fontSize: 12.0,
      height: 1.0,
      fontWeight: FontWeight.w400,
      color: Colors.red,
    ),
    suffixIcon: onSuffixIconPressed != null
        ? IconButton(
            icon: Icon(
              obscureText ? Icons.visibility : Icons.visibility_off,
              color: AppColors.primaryColor,
            ),
            onPressed: onSuffixIconPressed,
          )
        : null,
  );
}
