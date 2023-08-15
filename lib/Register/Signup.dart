// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';



// class RegistrationForm extends StatefulWidget {
//   const RegistrationForm({super.key});

//   @override
//   State<RegistrationForm> createState() => _RegistrationFormState();
// }

// class _RegistrationFormState extends State<RegistrationForm> {
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   TextEditingController password = TextEditingController();
//   bool isHiddenPassword = true;
//   PickedFile? _pickedImage;
//   final ImagePicker _picker = ImagePicker();

//   void isPasswordView() {
//     setState(() {
//       isHiddenPassword = !isHiddenPassword;
//     });
//   }

//   void takePicture(ImageSource source) async {
//     final pickedFile = await _picker.getImage(
//       source: source,
//     );
//     setState(() {
//       _pickedImage = pickedFile;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     double height = MediaQuery.of(context).size.height;
//     double width = MediaQuery.of(context).size.width;

//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Stack(
//               children: [
//                 Container(
//                   height: height - 5,
//                   margin: const EdgeInsets.only(top: 180),
//                   decoration: const BoxDecoration(
//                     image: DecorationImage(
//                       image: AssetImage('assets/images/a.jpg'),
//                       repeat: ImageRepeat.repeatY,
//                       colorFilter: ColorFilter.mode(
//                         Color.fromRGBO(155, 161, 182, 1),
//                         BlendMode.modulate,
//                       ), // <-- BACKGROUND IMAGE
//                     ),
//                     borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(100.0),
//                     ),
//                     color: Colors.grey,
//                   ),
//                   child: Form(
//                     key: _formKey,
//                     child: Container(
//                       margin: const EdgeInsets.fromLTRB(40, 70, 40, 0),
//                       child: Column(children: <Widget>[
//                         // enter phone Number
//                         TextFormField(
//                           keyboardType: TextInputType.phone,
//                           decoration: InputDecoration(
//                             hintText: 'Phone Number',
//                             suffixIcon: const Icon(
//                               Icons.phone,
//                               color: Colors.lightBlue,
//                             ),
//                             enabledBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(10.0),
//                             ),
//                             hintStyle: const TextStyle(
//                               color: Color.fromARGB(255, 255, 235, 255),
//                             ),
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(12.0),
//                             ),
//                             // Based on passwordVisible state choose the ic
//                           ),
//                           validator: (value) {
//                             if (value?.length != 10) {
//                               return 'Please Enter Your Name';
//                             }
//                           },
//                           style: TextStyle(fontSize: 15, color: Colors.white),
//                         ),
//                         //password
//                         SizedBox(
//                           height: 10,
//                         ),
//                         TextFormField(
//                           keyboardType: TextInputType.text,
//                           decoration: InputDecoration(
//                             hintText: 'Full Name',
//                             suffixIcon: Icon(
//                               Icons.person,
//                               color: Colors.lightBlue,
//                             ),
//                             enabledBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(10.0),
//                             ),
//                             hintStyle: TextStyle(
//                               color: Color.fromARGB(255, 255, 235, 255),
//                             ),
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(12.0),
//                             ),
//                             // Based on passwordVisible state choose the ic
//                           ),
//                           validator: (value) {
//                             if (value!.isEmpty) {
//                               return 'Please Enter Your Name';
//                             }
//                             return null;
//                           },
//                           style: TextStyle(fontSize: 15, color: Colors.white),
//                         ),
//                         SizedBox(
//                           height: 10,
//                         ),
//                         //full name
//                         TextFormField(
//                           keyboardType: TextInputType.emailAddress,
//                           decoration: InputDecoration(
//                             hintText: 'Email',
//                             suffixIcon: Icon(
//                               Icons.email,
//                               color: Colors.lightBlue,
//                             ),
//                             enabledBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(10.0),
//                             ),
//                             hintStyle: TextStyle(
//                               color: Color.fromARGB(255, 255, 235, 255),
//                             ),
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(12.0),
//                             ),
//                             // Based on passwordVisible state choose the ic
//                           ),
//                           validator: (val) => val!.isEmpty || !val.contains("@")
//                               ? "Enter a valid eamil"
//                               : null,
//                           style: TextStyle(fontSize: 15, color: Colors.white),
//                         ),
//                         //password

//                         TextFormField(
//                           keyboardType: TextInputType.text,
//                           obscureText: isHiddenPassword,
//                           decoration: InputDecoration(
//                             hintText: 'Password',
//                             suffixIcon: IconButton(
//                               onPressed: isPasswordView,
//                               icon: Icon(
//                                 isHiddenPassword
//                                     ? Icons.visibility
//                                     : Icons.visibility_off_sharp,
//                                 color: Colors.lightBlue,
//                               ),
//                             ),
//                             enabledBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(10.0),
//                             ),
//                             hintStyle: TextStyle(
//                               color: Color.fromARGB(255, 255, 235, 255),
//                             ),
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(12.0),
//                             ),
//                             // Based on passwordVisible state choose the ic
//                           ),
//                           validator: (value) {
//                             if (value!.isEmpty || value.length < 6) {
//                               return 'Please Enter 6 character';
//                             }
//                             return null;
//                           },
//                           style: TextStyle(fontSize: 15, color: Colors.white),
//                         ),
//                         //Confirm Password
//                         SizedBox(
//                           height: 10,
//                         ),
//                         TextFormField(
//                           keyboardType: TextInputType.text,
//                           obscureText: isHiddenPassword,
//                           decoration: InputDecoration(
//                             hintText: 'Confirm Password',
//                             suffixIcon: IconButton(
//                               onPressed: isPasswordView,
//                               icon: Icon(
//                                 isHiddenPassword
//                                     ? Icons.visibility
//                                     : Icons.visibility_off_sharp,
//                                 color: Colors.lightBlue,
//                               ),
//                             ),
//                             enabledBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(10.0),
//                             ),
//                             hintStyle: TextStyle(
//                               color: Color.fromARGB(255, 255, 235, 255),
//                             ),
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(12.0),
//                             ),
//                             // Based on passwordVisible state choose the ic
//                           ),
//                           validator: (value) {
//                             if (value!.isEmpty || value.length < 6) {
//                               return 'Please enter a valid password';
//                             }
//                             return null;
//                           },
//                           style: TextStyle(fontSize: 15, color: Colors.white),
//                         ),
//                         SizedBox(
//                           height: 10,
//                         ),
//                         Container(
//                           child: ElevatedButton(
//                             onPressed: () {
//                               if (_formKey.currentState!.validate()) {
//                                 Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                         builder: (context) =>
//                                             BottomTabBarPageforowner()));
//                               }
//                             },
//                             child: Container(
//                               margin: EdgeInsets.only(top: 5.0),
//                               height: height * 0.04,
//                               width: 310,
//                               child: Center(
//                                 child: const Text(
//                                   "SIGNUP",
//                                   style: TextStyle(
//                                       color: Colors.white, fontSize: 20),
//                                 ),
//                               ),
//                             ),
//                             style: ButtonStyle(
//                                 backgroundColor:
//                                     MaterialStateProperty.resolveWith((states) {
//                                   if (states.contains(MaterialState.pressed)) {
//                                     return Color.fromRGBO(255, 148, 165, 223);
//                                   }
//                                   // 98, 172, 181
//                                   return Color.fromRGBO(100, 172, 181, 1);
//                                 }),
//                                 shape: MaterialStateProperty.all<
//                                         RoundedRectangleBorder>(
//                                     RoundedRectangleBorder(
//                                         borderRadius:
//                                             BorderRadius.circular(25)))),
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Container(
//                             margin: EdgeInsets.only(left: 4),
//                             height: 20,
//                             width: MediaQuery.of(context).size.width,
//                             child: Row(
//                               children: [
//                                 Text(
//                                   'Already have an account! ',
//                                   style: TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 17,
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   height: 8,
//                                 ),
//                                 Padding(
//                                   padding: const EdgeInsets.all(0.0),
//                                   child: Container(
//                                     child: GestureDetector(
//                                       onTap: () {
//                                         Navigator.push(
//                                             context,
//                                             MaterialPageRoute(
//                                                 builder: (context) => Login()));
//                                       },
//                                       child: Text('SIGN IN',
//                                           style: TextStyle(
//                                               color: Colors.lightBlue,
//                                               fontSize: 18)),
//                                     ),
//                                   ),
//                                 )
//                               ],
//                             ),
//                           ),
//                         ),
//                       ]),
//                     ),
//                   ),
//                 ),
//                 Positioned(
//                     top: 60,
//                     left: width * 0.3,
//                     height: height * 0.3,
//                     child: Column(
//                       children: [
//                         Stack(
//                           children: [
//                             CircleAvatar(
//                               radius: 71,
//                               backgroundColor: Colors.blueGrey,
//                               child: CircleAvatar(
//                                 radius: 68,
//                                 backgroundImage: _pickedImage == null
//                                     ? AssetImage("assets/images/a.jpg")
//                                     : FileImage(File(_pickedImage!.path))
//                                         as ImageProvider,
//                               ),
//                             ),
//                             Positioned(
//                               top: 100,
//                               left: 75,
//                               child: Container(
//                                 child: RawMaterialButton(
//                                   onPressed: () {
//                                     showDialog(
//                                         context: context,
//                                         builder: (BuildContext contex) {
//                                           return AlertDialog(
//                                             title: Text('Choose Option',
//                                                 style: TextStyle(
//                                                   fontWeight: FontWeight.w600,
//                                                   color: Colors.lightBlue,
//                                                 )),
//                                             content: SingleChildScrollView(
//                                               child: ListBody(children: [
//                                                 InkWell(
//                                                     onTap: () {
//                                                       takePicture(
//                                                           ImageSource.camera);
//                                                     },
//                                                     splashColor:
//                                                         Colors.lightBlue,
//                                                     child: Row(
//                                                       children: [
//                                                         Padding(
//                                                           padding:
//                                                               const EdgeInsets
//                                                                   .all(8.0),
//                                                           child: Icon(
//                                                             Icons.camera,
//                                                             color: Colors
//                                                                 .lightBlue,
//                                                           ),
//                                                         ),
//                                                         Text('Camera',
//                                                             style: TextStyle(
//                                                                 fontSize: 18,
//                                                                 fontWeight:
//                                                                     FontWeight
//                                                                         .w500,
//                                                                 color: Colors
//                                                                     .grey[500]))
//                                                       ],
//                                                     )),
//                                                 InkWell(
//                                                     onTap: () {
//                                                       takePicture(
//                                                           ImageSource.gallery);
//                                                     },
//                                                     splashColor:
//                                                         Colors.lightBlue,
//                                                     child: Row(
//                                                       children: [
//                                                         Padding(
//                                                           padding:
//                                                               const EdgeInsets
//                                                                   .all(8.0),
//                                                           child: Icon(
//                                                             Icons
//                                                                 .browse_gallery,
//                                                             color: Colors
//                                                                 .lightBlue,
//                                                           ),
//                                                         ),
//                                                         Text('Galley',
//                                                             style: TextStyle(
//                                                                 fontSize: 18,
//                                                                 fontWeight:
//                                                                     FontWeight
//                                                                         .w500,
//                                                                 color: Colors
//                                                                     .grey[500]))
//                                                       ],
//                                                     )),
//                                                 InkWell(
//                                                     onTap: () {},
//                                                     splashColor:
//                                                         Colors.lightBlue,
//                                                     child: Row(
//                                                       children: [
//                                                         Padding(
//                                                           padding:
//                                                               const EdgeInsets
//                                                                   .all(8.0),
//                                                           child: Icon(
//                                                             Icons.remove_circle,
//                                                             color: Colors.red,
//                                                           ),
//                                                         ),
//                                                         Text('Remove',
//                                                             style: TextStyle(
//                                                                 fontSize: 18,
//                                                                 fontWeight:
//                                                                     FontWeight
//                                                                         .w500,
//                                                                 color: Colors
//                                                                     .grey[500]))
//                                                       ],
//                                                     )),
//                                               ]),
//                                             ),
//                                           );
//                                         });
//                                   },
//                                   elevation: 10,
//                                   fillColor: Colors.lightBlue,
//                                   child: Icon(Icons.add_a_photo),
//                                   shape: CircleBorder(),
//                                 ),
//                               ),
//                             )
//                           ],
//                         ),
//                       ],
//                     )),
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
