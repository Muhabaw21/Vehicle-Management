
import 'package:flutter/material.dart';

import '../../../../const/constant.dart';


class StartTrip extends StatefulWidget {
  const StartTrip({super.key, required String loc, required String plateNum});
 

  @override
  State<StartTrip> createState() => _StartTripState();
}


class _StartTripState extends State<StartTrip> {
  List<String> location = ['Adama', 'Jimma ', 'Gondar', 'Hawassa'];

  String? dropdownValue;
  String? plateNum;
  String? loc;
  @override
  Widget build(BuildContext context) {
    TextEditingController _searchController = TextEditingController();
    TextEditingController locate = TextEditingController();
    TextEditingController plateNumber = TextEditingController();

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 237, 237, 237),
      body: Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.fromLTRB(20, 80, 20, 0),
        // padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
                //  height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                // margin: EdgeInsets.fromLTRB(20, 50, 20, 0),
                padding: EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    //Text(plateNum),
                    TextFormField(
                      enabled: false,
                      controller: plateNumber,
                      cursorHeight: 25,
                      decoration: InputDecoration(
                        hintText: plateNum,

                      
                        hintStyle: TextStyle(
                          fontSize: 40,
                          color: Colors.black45,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                     
                        ),
                        // Based on passwordVisible state choose the ic
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    // Text(loc),
                    TextFormField(
                      enabled: false,
                      keyboardType: TextInputType.none,
                      cursorColor: Colors.black,
                      cursorHeight: 25,
                      controller: locate,
                      decoration: InputDecoration(
                        hintText: loc,
                        hintStyle: TextStyle(
                          color: Color.fromARGB(177, 0, 0, 0),
                          fontSize: 45,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        
                        ),
                        // Based on passwordVisible state choose the ic
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please Enter Your Current Location';
                        }
                        return null;
                      },
                      style: TextStyle(fontSize: 15, color: Colors.black),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      cursorColor: Colors.black,
                      cursorHeight: 25,
                      keyboardType: TextInputType.none,
                      decoration: InputDecoration(
                        hintText: 'Available date start from',

                        hintStyle: TextStyle(
                          color: Color.fromARGB(177, 0, 0, 0),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                       
                              
                        ),
                        // Based on passwordVisible state choose the ic
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please Enter Start Date';
                        }
                        return null;
                      },
                      style: TextStyle(fontSize: 15, color: Colors.black),
                    ),
                  ],
                )),
            Container(
              margin: EdgeInsets.only(top: 20),
              decoration: BoxDecoration(
                color: Color(0xff333333),
                borderRadius: BorderRadius.circular(20),
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color.fromARGB(255, 255, 253, 253),
                    Color.fromARGB(255, 242, 242, 242),
                  ],
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0xff515151),
                    offset: Offset(-5.0, 5.0),
                    blurRadius: 1,
                    spreadRadius: 0.0,
                  ),
                  BoxShadow(
                    color: kBackgroundColor,
                    offset: Offset(5.0, -5),
                    blurRadius: 1,
                    spreadRadius: 0.0,
                  ),
                ],
              ),
              width: 400,
              height: 400,
              child: Column(
                children: [
                  //Text("Destination"),
          Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          margin: EdgeInsets.only(top: 100),
          child: Column(
            children: [
              DropdownButton<String>(
                hint: Text('Select a Destination '),
                value: dropdownValue,
                icon: const Icon(Icons.search_sharp),
                iconSize: 24,
                elevation: 16,
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownValue = newValue!;
                  });
                },
                items: location.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              Container(
                height: 50,
                width: 100,
                padding: EdgeInsets.only(
                  right: 10,
                  left: 10,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    dropdownValue == null
                        ? Text(
                            'Please select a Country to Continue',
                            style:
                                TextStyle(fontSize: 16, color: Colors.blueGrey),
                          )
                        : Text(dropdownValue!,
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey.shade800,
                                fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
                  Row(
                    children: [],
                  )
                ],
              ),

              //search Text field
            ),
          ],
        ),
      ),
    );
  }

  }
