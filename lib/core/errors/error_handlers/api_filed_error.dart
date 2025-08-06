// class ApiFieldError {
//   final String field;
//   final List<String> messages; // تغيير من String إلى List<String>
//
//   ApiFieldError({required this.field, required this.messages});
// }
//
// class ApiErrorResponse {
//   final String generalMessage;
//   final Map<String, List<String>> fieldErrors; // تغيير الهيكل ليتوافق مع الـ API
//
//   ApiErrorResponse({
//     required this.generalMessage,
//     required this.fieldErrors,
//   });
//
//   factory ApiErrorResponse.fromJson(Map<String, dynamic> json) {
//     final errors = <String, List<String>>{};
//
//     if (json['errors'] != null) {
//       (json['errors'] as Map).forEach((key, value) {
//         errors[key] = List<String>.from(value);
//       });
//     }
//
//     return ApiErrorResponse(
//       generalMessage: json['message'] ?? 'حدث خطأ',
//       fieldErrors: errors,
//     );
//   }
//
//   // دالة مساعدة للحصول على أول خطأ لحقل معين
//   String? getFirstFieldError(String fieldName) {
//     final errors = fieldErrors[fieldName];
//     return errors?.isNotEmpty == true ? errors!.first : null;
//   }
//
//   // دالة لتحويل جميع الأخطاء إلى سطر واحد
//   String getAllErrorsAsString() {
//     final allErrors = fieldErrors.values.expand((e) => e).toList();
//     return allErrors.join('\n');
//   }
// }