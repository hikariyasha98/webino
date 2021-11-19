// class Category {
//   final int code;
//   final List data;
//   final String message;

//   Category({
//     required this.code,
//     required this.data,
//     required this.message,
//   });

//   factory Category.fromJson(Map<String, dynamic> json) {
//     return Category(
//       code: json['code'],
//       data: List.from(json["data"].map((x) {
//         print(x);
//         return PerCategory(ctg: x['category']);
//       })),
//       message: json['message'],
//     );
//   }
// }

// // class Category {
// //   final int code;
// //   final List data;
// //   final String message;

// //   Category({
// //     required this.code,
// //     required this.data,
// //     required this.message,
// //   });

// //   factory Category.fromJson(Map<String, dynamic> json) {
// //     return Category(
// //       code: json['code'],
// //       data: List<String>.from(json["data"].map((x) {

// //         return "Test";
// //       })),
// //       message: json['message'],
// //     );
// //   }
// // }

// class PerCategory {
//   final String ctg;

//   PerCategory({
//     required this.ctg,
//   });

//   factory PerCategory.fromJson(dynamic json) {
//     print(json);
//     return PerCategory(ctg: json['category']);
//   }
// }
