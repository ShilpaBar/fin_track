// // ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

// import 'package:flutter/material.dart';
// import 'package:hive_flutter/hive_flutter.dart';
// import 'package:moneymanager_clone/hive_models/income_model.dart';
// import 'package:moneymanager_clone/theme/text_styles.dart';

// import '../constants/app_strings.dart';
// import '../hive_boxes_model/boxes_model.dart';

// class MorePage extends StatefulWidget {
//   const MorePage({super.key});

//   @override
//   State<MorePage> createState() => _MorePageState();
// }

// class _MorePageState extends State<MorePage> {
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           toolbarHeight: 70,
//           backgroundColor: Colors.transparent,
//           elevation: 0,
//           flexibleSpace: Padding(
//             padding: const EdgeInsets.all(15.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   "More ",
//                   style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
//                 ),
//                 Container(
//                   padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//                   alignment: Alignment.center,
//                   height: 40,
//                   width: MediaQuery.of(context).size.width * .45,
//                   decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(30),
//                       color: Color.fromARGB(118, 140, 157, 255)),
//                   child: Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Icon(Icons.workspace_premium_outlined),
//                       Padding(
//                         padding: EdgeInsets.only(left: 5.0),
//                         child: Text(
//                           "BUY PREMIUM",
//                           style: TextStyle(
//                               fontSize:
//                                   MediaQuery.of(context).size.width * .038,
//                               letterSpacing: 1,
//                               fontWeight: FontWeight.bold),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//         body: SingleChildScrollView(
//           child: ValueListenableBuilder<Box<IncomeModel>>(
//               valueListenable: Boxes.getData().listenable(),
//               builder: (context, box, _) {
//                 int inCome = 0, expence = 0, remaining = 0;

//                 final value = box.values.toList().cast<IncomeModel>();
//                 for (var i in value) {
//                   if (i.type == income) {
//                     inCome = inCome + int.parse(i.amount);
//                   }
//                   if (i.type == expense) {
//                     expence = expence + int.parse(i.amount);
//                   }
//                 }

//                 remaining = inCome - expence;
//                 return Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 15.0),
//                   child: Column(
//                     children: [
//                       ListTile(
//                         contentPadding: EdgeInsets.only(right: 10, left: 3),
//                         leading: Padding(
//                           padding: const EdgeInsets.only(top: 10.0),
//                           child: Icon(Icons.credit_card),
//                         ),
//                         title: Text(
//                           "Accounts",
//                           style: TextStyle(
//                             fontSize: 19,
//                             color: Colors.black,
//                           ),
//                         ),
//                         subtitle: Text(
//                           "Overall:0",
//                           style: TextStyle(color: Colors.black38, fontSize: 17),
//                         ),
//                         trailing: Text(
//                           "ADD NEW",
//                           style: TextStyle(
//                               fontSize: 16,
//                               color: Colors.blue,
//                               fontWeight: FontWeight.bold,
//                               letterSpacing: .5),
//                         ),
//                       ),
//                       Align(
//                         alignment: Alignment.centerLeft,
//                         child: Container(
//                           decoration: BoxDecoration(
//                               color: Colors.white,
//                               boxShadow: [
//                                 BoxShadow(
//                                   color: Colors.grey.withOpacity(0.5),
//                                   spreadRadius: .5,
//                                   blurRadius: 15,
//                                   offset: Offset(0, 1),
//                                 ),
//                               ],
//                               border: Border.all(width: .5),
//                               borderRadius: BorderRadius.circular(5)),
//                           width: MediaQuery.of(context).size.width / 2 - 20,
//                           height: 80,
//                           padding: const EdgeInsets.all(12.0),
//                           child: Column(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Text(
//                                       "$remaining",
//                                       style: TextStyle(
//                                         fontSize: 19,
//                                         color: Colors.black,
//                                       ),
//                                     ),
//                                     CircleAvatar(
//                                       radius: 15,
//                                       backgroundColor: Colors.black12,
//                                       child: Icon(
//                                         Icons.wallet,
//                                         color: Colors.black45,
//                                         size: 19,
//                                       ),
//                                     )
//                                   ],
//                                 ),
//                                 Row(
//                                   crossAxisAlignment: CrossAxisAlignment.center,
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Text(
//                                       "Main Account",
//                                       style: TextStyle(
//                                           color: Colors.black38, fontSize: 17),
//                                     ),
//                                     Text(
//                                       "Default",
//                                       style: TextStyle(
//                                           color: Colors.blue[200],
//                                           fontSize: 12),
//                                     )
//                                   ],
//                                 )
//                               ]),
//                         ),
//                       ),
//                       ListView.builder(
//                         padding: EdgeInsets.symmetric(vertical: 10),
//                         physics: NeverScrollableScrollPhysics(),
//                         shrinkWrap: true,
//                         itemCount: 5,
//                         itemBuilder: (context, index) {
//                           return Padding(
//                             padding: const EdgeInsets.only(top: 4.0),
//                             child: ListTile(
//                               contentPadding: EdgeInsets.zero,
//                               leading: Icon(Icons.list),
//                               dense: true,
//                               minVerticalPadding: 10,
//                               title: Text(
//                                 "Experimental",
//                                 style: commonBlackText20,
//                               ),
//                               subtitle: Text(
//                                 "This is Experimental trial dfkvghkm fkdeskd vkj vksdugksd vlhsdf skdvgytkbn",
//                                 style: commonBlack26Text18,
//                               ),
//                             ),
//                           );
//                         },
//                       ),
//                       Container(
//                         alignment: Alignment.centerLeft,
//                         child: Text(
//                           "About",
//                           style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                               color: Colors.grey[500]),
//                         ),
//                       ),
//                       ListView.builder(
//                         physics: NeverScrollableScrollPhysics(),
//                         padding: EdgeInsets.symmetric(vertical: 10),
//                         shrinkWrap: true,
//                         itemCount: 4,
//                         itemBuilder: (context, index) {
//                           return Padding(
//                             padding: const EdgeInsets.only(top: 4.0),
//                             child: ListTile(
//                               contentPadding: EdgeInsets.zero,
//                               leading: Icon(Icons.list),
//                               dense: true,
//                               minVerticalPadding: 10,
//                               title: Text(
//                                 "Experimental",
//                                 style: commonBlackText20,
//                               ),
//                               subtitle: Text(
//                                 "This is experimental trial dfkvghkm fkdeskd vkj vksdugksd vlhsdf skdvgytkbn",
//                                 style: commonBlack26Text18,
//                               ),
//                             ),
//                           );
//                         },
//                       ),
//                     ],
//                   ),
//                 );
//               }),
//         ),
//       ),
//     );
//   }
// }
