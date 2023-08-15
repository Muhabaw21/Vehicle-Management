import 'dart:convert';
import 'dart:ui';
import 'package:bazralogin/Theme/Alert.dart';
import 'package:bazralogin/screen/Driver/driverBottomnav.dart';
import 'package:bazralogin/screen/Loging/forgotPin.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Model/loginRequestModel.dart';
import '../../Route/Routes.dart';
import '../../Model/ApiConfig.dart';
import '../../const/constant.dart';
import '../Bottom/Bottom.dart';

class Login extends StatefulWidget {
  const Login({
    super.key,
  });

  @override
  // ignore: library_private_types_in_public_api
  _LoginState createState() => _LoginState();
}
class _LoginState extends State<Login> {
  bool isHiddenPassword = true;
  bool hasInternetConnection = true;
  bool isExcecuted = false;
  bool value = false;
  String? username;
  var name;
  String? password;
  bool isLoading = false;

  final _formKey = GlobalKey<FormState>();
  void _passwordView() {
    setState(() {
      isHiddenPassword = !isHiddenPassword;
    });
  }

  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  // UserController userController = UserController();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Future vehicleFetch() async {
    // fetch list of total vehicles
    await APIService.vehicleFetch();
  }

  ResetPasswords() async {
    try {
      final storage = new FlutterSecureStorage();
      var value = await storage.read(key: 'jwt');

      Map data = {
        "phoneNumber": "${phoneController.text}",
      };
      var response = await http.post(
          Uri.parse('http://164.90.174.113:9090/Api/User/GeneratePIN'),
          body: jsonEncode(data) as String,
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
          });

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        await storage.write(key: "jwt", value: data["message"]);
        var value = await storage.read(key: 'jwt');
        String alertContent = data["message"];

        print(value);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => forgotPin(
                      phone: phoneController.text,
                      newpin: alertContent.substring(alertContent.length - 6),
                    )));
      } else {
        print('noooo');
      }
    } catch (e) {
      print(e);
      throw e;
    }
  }

  void clickBtnLogin() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState?.save();

      LoginRequestModel model =
          LoginRequestModel(username: username!, password: password!);
      setState(() {
        isLoading = true;
      });
      APIService.loginFetch(model).then((response) async {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('phone_number', phoneController.text);
        if (APIService.ownername == "DRIVER") {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => BottomTabBarPage()));
        } else if (APIService.ownername == "OWNER") {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => BottomTabBarPageforowner()));
        } else {
          AlertDialoug.showMyDialog(context, "Alert", 'Unauthorized');
          setState(() {
            isLoading = false;
          });
        }
      });
    }
    APIService.ownername = "";
  }

  @override
  void initState() {
    super.initState();

    vehicleFetch();
    //futureWelcome = fetchWelcome();
    //clickLoginBtn();
  }

  void dispose() {
    // Dispose the controller
    passwordController.dispose();
    phoneController.dispose();

    isLoading = false;

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double hight = MediaQuery.of(context).size.height;
    print("yared");

    return Container(
      height: MediaQuery.of(context).size.height,
      child: Scaffold(
        backgroundColor: Colors.black,
        resizeToAvoidBottomInset: false,
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/a.jpg'),
              repeat: ImageRepeat.repeatY,
              colorFilter: ColorFilter.mode(
                Color.fromRGBO(150, 161, 189, 1),
                BlendMode.modulate,
              ), // <-- BACKGROUND IMAGE
            ),
          ),
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(left: 0, right: 0, bottom: 0, top: 20),
              child: Column(
                children: [
                  Column(
                    children: [
                      Column(
                        children: [
                          Container(
                            height: hight * 0.2,
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        // color: Colors.white,
                                        // shape: BoxShape.circle,
                                        ),
                                    child: SizedBox(
                                      width: 150,
                                      height: 150,
                                      child: Image.asset(
                                          'assets/images/R-removebg-preview.png'),
                                    ),
                                  )
                                ]),
                          )
                        ],
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.only(topLeft: Radius.circular(70)),
                          ),
                          height: hight * 0.8,
                          child: ListView(
                            physics: NeverScrollableScrollPhysics(),
                            children: [
                              Form(
                                  key: _formKey,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(
                                                top: hight * 0.04),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                  child: Text("Login",
                                                      textAlign: TextAlign.left,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: const TextStyle(
                                                          fontFamily: 'Nunito',
                                                          fontSize: AppFonts
                                                              .mediumFontSize,
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                )
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              margin: EdgeInsets.only(
                                                  top: hight * 0.1),
                                              decoration: BoxDecoration(
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey.shade400
                                                        .withOpacity(0.4),
                                                    spreadRadius: 1,
                                                    blurRadius: 2,
                                                    offset: Offset(0,
                                                        1), // horizontal, vertical offset
                                                  ),
                                                ],
                                              ),
                                              child: TextFormField(
                                                keyboardType:
                                                    TextInputType.text,
                                                controller: phoneController,
                                                onSaved: ((newValue) {
                                                  username = newValue;
                                                }),
                                                inputFormatters: <TextInputFormatter>[
                                                  FilteringTextInputFormatter
                                                      .allow(RegExp(r'[0-9]')),
                                                  FilteringTextInputFormatter
                                                      .digitsOnly,
                                                ],
                                                validator: (value) {
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    return 'please enter phone number';
                                                  } else {
                                                    return null;
                                                  }
                                                },
                                                cursorColor: Colors.white,
                                                style: const TextStyle(
                                                    color: Colors.black),
                                                decoration: InputDecoration(
                                                  labelText: "Phone Number",
                                                  labelStyle: TextStyle(
                                                      fontFamily: 'Nunito',
                                                      fontSize: AppFonts
                                                          .smallFontSize,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.normal),
                                                  fillColor: Color.fromRGBO(
                                                      255, 255, 255, 1),
                                                  filled: true,
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.white),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            6.0),
                                                  ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Colors
                                                          .white, // Set the border color to white
                                                      // Set the border width
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                  ),
                                                  border: OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Colors.white),
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(10),
                                                        topRight:
                                                            Radius.circular(10),
                                                        bottomLeft:
                                                            Radius.circular(10),
                                                        bottomRight:
                                                            Radius.circular(10),
                                                      )),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey.shade400
                                                        .withOpacity(0.4),
                                                    spreadRadius: 1,
                                                    blurRadius: 2,
                                                    offset: Offset(0,
                                                        1), // horizontal, vertical offset
                                                  ),
                                                ],
                                              ),
                                              child: TextFormField(
                                                controller: passwordController,
                                                onSaved: ((newValue) {
                                                  password = newValue;
                                                }),
                                                validator: (value) {
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    return 'please enter password';
                                                  } else {
                                                    return null;
                                                  }
                                                },
                                                cursorColor: Colors.white,
                                                style: const TextStyle(
                                                    color: Colors.black),
                                                obscureText: isHiddenPassword,
                                                decoration: InputDecoration(
                                                  labelStyle: TextStyle(
                                                      fontFamily: 'Nunito',
                                                      fontSize: AppFonts
                                                          .smallFontSize,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.normal),
                                                  labelText: "Password",
                                                  suffixIcon: IconButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        isHiddenPassword =
                                                            !isHiddenPassword;
                                                      });
                                                    },
                                                    icon: Icon(
                                                      isHiddenPassword
                                                          ? Icons.visibility_off
                                                          : Icons.visibility,
                                                      color: Color.fromRGBO(
                                                          178, 142, 22, 1),
                                                    ),
                                                  ),
                                                  fillColor: Color.fromRGBO(
                                                      255, 255, 255, 1),
                                                  filled: true,
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.white),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            6.0),
                                                  ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Colors
                                                          .white, // Set the border color to white
                                                      // Set the border width
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                  ),
                                                  border: OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Colors.white),
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(10),
                                                        topRight:
                                                            Radius.circular(10),
                                                        bottomLeft:
                                                            Radius.circular(10),
                                                        bottomRight:
                                                            Radius.circular(10),
                                                      )),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(
                                              left: 7,
                                            ),
                                            width: width,
                                            height: hight * 0.03,
                                            alignment: Alignment.bottomLeft,
                                            child: InkWell(
                                              onTap: () {
                                                ResetPasswords();
                                              },
                                              child: const Text(
                                                " Forget Password",
                                                textAlign: TextAlign.left,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                    fontFamily: 'Nunito',
                                                    fontSize:
                                                        AppFonts.smallFontSize,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: width,
                                            height: hight * 0.13,
                                            child: Container(
                                                child: Container(

                                                    // ignore: prefer_const_constructors
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          const BorderRadius
                                                              .only(
                                                        topLeft:
                                                            Radius.circular(
                                                                22.0),
                                                        bottomLeft:
                                                            Radius.circular(
                                                                22.0),
                                                        bottomRight:
                                                            Radius.circular(
                                                                22.0),
                                                        topRight:
                                                            Radius.circular(
                                                                22.0),
                                                      ),
                                                    ),
                                                    child: TextButton(
                                                      onPressed: (() {
                                                        Get.toNamed(AppRoutes
                                                            .getHomeRoute());
                                                      }),
                                                      child: ElevatedButton(
                                                          onPressed: isLoading
                                                              ? null
                                                              : clickBtnLogin,
                                                          child: Container(
                                                            height: 55,
                                                            width: width,
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                isLoading
                                                                    ? SizedBox(
                                                                        height:
                                                                            24,
                                                                        width:
                                                                            24,
                                                                        child:
                                                                            CircularProgressIndicator(
                                                                          valueColor:
                                                                              AlwaysStoppedAnimation<Color>(Colors.white),
                                                                        ),
                                                                      )
                                                                    : SizedBox(), // Empty SizedBox if not loading
                                                                SizedBox(
                                                                    width: 8),
                                                                Text(
                                                                  isLoading
                                                                      ? 'Please Wait'
                                                                      : 'Sign IN'
                                                                          .toUpperCase(),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  style: const TextStyle(
                                                                      fontFamily:
                                                                          'Nunito',
                                                                      fontSize:
                                                                          AppFonts
                                                                              .smallFontSize,
                                                                      color: Colors
                                                                          .black,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                          style: ButtonStyle(
                                                              backgroundColor:
                                                                  MaterialStateProperty
                                                                      .resolveWith(
                                                                          (states) {
                                                                if (states.contains(
                                                                    MaterialState
                                                                        .pressed)) {
                                                                  return Color
                                                                      .fromRGBO(
                                                                          255,
                                                                          148,
                                                                          165,
                                                                          223);
                                                                }
                                                                // 98, 172, 181
                                                                return const Color
                                                                        .fromRGBO(
                                                                    178,
                                                                    142,
                                                                    22,
                                                                    1);
                                                              }),
                                                              shape: MaterialStateProperty.all<
                                                                      RoundedRectangleBorder>(
                                                                  RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              6))))),
                                                    ))),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(
                                                top: hight * 0.06),
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  void showErrorSnackbar(BuildContext context, String errorMessage) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Center(child: Text(errorMessage)),
        backgroundColor:
            Colors.blue, // You can customize the background color here
        duration: Duration(seconds: 3),
        behavior: SnackBarBehavior.floating, // Use a floating behavior
        margin: EdgeInsets.only(
            top: 70.0), // Adjust the duration as per your preference
      ),
    );
  }
}
