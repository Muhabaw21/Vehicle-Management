import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:bazralogin/Theme/Alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import '../../../Theme/TextInput.dart';
import '../../../Model/ApiConfig.dart';
import '../../../const/constant.dart';
import '../../../controller/apiController.dart';

class DriversFormOwner extends StatefulWidget {
  const DriversFormOwner({super.key});

  @override
  State<DriversFormOwner> createState() => _DriversFormOwnerState();
}

bool isHiddenPassword = true;
FilePickerResult? license;
var timer;

final storage = new FlutterSecureStorage();

class _DriversFormOwnerState extends State<DriversFormOwner> {
  String? _name;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final driverName = TextEditingController();
  final LicenseNumber = TextEditingController();
  final licensePic = TextEditingController();
  final driverPic = TextEditingController();
  final ownerPhone = TextEditingController();
  final driverPhone = TextEditingController();
  final dateBirth = TextEditingController();
  final Experience = TextEditingController();
  final LicenseGrade = TextEditingController();
  final Gender = TextEditingController();
  final dateIssue = TextEditingController();
  final dateExpire = TextEditingController();

  List Result = [];
  List<String> gendersatus = ["Male", "Female", "Select Gender"];
  final RegExp nameRegex = RegExp(r'^[A-Z][a-zA-Z\s]*$');
  String? selectedItem = "Select Gender";
  bool isLoading = false;

  Future<void> registerDriver(String driverFile, String licenseFile) async {
    var value = await storage.read(key: 'jwt');

    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization": "Bearer $value",
    };

    final formData = http.MultipartRequest(
      'POST',
      Uri.parse("http://164.90.174.113:9090/Api/Driver/AddDriver"),
    );
    formData.headers['Authorization'] = "Bearer $value";
    // final XFile? image =
    //     await ImagePicker().pickImage(source: ImageSource.gallery);
    formData.fields['driverName'] = driverName.text;
    formData.fields['licenseNumber'] = LicenseNumber.text;
    formData.fields['OwnerPhone'] = APIService.owner.toString();
    formData.fields['driverPhone'] = driverPhone.text;
    formData.fields['birthDate'] = dateBirth.text;
    formData.fields["experience"] = Experience.text;
    formData.fields["licenseGrade"] = LicenseGrade.text;
    formData.fields["gender"] = "$selectedItem";
    formData.fields["licenseIssueDate"] = dateIssue.text;
    formData.fields["licenseExpireDate"] = dateExpire.text;
    formData.files.add(
      await http.MultipartFile.fromPath('licensePic', licenseFile),
    );
    print("yared12222 992900");
    print(
        "/data/user/0/com.example.bazralogin/cache/0e681c23-32a7-4b98-9dbd-ba18c4f8e2c6/Screenshot_20230502-041436.png");
    print(licenseFile);
    print(driverFile);
    formData.files.add(
      await http.MultipartFile.fromPath('driverPic', driverFile),
    );
    setState(() {
      isLoading = true;
    });
    final response = await formData.send();
    var responseData = await response.stream.bytesToString();
    var decodedResponse = json.decode(responseData);
    final ApiController controller = Get.put(ApiController());
    if (response.statusCode == 200) {
      String alertContent = decodedResponse["message"];
      controller.fetchData();
      alertutils.showMyDialog(context, "Alert", alertContent);
    } else {
      String alertContent = decodedResponse["message"];
      alertutils.showMyDialog(context, "Alert", alertContent);
    }
  }

  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    driverName.dispose();
    dateBirth.dispose();
    driverPhone.dispose();
    driverPic.dispose();
    dateExpire.dispose();
    dateIssue.dispose();
    ownerPhone.dispose();
    Gender.dispose();
    licensePic.dispose();
    LicenseGrade.dispose();
    LicenseNumber
        .dispose(); // dispose of the controller when the widget is removed from the tree
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    print("${driverName}");

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color.fromRGBO(178, 142, 22, 1),
        title: Text(
          "Driver Registration",
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back,
              color: Colors.white), // Set the color of the icon
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: screenWidth - 32,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          cursorColor: Colors.black,
                          keyboardType: TextInputType.text,
                          controller: driverName,
                          decoration: ThemeHelper().textInputDecoration(
                            "Driver Name",
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your name';
                            }
                            if (!nameRegex.hasMatch(value)) {
                              return 'Name should start with a capital letter';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _name = value;
                          },
                          style: TextStyle(fontSize: 15, color: Colors.black),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        SizedBox(
                          child: TextFormField(
                            cursorColor: Colors.black,
                            keyboardType: TextInputType.text,
                            controller: LicenseGrade,
                            decoration: ThemeHelper()
                                .textInputDecoration("License Grade"),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please Enter Your License Grade';
                              }
                              return null;
                            },
                            style: TextStyle(fontSize: 15, color: Colors.black),
                          ),
                        ),

                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          width: screenWidth - 16,
                          child: DropdownButtonFormField<String>(
                              decoration: ThemeHelper().textInputDecoration(),
                              value: selectedItem,
                              items: gendersatus
                                  .map((item) => DropdownMenuItem<String>(
                                      value: item,
                                      child: Text(
                                        item,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w300,
                                            fontSize: 15),
                                      )))
                                  .toList(),
                              validator: (value) {
                                if (value == null) {
                                  return 'Please select an option';
                                }
                                return null;
                              },
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectedItem = newValue;
                                });

                                newValue:
                                selectedItem;
                              }),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        SizedBox(
                          child: TextFormField(
                            cursorColor: Colors.black,
                            cursorHeight: 25,
                            keyboardType: TextInputType.text,
                            controller: dateBirth,
                            decoration: ThemeHelper()
                                .textInputDecoration('Date Of Birth'),
                            onTap: () async {
                              DateTime? pickDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1980),
                                  lastDate: DateTime(2101));
                              if (pickDate != null) {
                                dateBirth.text =
                                    DateFormat('yyyy-MM-dd').format(pickDate);
                              }
                              return null;
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please Enter Your Date Of Birth';
                              }
                              return null;
                            },
                            style: TextStyle(fontSize: 15, color: Colors.black),
                          ),
                        ),

                        SizedBox(
                          height: 15,
                        ),
                        SizedBox(
                          child: TextFormField(
                            cursorColor: Colors.black,
                            cursorHeight: 25,
                            keyboardType: TextInputType.phone,
                            controller: driverPhone,
                            decoration:
                                ThemeHelper().textInputDecoration('Phone'),
                            validator: (value) {
                              if (value?.length != 10) {
                                return 'Please Enter Your Driver Phone Number Correctly';
                              }
                            },
                            style: TextStyle(fontSize: 15, color: Colors.black),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        SizedBox(
                          child: TextFormField(
                            cursorColor: Colors.black,
                            cursorHeight: 25,
                            keyboardType: TextInputType.text,
                            controller: Experience,
                            decoration:
                                ThemeHelper().textInputDecoration('Exprience'),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please Enter Your License Number';
                              }
                              return null;
                            },
                            style: TextStyle(fontSize: 15, color: Colors.black),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        SizedBox(
                          child: TextFormField(
                            cursorColor: Colors.black,
                            cursorHeight: 25,
                            keyboardType: TextInputType.text,
                            controller: LicenseNumber,
                            decoration: ThemeHelper()
                                .textInputDecoration('License Number'),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please Enter Your License Number';
                              }
                              return null;
                            },
                            style: TextStyle(fontSize: 15, color: Colors.black),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          child: TextFormField(
                            cursorColor: Colors.black,
                            cursorHeight: 25,
                            keyboardType: TextInputType.text,
                            controller: dateIssue,
                            onTap: () async {
                              DateTime? pickDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1980),
                                  lastDate: DateTime(2101));
                              if (pickDate != null) {
                                dateIssue.text =
                                    DateFormat('yyyy-MM-dd').format(pickDate);
                              }
                              return null;
                            },
                            decoration:
                                ThemeHelper().textInputDecoration("Issue Date"),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please Enter Issue Date';
                              }
                              return null;
                            },
                            style: TextStyle(fontSize: 15, color: Colors.black),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),

                        SizedBox(
                          child: TextFormField(
                            cursorColor: Colors.black,
                            cursorHeight: 25,
                            keyboardType: TextInputType.text,
                            controller: dateExpire,
                            onTap: () async {
                              DateTime? pickDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1980),
                                  lastDate: DateTime(2101));
                              if (pickDate != null) {
                                dateExpire.text =
                                    DateFormat('yyyy-MM-dd').format(pickDate);
                              }
                              return null;
                            },
                            decoration: ThemeHelper()
                                .textInputDecoration("Expire Date"),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please Enter Your Expire Date';
                              }
                              return null;
                            },
                            style: TextStyle(fontSize: 15, color: Colors.black),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        SizedBox(
                          child: TextFormField(
                            cursorColor: Colors.black,
                            cursorHeight: 25,
                            controller: licensePic,
                            keyboardType: TextInputType.url,
                            onTap: () async {
                              final XFile? image = await ImagePicker()
                                  .pickImage(source: ImageSource.gallery);

                              setState(() {
                                licensePic.text = File(image!.path).path;
                              });
                              print(licensePic.text);
                            },
                            decoration: ThemeHelper()
                                .textInputDecoration("Driver License"),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please Upload Your Driver License ';
                              }
                              return null;
                            },
                            style: TextStyle(fontSize: 15, color: Colors.black),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        SizedBox(
                          child: TextFormField(
                            cursorColor: Colors.black,
                            cursorHeight: 25,
                            controller: driverPic,
                            keyboardType: TextInputType.url,
                            onTap: () async {
                              final XFile? image = await ImagePicker()
                                  .pickImage(source: ImageSource.gallery);

                              setState(() {
                                image == null
                                    ? Container()
                                    : driverPic.text = File(image!.path).path;
                              });
                              print(driverPic.text);
                            },
                            decoration: ThemeHelper()
                                .textInputDecoration('Driver picture'),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please Upload Your Driver picture ';
                              }
                              return null;
                            },
                            style: TextStyle(fontSize: 15, color: Colors.black),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        //full name
                        Container(
                          margin: EdgeInsets.only(top: 15.0),
                          child: ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                registerDriver(licensePic.text, driverPic.text);
                              }
                            },
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.06,
                              child: Center(
                                child: const Text(
                                  " Register",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: "Nunito",
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.normal,
                                      fontSize: AppFonts.smallFontSize),
                                ),
                              ),
                            ),
                            style: ThemeHelper().buttonStyle(),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
