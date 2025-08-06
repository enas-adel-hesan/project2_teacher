//
// import '../constants/strings/auth_strings_manager.dart';
//
// class Validators {
//   static String? validateEmail(String? value) {
//     if (value == null || value.isEmpty) {
//       return 'Email is required';
//     }
//     if (!RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
//       return 'Enter a valid email';
//     }
//     return null;
//   }
//   static String? validatePhoneNumber(String? value) {
//     if (value == null || value.isEmpty) {
//       return AuthStrings.phoneEmptyError;
//     }
//     if (!RegExp(r'^\d+$').hasMatch(value)) {
//       return AuthStrings.phoneInvalidError;
//     }
//     if (value.length != 9) {
//       return AuthStrings.phoneLengthError;
//     }
//     if (!value.startsWith('9')) {
//       return AuthStrings.phoneStartError;
//     }
//
//     return null;
//   }
//
//   static String? validatePassword(String? value) {
//     if (value == null || value.isEmpty) {
//       return AuthStrings.passwordEmptyError;
//     }
//     if (value.length < 8) {
//       return AuthStrings.passwordShortError;
//     }
//     if (!RegExp(r'[A-Za-z]').hasMatch(value) || !RegExp(r'[0-9]').hasMatch(value)) {
//       return AuthStrings.passwordWeakError;
//     }
//     return null;
//   }
//
//   static String? validateName(String? value) {
//     if (value == null || value.isEmpty) {
//       return AuthStrings.nameEmptyError;
//     }
//     if (value.length < 3) {
//       return AuthStrings.nameShortError;
//     }
//     return null;
//   }
//
//   static String? notEmpty(String? value){
//     if (value == null || value.isEmpty) return 'هذا الحقل مطلوب';
//     if (value.length < 2) return 'غير صالح';
//     return null;
//
//   }
//   static String? validDate (value) {
//   if (value == null || value.isEmpty) return 'مطلوب';
//   final date = DateTime.tryParse(value);
//   if (date == null) return 'تاريخ غير صالح';
//   if (date.isAfter(DateTime.now())) return 'لا يمكن أن يكون في المستقبل';
//   if (DateTime.now().difference(date).inDays < 365 * 18) {
//   return 'يجب أن يكون العمر 18 سنة على الأقل';
//   }
//   return null;
//   }
//   static String? validId (value) {
//   if (value == null || value.isEmpty) return 'مطلوب';
//   if (!RegExp(r'^[0-9]+$').hasMatch(value)) return 'يجب أن يحتوي على أرقام فقط';
//   if (value.length != 11) return 'يجب أن يتكون من 11 أرقام';
//   return null;
//   }
//
//
// }