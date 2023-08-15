
// // import 'package:bazralogin/Route/route.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class carTest extends StatelessWidget {
//   carTest({super.key});
//   bool isLoading = false;
//   @override
//   Widget build(BuildContext context) {
//     final carData = Provider.of<Carinfo>(context);
//     final productsList = carData.products;
//     return Container(
//       margin: EdgeInsets.only(top: 90),
//       child: Row(
//         children: [
//           Padding(
//             padding: const EdgeInsets.only(left: 8),
//             child: Container(
//               height: 50,
//               width: MediaQuery.of(context).size.width * 0.3,
//               margin: EdgeInsets.only(top: 100),
//               child: ElevatedButton(
//                 onPressed: (() {
//                   // Navigator.pushNamed(context, AppRoutes.carhistory);
//                 }),
//                 child: Text(
//                   "History",
//                   style: TextStyle(color: Colors.black),
//                 ),
//                 style: ButtonStyle(
//                     backgroundColor:
//                         MaterialStateProperty.resolveWith((states) {
//                       if (states.contains(MaterialState.pressed)) {
//                         return Colors.white;
//                       }
//                       return const Color.fromRGBO(255, 255, 255, 1);
//                     }),
//                     shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                         RoundedRectangleBorder(
//                             side: const BorderSide(
//                                 color: Color.fromRGBO(162, 184, 212, 1)),
//                             borderRadius: BorderRadius.circular(12)))),
//               ),
//             ),
//           ),
//           Container(
//             width: MediaQuery.of(context).size.width * 0.45,
//             margin: EdgeInsets.only(left: 60),
//             child: isLoading
//                 ? Center(
//                     child: CircularProgressIndicator(),
//                   )
//                 : Padding(
//                     padding: const EdgeInsets.all(0.0),
//                     child: Container(
//                       child: isLoading
//                           ? Center(
//                               child: CircularProgressIndicator(),
//                             )
//                           : Padding(
//                               padding: const EdgeInsets.all(0.0),
//                               child: Container(
//                                 child: Column(
//                                   children: [
//                                     Container(
//                                       decoration: BoxDecoration(
//                                           color: Colors.white,
//                                           borderRadius:
//                                               BorderRadius.circular(22)),
//                                       child: Autocomplete<Car>(
//                                         optionsBuilder: (textEditingValue) {
//                                           if (textEditingValue.text == '') {
//                                             return const Iterable<Car>.empty();
//                                           }
//                                           return productsList
//                                               .where((Car option) {
//                                             return option.name
//                                                 .toLowerCase()
//                                                 .contains(textEditingValue.text
//                                                     .toLowerCase());
//                                           });
//                                         },
//                                         fieldViewBuilder: (BuildContext context,
//                                             TextEditingController
//                                                 textEditingController,
//                                             FocusNode focusNode,
//                                             VoidCallback onFieldSubmitted) {
//                                           return SizedBox(
//                                             child: TextFormField(
//                                               controller: textEditingController,
//                                               decoration: InputDecoration(
//                                                   border: OutlineInputBorder(
//                                                     borderRadius:
//                                                         BorderRadius.circular(
//                                                             18),
//                                                     borderSide: BorderSide(
//                                                         width: 1,
//                                                         color: Colors.white),
//                                                   ),
//                                                   focusedBorder:
//                                                       OutlineInputBorder(
//                                                     borderRadius:
//                                                         BorderRadius.circular(
//                                                             14),
//                                                     borderSide: BorderSide(
//                                                         width: 1,
//                                                         color: Colors.white),
//                                                   ),
//                                                   enabledBorder:
//                                                       OutlineInputBorder(
//                                                     borderRadius:
//                                                         BorderRadius.circular(
//                                                             8),
//                                                     borderSide: BorderSide(
//                                                         width: 1,
//                                                         color: Colors.white),
//                                                   ),
//                                                   hintText: "Search car"),
//                                               focusNode: focusNode,
//                                               // onFieldSubmitted:
//                                               //     (String value) {
//                                               //   onFieldSubmitted();
//                                               //   // print(
//                                               //   //     'You just typed a new entry  $value');
//                                               // },
//                                             ),
//                                           );
//                                         },
//                                         optionsViewBuilder:
//                                             (context, onSelected, options) {
//                                           return Align(
//                                             alignment: Alignment.topLeft,
//                                             child: Material(
//                                               elevation: 10,
//                                               shape: RoundedRectangleBorder(
//                                                   borderRadius:
//                                                       BorderRadius.circular(
//                                                           12)),
//                                               child: ConstrainedBox(
//                                                 constraints: const BoxConstraints(
//                                                     maxHeight: 200,
//                                                     maxWidth:
//                                                         600), //RELEVANT CHANGE: added maxWidth
//                                                 child: ListView.builder(
//                                                   padding: EdgeInsets.zero,
//                                                   shrinkWrap: true,
//                                                   itemCount: options.length,
//                                                   itemBuilder:
//                                                       (BuildContext context,
//                                                           int index) {
//                                                     final Car option = options
//                                                         .elementAt(index);
//                                                     return GestureDetector(
//                                                       onTap: () async {
//                                                         // _goto(8.5263,
//                                                         //     39.2583);
//                                                         // Navigator.of(
//                                                         //         context)
//                                                         //     .pushNamed(
//                                                         //         AppRoutes
//                                                         //             .Carinfo,
//                                                         //         arguments: {
//                                                         //       options
//                                                         //           .elementAt(
//                                                         //               index)
//                                                         //           .id
//                                                         //     });
//                                                       },
//                                                       child: ListTile(
//                                                         leading: Image.asset(
//                                                             "${options.elementAt(index).image}"),
//                                                         title: Text(
//                                                             "${options.elementAt(index).name}"),
//                                                       ),
//                                                     );
//                                                   },
//                                                 ),
//                                               ),
//                                             ),
//                                           );
//                                         },
//                                         // displayStringForOption: (option) => option.getInfo() + " - " + option.getOwnerInfo(),
//                                         onSelected: (option) => {option.name},
//                                       ),
//                                     )
//                                   ],
//                                 ),
//                               ),
//                             ),
//                     ),
//                   ),
//           ),
//         ],
//       ),
//     );
//   }
// }
