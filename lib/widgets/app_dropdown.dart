// import 'package:flutter/material.dart';
// import 'package:cost/const/app_colors.dart';
// import 'package:cost/const/screen_size.dart';
//
// class AppDropdown extends StatelessWidget {
//   const AppDropdown({
//     Key? key,
//     required this.items,
//     required this.onChanged,
//     this.text = '',
//     required this.height,
//     required this.width
//   }) : super(key: key);
//   final List items;
//   final String text;
//   final double width;
//   final double height;
//   final Function(Object?) onChanged;
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 10,vertical: ScreenSize.height(context) * 0.025),
//       height: ScreenSize.height(context) * height,
//       width: ScreenSize.width(context) * width,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(10),
//         color: AppColor.white,
//           border: Border.all(color: AppColor.primaryColor)
//       ),
//       child: DropdownButton(
//         dropdownColor: AppColor.white,
//         focusColor: AppColor.white,
//         iconEnabledColor: AppColor.primaryColor,
//         iconDisabledColor:AppColor.greyShimmer,
//         isExpanded: true,
//         iconSize: 26,
//         hint: Text(text,style:const TextStyle(color: AppColor.black),),
//         underline: Container(height: 0),
//         items: items
//             .map(
//               (item) => DropdownMenuItem(
//                 value: item,
//                 child: Text(item,style:const TextStyle(color: AppColor.black),),
//               ),
//             )
//             .toList(),
//         onChanged: onChanged,
//       ),
//     );
//   }
// }
//
//
//
// class AppDropdownForListOfTimeSlots extends StatelessWidget {
//    AppDropdownForListOfTimeSlots({
//     Key? key,
//      required this.items,
//     required this.onChanged,
//     this.text = '',
//     required this.height,
//     required this.width
//   }) : super(key: key);
//   List<dynamic> items = [];
//   final String text;
//   final double width;
//   final double height;
//   final Function(Object?) onChanged;
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 10,vertical: ScreenSize.height(context) * 0.025),
//       height: ScreenSize.height(context) * height,
//       width: ScreenSize.width(context) * width,
//       decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(10),
//           color: AppColor.white,
//           border: Border.all(color: AppColor.primaryColor)
//       ),
//       child: DropdownButton(
//         dropdownColor: AppColor.white,
//         focusColor: AppColor.white,
//         iconEnabledColor: AppColor.primaryColor,
//         iconDisabledColor:AppColor.greyShimmer,
//         isExpanded: true,
//         iconSize: 26,
//         hint: Text(text,style:const TextStyle(color: AppColor.black),),
//         underline: Container(height: 0),
//         items: items
//             .map(
//               (item) {
//                 return DropdownMenuItem(
//                   value: item,
//                   child: Text(item.timeSlot!,style:const TextStyle(color: AppColor.black),),
//                 );
//               }
//         )
//             .toList(),
//         onChanged: onChanged,
//       ),
//     );
//   }
// }
