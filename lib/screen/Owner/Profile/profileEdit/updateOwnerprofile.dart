import 'dart:convert';
import 'dart:io';
import 'package:bazralogin/Theme/Alert.dart';
import 'package:bazralogin/Theme/TextInput.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ionicons/ionicons.dart';
import 'package:http/http.dart' as http;
import '../../../../config/APIService.dart';
import '../../../../const/constant.dart';
import '../../Driver/assignDriver.dart';

class ownerprofileUpadate extends StatefulWidget {
  String? image;
  String? email;
  String? phone;
  String? datebirth;
  String? gender;
  String? name;
  String? woredas;
  String? notificationmedia;
  String? houseNumbers;
  ownerprofileUpadate({
    super.key,
    this.image,
    this.email,
    this.phone,
    this.datebirth,
    this.name,
    this.gender,
    this.woredas,
    this.houseNumbers,
    this.notificationmedia,
  });

  @override
  State<ownerprofileUpadate> createState() => _ownerprofileUpadateState();
}

List<String> list = <String>[
  "Addis Ababa",
  "Afar",
  "Amhara",
  "Benishangul-Gumuz",
  "Dire Dawa",
  "Gambela",
  "Harari",
  "Oromia",
  "Sidama",
  "Somali",
  "Southern Nations, Nationalities, and Peoples' Region (SNNPR)",
  "Tigray"
];
String dropdownValue = "Addis Ababa";

class _ownerprofileUpadateState extends State<ownerprofileUpadate> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController password = TextEditingController();
  bool isHiddenPassword = true;
  String Logoavtar = "";
  String ownerpic = "";
  bool isLoading = false;
  PickedFile? _pickedImage;
  final housenumber = TextEditingController();
  final woreda = TextEditingController();
  final notificationmidia = TextEditingController();
  final city = TextEditingController();
  final speficcity = TextEditingController();
  final region = TextEditingController();
  final subcity = TextEditingController();

  final ImagePicker _picker = ImagePicker();

  void isPasswordView() {
    setState(() {
      isHiddenPassword = !isHiddenPassword;
    });
  }

  String? owneriamg;

  void takePicture(ImageSource source) async {
    final XFile? image =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      owneriamg = File(image!.path).path;
    });
  }

  registerDriver(String? pickedImage) async {
    var value = await storage.read(key: 'jwt');

    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization": "Bearer $value",
    };
    var url = Uri.http(ApIConfig.urlAPI, ApIConfig.ownerinfoupdate);
    final formData = http.MultipartRequest(
      'PUT',
      url,
    );
    formData.headers['Authorization'] = "Bearer $value";

    formData.files.add(
      await http.MultipartFile.fromPath('vehicleOwnerPic', pickedImage!),
    );
    formData.fields['region'] = "Akaki";
    formData.fields['subCity'] = "Akaki ";
    formData.fields['specificLocation'] = speficcity.text;
    formData.fields['city'] = city.text;
    formData.fields['woreda'] = '${dropdownValue}';
    formData.fields["houseNumber"] = housenumber.text;
    formData.fields["notificationmedia"] = '${widget.notificationmedia}';
    formData.fields["serviceRequired"] = 'TECH';
    print("yared12222 992900");
    print(
        "/data/user/0/com.example.bazralogin/cache/0e681c23-32a7-4b98-9dbd-ba18c4f8e2c6/Screenshot_20230502-041436.png");

    final response = await formData.send();
    var responseData = await response.stream.bytesToString();
    var decodedResponse = json.decode(responseData);

    if (response.statusCode == 200) {
      String alertContent = decodedResponse["message"];

      alertutilsfordriver.showMyDialog(context, "Alert", alertContent);
    } else {
      // String alertContent = decodedResponse["message"];

      // throw Exception(
      //     'Failed load data with status code ${response.statusCode}');
      print("no");
    }
  }

  void performAction() {
    setState(() {
      isLoading = true;
    });

    // Simulate an asynchronous action
    Future.delayed(Duration(seconds: 15), () async {
      var value = await storage.read(key: 'jwt');
      Map data = {
        "region": "ksdiweoi",
        "subCity": "sfwrwe",
        "specificLocation": "sffsdf",
        "city": "fwrfwerwe",
        "woreda": "${dropdownValue}",
        "houseNumber": "${housenumber.text}",
        "notificationmedia": "${notificationmidia.text}",
        "serviceRequired": "EXCELLENT"
      };
      var response = await http.put(
          Uri.parse("http://164.90.174.113:9090/Api/Vehicle/UpdateInfo"),
          body: json.encode(data),
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": "Bearer $value",
          });

      if (response.statusCode == 200) {
        var decodedResponse = json.decode(response.body);
        String alertContent = decodedResponse["message"];
        alertutils.showMyDialog(context, "Alert", alertContent);
      }
      setState(() {
        isLoading = false;
      });
    });
  }

  Future<Map<String, dynamic>> _fetchLogo() async {
    var client = http.Client();
    final storage = new FlutterSecureStorage();
    var token = await storage.read(key: 'jwt');
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    var url = Uri.http(ApIConfig.urlAPI, ApIConfig.ownerInfo);
    final response = await http.get(url, headers: requestHeaders);
    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON.
      var ownerinfo = json.decode(response.body);
      Map<String, dynamic> data = ownerinfo["ownerINF"];

      return data;
    } else {
      throw Exception('Failed to load image');
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    String readOnlyText = "${widget.name}";
    String email = "${widget.email}";
    String date = "${widget.datebirth}";
    String genderowner = "${widget.gender}";
    String phonenumber = "${widget.phone}";
    print("${widget.houseNumbers}");

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(top: height * 0.06, right: 10),
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Ionicons.arrow_back,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              height: height * 0.15,
              child: Stack(
                children: [
                  Positioned(
                      left: width * 0.3,
                      height: height * 0.15,
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              CircleAvatar(
                                radius: 51,
                                backgroundColor: Colors.blueGrey,
                                child: CircleAvatar(
                                  radius: 48,
                                  backgroundImage: _pickedImage == null
                                      ? NetworkImage("${widget.image}")
                                      : FileImage(File(_pickedImage!.path))
                                          as ImageProvider,
                                ),
                              ),
                              Positioned(
                                left: 40,
                                child: Container(
                                  margin: EdgeInsets.only(top: height * 0.07),
                                  child: RawMaterialButton(
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext contex) {
                                            return AlertDialog(
                                              title: Text('Choose Option',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.lightBlue,
                                                  )),
                                              content: SingleChildScrollView(
                                                child: ListBody(children: [
                                                  InkWell(
                                                      onTap: () {
                                                        takePicture(
                                                            ImageSource.camera);
                                                      },
                                                      splashColor:
                                                          Colors.lightBlue,
                                                      child: Row(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Icon(
                                                              Icons.camera,
                                                              color: Colors
                                                                  .lightBlue,
                                                            ),
                                                          ),
                                                          Text('Camera',
                                                              style: TextStyle(
                                                                  fontSize: 18,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  color: Colors
                                                                          .grey[
                                                                      500]))
                                                        ],
                                                      )),
                                                  InkWell(
                                                      onTap: () {
                                                        takePicture(ImageSource
                                                            .gallery);
                                                      },
                                                      splashColor:
                                                          Colors.lightBlue,
                                                      child: Row(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Icon(
                                                              Icons
                                                                  .browse_gallery,
                                                              color: Colors
                                                                  .lightBlue,
                                                            ),
                                                          ),
                                                          Text('Galley',
                                                              style: TextStyle(
                                                                  fontSize: 18,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  color: Colors
                                                                          .grey[
                                                                      500]))
                                                        ],
                                                      )),
                                                  InkWell(
                                                      onTap: () {},
                                                      splashColor:
                                                          Colors.lightBlue,
                                                      child: Row(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Icon(
                                                              Icons
                                                                  .remove_circle,
                                                              color: Colors.red,
                                                            ),
                                                          ),
                                                          Text('Remove',
                                                              style: TextStyle(
                                                                  fontSize: 18,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  color: Colors
                                                                          .grey[
                                                                      500]))
                                                        ],
                                                      )),
                                                ]),
                                              ),
                                            );
                                          });
                                    },
                                    elevation: 10,
                                    fillColor: Colors.lightBlue,
                                    child: Icon(Icons.add_a_photo),
                                    shape: CircleBorder(),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      )),
                ],
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                margin: EdgeInsets.only(left: width * 0.04),
                child: Text(
                  "Name",
                  style: TextStyle(
                    fontFamily: "Nunito",
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    width: width - 32,
                    height: height * 0.08,
                    child: TextFormField(
                        enabled: false,
                        controller: TextEditingController(text: readOnlyText),
                        decoration: ThemeHelper().textInputDecoration(""))),
              ],
            ),
            SizedBox(height: 5),
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                margin: EdgeInsets.only(left: width * 0.04),
                child: Text(
                  "Email",
                  style: TextStyle(
                    fontFamily: "Nunito",
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    width: width - 32,
                    height: height * 0.08,
                    child: TextFormField(
                        enabled: false,
                        controller: TextEditingController(
                          text: email,
                        ),
                        decoration: ThemeHelper().textInputDecoration())),
              ],
            ),
            SizedBox(height: 5),
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                margin: EdgeInsets.only(left: width * 0.04),
                child: Text(
                  "Phone number",
                  style: TextStyle(
                    fontFamily: "Nunito",
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    width: width - 32,
                    height: height * 0.07,
                    child: TextFormField(
                        enabled: false,
                        controller: TextEditingController(text: phonenumber),
                        decoration: ThemeHelper().textInputDecoration())),
              ],
            ),
            SizedBox(height: 5),
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                margin: EdgeInsets.only(left: width * 0.04),
                child: Text(
                  "Gender",
                  style: TextStyle(
                    fontFamily: "Nunito",
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    width: width - 32,
                    height: height * 0.08,
                    child: TextFormField(
                        enabled: false,
                        controller: TextEditingController(text: genderowner),
                        decoration: ThemeHelper().textInputDecoration())),
              ],
            ),
            SizedBox(height: 5),
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                margin: EdgeInsets.only(left: width * 0.04),
                child: Text(
                  "Birth Date",
                  style: TextStyle(
                    fontFamily: "Nunito",
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    width: width - 32,
                    height: height * 0.08,
                    child: TextFormField(
                        enabled: false,
                        controller: TextEditingController(text: date),
                        decoration: ThemeHelper().textInputDecoration())),
              ],
            ),
            SizedBox(height: 5),
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                margin: EdgeInsets.only(left: width * 0.04),
                child: Text(
                  "Woreda",
                  style: TextStyle(
                    fontFamily: "Nunito",
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: width - 32,
                  height: height * 0.07,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                    child: DropdownButtonFormField<String>(
                      value: dropdownValue,
                      icon: const Icon(Icons.arrow_drop_down),
                      elevation: 16,
                      style: const TextStyle(color: Colors.grey),
                      isExpanded: true,
                      borderRadius: BorderRadius.circular(20),
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        // contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey.shade400, width: 2),
                        ),
                        // Specify border color and width
                        disabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade400),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey.shade400, width: 2),
                          borderRadius: BorderRadius.circular(6.0),
                        ), // Hide the underline
                      ),
                      onChanged: (String? newValue) {
                        // This is called when the user selects an item.
                        if (newValue != null) {
                          // Update the selected value when an option is chosen
                          dropdownValue = newValue;
                        }
                      },
                      items: list.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 5),
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                margin: EdgeInsets.only(left: width * 0.04),
                child: Text(
                  "Notificationmedia",
                  style: TextStyle(
                    fontFamily: "Nunito",
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    width: width - 32,
                    height: height * 0.08,
                    child: TextFormField(
                        controller: notificationmidia,
                        decoration: ThemeHelper().textInputDecoration(
                            "${widget.notificationmedia}"))),
              ],
            ),
            SizedBox(height: 5),
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                margin: EdgeInsets.only(left: width * 0.04),
                child: Text(
                  "HouseNumber",
                  style: TextStyle(
                    fontFamily: "Nunito",
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    width: width - 32,
                    height: height * 0.08,
                    child: TextFormField(
                        controller: housenumber,
                        decoration: ThemeHelper()
                            .textInputDecoration("${widget.houseNumbers}"))),
              ],
            ),
            SizedBox(height: height * 0.03),
            Container(
              width: width - 20,
              margin: EdgeInsets.only(bottom: 20),
              height: height * 0.06,
              child: ElevatedButton(
                  onPressed: () {
                    registerDriver(owneriamg);
                  },
                  child: Container(
                    height: 55,
                    width: width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        isLoading
                            ? SizedBox(
                                height: 24,
                                width: 24,
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white),
                                ),
                              )
                            : SizedBox(), // Empty SizedBox if not loading
                        SizedBox(width: 8),
                        Text(
                          isLoading ? 'Please Wait' : 'Update',
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: "Nunito",
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.normal,
                              fontSize: AppFonts.smallFontSize),
                        )
                      ],
                    ),
                  ),
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.resolveWith((states) {
                        if (states.contains(MaterialState.pressed)) {
                          return Color.fromRGBO(255, 148, 165, 223);
                        }
                        // 98, 172, 181
                        return Color.fromRGBO(178, 142, 22, 1);
                      }),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6))))),
            ),
          ],
        ),
      ),
    );
  }
}
