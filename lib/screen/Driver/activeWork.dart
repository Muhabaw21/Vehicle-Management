import 'dart:convert';

import 'package:bazralogin/const/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ionicons/ionicons.dart';
import 'package:http/http.dart' as http;
import '../../Theme/Alert.dart';
import '../../Theme/clippbox.dart';
import '../../config/APIService.dart';
import 'driverHomepage.dart';

class activeWork extends StatefulWidget {
  const activeWork({super.key});

  @override
  State<activeWork> createState() => _activeWorkState();
}

class _activeWorkState extends State<activeWork> {
  bool _isActivebutton = false;
  bool _isActivebutton2 = false;
  bool _isLoading = true;
  List Result = [];
  //change state of button
  void setActiveButton(bool isActive) {
    setState(() {
      _isActivebutton = isActive;
    });
  }

  Stream<List<dynamic>> fetchData() async* {
    while (true) {
      final storage = new FlutterSecureStorage();
      var token = await storage.read(key: 'jwt');
      var client = http.Client();
      Map<String, String> requestHeaders = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };
      var url = Uri.http(ApIConfig.urlAPI, ApIConfig.acceptwork);
      var response = await client.get(url, headers: requestHeaders);
      if (response.statusCode == 200) {
        var acceptwork = jsonDecode(response.body);
        List<dynamic> data = acceptwork["cargos"];
        yield data;
      } else {
        throw Exception('Failed to fetch data');
      }
      await Future.delayed(
          Duration(seconds: 5)); // Delay for 5 seconds before fetching again
    }
  }

  void setActiveButton2(bool isActive) {
    setState(() {
      _isActivebutton2 = isActive;
    });
  }

  activecargoFetch() async {
    try {
      final storage = new FlutterSecureStorage();
      var token = await storage.read(key: 'jwt');
      var client = http.Client();
      Map<String, String> requestHeaders = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };
      var url = Uri.http(ApIConfig.urlAPI, ApIConfig.corgaStatus);
      var response = await client.get(url, headers: requestHeaders);

      print(response.body);
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        List Results = data["cargos"];
        setState(() {
          _isLoading = false;
          Result = Results;
        });

        return Result;
      } else {
        throw Exception("not Loaded");
      }
    } catch (e) {
      print(e);
    }
  }

  // load  or unload  car using function
  Unloadandloadcar(String load) async {
    try {
      final storage = new FlutterSecureStorage();
      var value = await storage.read(key: 'jwt');

      Map data = {"driverState": load};
      var url = Uri.http(ApIConfig.urlAPI, ApIConfig.unload);
      var response =
          await http.put(url, body: jsonEncode(data) as String, headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Authorization": "Bearer $value",
      });
      final Map jsonResponse = json.decode(response.body);

      if (response.statusCode == 200) {
        String alertContent = jsonResponse["message"];

        alertforscuccess().showCustomToast(alertContent);
      } else {
        String alertContent = jsonResponse["message"];

        alertforeror().showCustomToast(alertContent);
      }
    } catch (e) {
      print(e);
    }
  }

  void initState() {
    super.initState();
    activecargoFetch();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Column(
        children: [
          Container(
            width: screenWidth,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(178, 142, 22, 1),
                  Color.fromRGBO(226, 193, 121, 1),
                ],
                // stops: [0.4, 0.4],
              ),
            ),
            padding: EdgeInsets.zero,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Ionicons.arrow_back,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Stack(children: [
            Container(
              height: screenHeight * 0.15,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromRGBO(178, 142, 22, 1),
                      Color.fromRGBO(226, 193, 121, 1),
                    ],
                    // stops: [0.4, 0.4],
                  ),
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(30),
                  )),
            ),
            Positioned(
                child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        height: screenHeight * 0.23,
                        width: screenWidth - 42,
                        child: Container(
                          margin: EdgeInsets.only(
                            top: screenWidth * 0.05,
                          ),
                          child: Column(
                            children: [
                              Container(
                                child: Center(
                                    child: Text("Package",
                                        textAlign: TextAlign.left,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            fontFamily: 'Nunito',
                                            fontSize: AppFonts.smallFontSize,
                                            color: Colors.black,
                                            fontWeight: FontWeight.normal))),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 30,
                                    child: StreamBuilder<List<dynamic>>(
                                      stream: fetchData(),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          final List<dynamic> data =
                                              snapshot.data!;

                                          return Container(
                                            child: data[0]["packaging"] == null
                                                ? Container()
                                                : Text(
                                                    (data[0]["packaging"]),
                                                    textAlign: TextAlign.left,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                        fontFamily: 'Nunito',
                                                        fontSize: AppFonts
                                                            .smallFontSize,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                          );
                                        } else if (snapshot.hasError) {
                                          return Container();
                                        } else {
                                          return Container();
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.trip_origin,
                                    color: Colors.green,
                                  ),
                                  CustomPaint(
                                    size: Size(screenWidth * 0.14, 2),
                                    painter: DashLinePainter(),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Container(
                                      height: screenHeight * 0.09,
                                      width: screenWidth * 0.09,
                                      child: Container(
                                        child: Icon(
                                          Icons.local_shipping,
                                          color: Colors.blue,
                                        ),
                                      ),
                                    ),
                                  ),
                                  CustomPaint(
                                    size: Size(screenWidth * 0.14, 2),
                                    painter: DashLinePainter(),
                                  ),
                                  Icon(
                                    Icons.trip_origin,
                                    color: Colors.red,
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                      height: 30,
                                      child: Center(
                                        child: StreamBuilder<List<dynamic>>(
                                          stream: fetchData(),
                                          builder: (context, snapshot) {
                                            if (snapshot.hasData) {
                                              final List<dynamic> data =
                                                  snapshot.data!;

                                              return Container(
                                                child: data[0]["pickUp"] == null
                                                    ? Container()
                                                    : Text(
                                                        (data[0]["pickUp"]),
                                                        textAlign:
                                                            TextAlign.left,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: const TextStyle(
                                                            fontFamily:
                                                                'Nunito',
                                                            fontSize: AppFonts
                                                                .smallFontSize,
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal),
                                                      ),
                                              );
                                            } else if (snapshot.hasError) {
                                              return Container();
                                            } else {
                                              return Container();
                                            }
                                          },
                                        ),
                                      )),
                                  SizedBox(
                                    width: screenWidth * 0.25,
                                  ),
                                  Container(
                                    height: 30,
                                    child: Center(
                                      child: StreamBuilder<List<dynamic>>(
                                        stream: fetchData(),
                                        builder: (context, snapshot) {
                                          if (snapshot.hasData) {
                                            final List<dynamic> data =
                                                snapshot.data!;
                                            // driverstatus =
                                            //     data["status"];

                                            // Render your UI with the data
                                            return Container(
                                              child: data[0]["dropOff"] == null
                                                  ? Container()
                                                  : Container(
                                                      margin: EdgeInsets.only(
                                                          left: 20),
                                                      child: Text(
                                                        data[0]["dropOff"],
                                                        textAlign:
                                                            TextAlign.center,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: const TextStyle(
                                                            fontFamily:
                                                                'Nunito',
                                                            fontSize: AppFonts
                                                                .smallFontSize,
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal),
                                                      ),
                                                    ),
                                            );
                                          } else if (snapshot.hasError) {
                                            return Container();
                                          } else {
                                            return Container();
                                          }
                                        },
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ))
          ]),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 255, 255, 255),
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black
                                      .withOpacity(0.3), // Shadow color
                                  blurRadius: 5, // Spread radius
                                  offset: Offset(
                                      0, 3), // Offset in (x,y) coordinates
                                ),
                                const BoxShadow(
                                  color: Colors.white,
                                  offset: Offset(-4, -4),
                                  blurRadius: 25,
                                  spreadRadius: 1,
                                ),
                              ]),
                          width: screenWidth * 0.44,
                          height: screenHeight * 0.1,
                          child: ElevatedButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) => YesNoDialog(
                                  title: 'Confirmation',
                                  message: 'Do you want to depparrive?',
                                  onYesPressed: () async {
                                    Unloadandloadcar("DEPARRIVE");
                                    // Navigator.of(context).pop();
                                  },
                                ),
                              );

                              setActiveButton(false);
                            },
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                                  if (!_isActivebutton) {
                                    return Color.fromRGBO(255, 255, 255, 1);
                                  } else {
                                    return Color.fromRGBO(255, 255, 255, 1);
                                  }
                                },
                              ),
                              foregroundColor:
                                  MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                                  if (!_isActivebutton) {
                                    return Colors.white;
                                  } else {
                                    return Colors.black;
                                  }
                                },
                              ),
                              elevation: MaterialStateProperty.all<double>(0),
                            ),
                            child: Text(
                              "DEPARRIVED",
                              textAlign: TextAlign.left,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontFamily: 'Nunito',
                                  fontSize: AppFonts.smallFontSize,
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal),
                            ),
                          ),
                        ),
                        Spacer(),
                        Container(
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 255, 255, 255),
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black
                                      .withOpacity(0.3), // Shadow color
                                  blurRadius: 5, // Spread radius
                                  offset: Offset(
                                      0, 3), // Offset in (x,y) coordinates
                                ),
                                const BoxShadow(
                                  color: Colors.white,
                                  offset: Offset(-4, -4),
                                  blurRadius: 25,
                                  spreadRadius: 1,
                                ),
                              ]),
                          width: screenWidth * 0.44,
                          height: screenHeight * 0.1,
                          child: ElevatedButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) => YesNoDialog(
                                  title: 'Confirmation',
                                  message: 'Do you want to  load?',
                                  onYesPressed: () async {
                                    Unloadandloadcar("LOAD");
                                    // Navigator.of(context).pop();
                                  },
                                ),
                              );

                              setActiveButton2(true);
                            },
                            child: Text(
                              "LOAD",
                              textAlign: TextAlign.left,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontFamily: 'Nunito',
                                  fontSize: AppFonts.smallFontSize,
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal),
                            ),
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                                  if (!_isActivebutton2) {
                                    return Color.fromRGBO(255, 255, 255, 1);
                                  } else {
                                    return Color.fromRGBO(255, 255, 255, 1);
                                  }
                                },
                              ),
                              foregroundColor:
                                  MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                                  if (!_isActivebutton2) {
                                    return Colors.white;
                                  } else {
                                    return Colors.black;
                                  }
                                },
                              ),
                              elevation: MaterialStateProperty.all<double>(0),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 255, 255, 255),
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black
                                      .withOpacity(0.3), // Shadow color
                                  blurRadius: 5, // Spread radius
                                  offset: Offset(
                                      0, 3), // Offset in (x,y) coordinates
                                ),
                                const BoxShadow(
                                  color: Colors.white,
                                  offset: Offset(-4, -4),
                                  blurRadius: 25,
                                  spreadRadius: 1,
                                ),
                              ]),
                          width: screenWidth * 0.44,
                          height: screenHeight * 0.1,
                          child: ElevatedButton(
                            onPressed: () {
                              setActiveButton(false);
                              showDialog(
                                context: context,
                                builder: (BuildContext context) => YesNoDialog(
                                  title: 'Confirmation',
                                  message: 'Do you want to  destarrive?',
                                  onYesPressed: () async {
                                    Unloadandloadcar("DESTARRIVE");
                                    // Navigator.of(context).pop();
                                  },
                                ),
                              );
                            },
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                                  if (!_isActivebutton) {
                                    return Color.fromRGBO(255, 255, 255, 1);
                                  } else {
                                    return Color.fromRGBO(255, 255, 255, 1);
                                  }
                                },
                              ),
                              foregroundColor:
                                  MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                                  if (!_isActivebutton) {
                                    return Colors.white;
                                  } else {
                                    return Colors.black;
                                  }
                                },
                              ),
                              elevation: MaterialStateProperty.all<double>(0),
                            ),
                            child: Text(
                              "DESTARRIVED",
                              textAlign: TextAlign.left,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontFamily: 'Nunito',
                                  fontSize: AppFonts.smallFontSize,
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal),
                            ),
                          ),
                        ),
                        Spacer(),
                        Container(
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 255, 255, 255),
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black
                                      .withOpacity(0.3), // Shadow color
                                  blurRadius: 5, // Spread radius
                                  offset: Offset(
                                      0, 3), // Offset in (x,y) coordinates
                                ),
                                const BoxShadow(
                                  color: Colors.white,
                                  offset: Offset(-4, -4),
                                  blurRadius: 25,
                                  spreadRadius: 1,
                                ),
                              ]),
                          width: screenWidth * 0.44,
                          height: screenHeight * 0.1,
                          child: ElevatedButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) => YesNoDialog(
                                  title: 'Confirmation',
                                  message: 'Do you want to  unload?',
                                  onYesPressed: ()  {
                                    Unloadandloadcar("UNLOAD");
                                      
                                    Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Driver_Hompage()),
          );
                                  },
                                ),
                              );
                              setActiveButton2(false);
                            },
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                                  if (!_isActivebutton2) {
                                    return Color.fromRGBO(255, 255, 255, 1);
                                  } else {
                                    return Color.fromRGBO(255, 255, 255, 1);
                                  }
                                },
                              ),
                              foregroundColor:
                                  MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                                  if (!_isActivebutton2) {
                                    return Colors.white;
                                  } else {
                                    return Colors.black;
                                  }
                                },
                              ),
                              elevation: MaterialStateProperty.all<double>(0),
                            ),
                            child: const Text(
                              "UNLOAD",
                              textAlign: TextAlign.left,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontFamily: 'Nunito',
                                  fontSize: AppFonts.smallFontSize,
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 255, 255, 255),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black
                                    .withOpacity(0.3), // Shadow color
                                blurRadius: 5, // Spread radius
                                offset:
                                    Offset(0, 3), // Offset in (x,y) coordinates
                              ),
                              const BoxShadow(
                                color: Colors.white,
                                offset: Offset(-4, -4),
                                blurRadius: 25,
                                spreadRadius: 1,
                              ),
                            ]),
                        width: screenWidth * 0.44,
                        height: screenHeight * 0.1,
                        child: ElevatedButton(
                          onPressed: () {
                            Unloadandloadcar('DEPARTURE');
                            setActiveButton(true);
                          },
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                                if (!_isActivebutton) {
                                  return Color.fromRGBO(255, 255, 255, 1);
                                } else {
                                  return Color.fromRGBO(255, 255, 255, 1);
                                }
                              },
                            ),
                            foregroundColor:
                                MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                                if (!_isActivebutton) {
                                  return Colors.white;
                                } else {
                                  return Colors.black;
                                }
                              },
                            ),
                            elevation: MaterialStateProperty.all<double>(0),
                          ),
                          child: Text(
                            "DEPARTURE",
                            textAlign: TextAlign.left,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontFamily: 'Nunito',
                                fontSize: AppFonts.smallFontSize,
                                color: Colors.black,
                                fontWeight: FontWeight.normal),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void showErrorSnackbar(BuildContext context, String errorMessage) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Container(height: 40, child: Center(child: Text(errorMessage))),
      backgroundColor: Color.fromRGBO(
          226, 193, 121, 1), // You can customize the background color here
      duration: Duration(seconds: 3),
      behavior: SnackBarBehavior.floating, // Use a floating behavior
      padding: EdgeInsets.all(10), // Adjust the duration as per your preference
    ),
  );
}

// alert diagloug
class YesNoDialog extends StatefulWidget {
  final String title;
  final String message;
  final Function onYesPressed;

  YesNoDialog({
    required this.title,
    required this.message,
    required this.onYesPressed,
  });

  @override
  State<YesNoDialog> createState() => _YesNoDialogState();
}

class _YesNoDialogState extends State<YesNoDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: Text(widget.message),
      actions: <Widget>[
        ElevatedButton(
          onPressed: () async {
            widget.onYesPressed();
            Navigator.pop(context);
          },
          child: Text(
            'Yes',
            style: TextStyle(
                fontFamily: 'Nunito',
                fontSize: AppFonts.smallFontSize,
                color: Colors.black,
                fontWeight: FontWeight.normal),
          ),
          style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
            ),
            minimumSize: MaterialStateProperty.all(Size(5, 5)),
            backgroundColor: MaterialStateProperty.all(
              Color.fromRGBO(178, 142, 22, 1),
            ),
            shadowColor: MaterialStateProperty.all(
              Color.fromRGBO(178, 142, 22, 1),
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            'No',
            style: TextStyle(
                fontFamily: 'Nunito',
                fontSize: AppFonts.smallFontSize,
                color: Colors.black,
                fontWeight: FontWeight.normal),
          ),
        ),
      ],
    );
  }
}
