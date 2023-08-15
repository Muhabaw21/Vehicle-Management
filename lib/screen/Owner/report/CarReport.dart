
import 'package:bazralogin/const/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:intl/intl.dart';
import 'package:intl/intl.dart';
import 'package:date_format/date_format.dart';

import '../../../../Model/report.dart';



class Report extends StatefulWidget {
  const Report({super.key});
  @override
  State<Report> createState() => _ReportState();
}

class _ReportState extends State<Report> {
  TextEditingController _searchController = TextEditingController();
  // final DateRangePickerController _controller = DateRangePickerController();
  String _date = DateFormat('dd, MMMM yyyy').format(DateTime.now()).toString();

  bool valuefirst = false;
  List<ListOfPlate> find = [];

  List<ListOfPlate> profiles = [
    ListOfPlate(
      status: "accident",
      plateNumber: "34952",
      assignedDriver: "Solomon ",
      location: 'Addis Ababa',
      startDate: '12/01/2023',
      endDate: '19/01/2023',
    ),
    ListOfPlate(
      plateNumber: '45699',
      status: "Off Road",
      assignedDriver: "Abdu ",
      location: 'Bahir Dar',
      startDate: '12/01/2023',
      endDate: '18/01/2023',
    ),
    ListOfPlate(
      status: "accident",
      plateNumber: "94529",
      assignedDriver: "Luel Belay",
      location: 'Adama',
      startDate: '12/01/2023',
      endDate: '12/01/2023',
    ),
    ListOfPlate(
      status: "Off Road",
      plateNumber: "94529",
      assignedDriver: "Luel Belay",
      location: 'Gondar',
      startDate: '12/01/2023',
      endDate: '12/01/2023',
    ),
    ListOfPlate(
      status: "Driver",
      plateNumber: "94529",
      assignedDriver: "Luel Belay",
      location: 'Deber Markos',
      startDate: '12/01/2023',
      endDate: '12/01/2023',
    ),
    ListOfPlate(
      status: "accident",
      plateNumber: "94529",
      assignedDriver: "Luel Belay",
      location: 'Dire Dawa',
      startDate: '12/01/2023',
      endDate: '12/01/2023',
    ),
    ListOfPlate(
      status: "Driver",
      plateNumber: "94529",
      assignedDriver: "Luel Belay",
      location: 'Hawassa',
      startDate: '12/01/2023',
      endDate: '12/01/2023',
    ),
    ListOfPlate(
      status: "Off Road",
      plateNumber: "94529",
      assignedDriver: "Luel Belay",
      location: 'Arba Minch',
      startDate: '12/01/2023',
      endDate: '19/01/2023',
    ),
    ListOfPlate(
      status: "accident",
      plateNumber: "45699",
      assignedDriver: "Musse Hailu",
      location: 'Jijiga',
      startDate: '12/01/2023',
      endDate: '19/01/2023',
    ),
    ListOfPlate(
      status: "Off Road",
      plateNumber: "34952",
      assignedDriver: "Sofonias\n Muhabaw",
      location: 'Asosa',
      startDate: '12/01/2023',
      endDate: '18/01/2023',
    ),
  ];
  void checkStatus() {
    valuefirst = !valuefirst;
  }

  void initState() {
    super.initState();
    find = profiles;
  }

  TextEditingController dateBirth = TextEditingController();
  DateTimeRange? selectDateRange;

  List<ListOfPlate> currentList = [];
  _showDate() async {
    final DateTimeRange? result = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2022, 10, 1),
      lastDate: DateTime(2030, 12, 31),
      currentDate: DateTime.now(),
      saveText: "Confirm",
    );
    if (result != null) {
      // Prepare list

      setState(() {
        selectDateRange = result;
      });
    } else {
      return null;
    }
    List<ListOfPlate> tmp = [];
    currentList.clear();
    for (ListOfPlate c in profiles) {
      if (c.startDate.toString().contains(
              '${DateFormat('dd/MM/yyy').format(selectDateRange!.start)}'
                  .toString()) &&
          c.endDate.toString().toLowerCase().contains(
              '${DateFormat('dd/MM/yyy').format(selectDateRange!.end)}'
                  .toString())) {
        tmp.add(c);
      }
    }
    currentList = tmp;
    print('   ${DateFormat('dd/MM/yyy').format(selectDateRange!.start)}'
        .toString());
    print(currentList);
  }

  void driversSearch(String enterKeyboard) {
    setState(() {
      this.profiles = find;
    });
    if (enterKeyboard.isEmpty) {
      find = profiles;
    } else {
      final find = profiles.where((driver) {
        final name = driver.assignedDriver.toLowerCase();
        final license = driver.plateNumber.toLowerCase();
        final inputName = enterKeyboard.toLowerCase();
        final inputLicense = enterKeyboard.toLowerCase();
        return name.contains(inputName) || license.contains(inputLicense);
      }).toList();
      setState(() {
        this.profiles = find;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
          appBar: AppBar(
            toolbarHeight: MediaQuery.of(context).size.height * 0.09,
            backgroundColor: Colors.grey[500],
            automaticallyImplyLeading: false,
            elevation: 0,
            title: Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.7,
                height: MediaQuery.of(context).size.width * 0.116,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Container(
                  margin: const EdgeInsets.only(top: 0.0),
                  child: TextField(
                    onChanged: driversSearch,
                    controller: _searchController,
                    decoration: const InputDecoration(
                      suffixIcon: Icon(Icons.search_rounded),
                      border: InputBorder.none,
                      errorBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      contentPadding: EdgeInsets.only(top: 12, left: 16),
                      hintText: 'Driver Name or Plate No.',
                    ),
                  ),
                ),
              ),
            ),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () {
                      _showDate();
                    },
                    icon: Icon(Icons.calendar_month),
                    color: Colors.blue[600],
                    iconSize: 35,
                  ),
                ],
              )
            ],
          ),
          body: SingleChildScrollView(
              child: Container(
            // margin: EdgeInsets.zero,
            child: Column(
              children: [
                selectDateRange == null
                    ? GestureDetector(
                        onTap: () {
                          //   Navigator.pushNamed(context, AppRoutes.singleReport);
                        },
                        child: Column(
                            children: profiles.map((driver) {
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            child: GestureDetector(
                              onTap: () {
                                // Navigator.pushNamed(
                                //     context, AppRoutes.singleReport);
                              },
                              child: Card(
                                margin: EdgeInsets.zero,
                                elevation: 8,
                                
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  margin: EdgeInsets.only(left: 20, right: 20),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.14,
                                    height: MediaQuery.of(context).size.height *
                                        0.09,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          driver.assignedDriver,
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: kTextColor,
                                          ),
                                        ),
                                        Text(
                                          driver.plateNumber,
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: kTextColor,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.location_on,
                                              size: 15,
                                            ),
                                            SizedBox(
                                                child: Text(driver.location)),
                                          ],
                                        ),
                                        if (driver.status == 'accident')
                                          Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.05,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.19,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              color: Colors.red,
                                            ),
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: Text(
                                                driver.status,
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: kTextColor,
                                                ),
                                              ),
                                            ),
                                          )
                                        else if (driver.status == 'Off Road')
                                          Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.05,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.19,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              color: Colors.yellow,
                                            ),
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: Text(
                                                driver.status,
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: kTextColor,
                                                ),
                                              ),
                                            ),
                                          )
                                        else if (driver.status == 'Driver')
                                          Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.05,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.19,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              color: kPrimaryColor,
                                            ),
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: Text(
                                                driver.status,
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: kTextColor,
                                                ),
                                              ),
                                            ),
                                          )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }).toList()),
                      )
                    : Column(
                        children: currentList.map((driver) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          child: Card(
                            margin: EdgeInsets.zero,
                            elevation: 8,
                            shadowColor: Colors.black45,
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              padding: const EdgeInsets.all(6.0),
                              margin: const EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 2),
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.18,
                                height:
                                    MediaQuery.of(context).size.height * 0.09,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      driver.assignedDriver,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: kTextColor,
                                      ),
                                    ),
                                    Text(
                                      driver.plateNumber,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: kTextColor,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.location_on,
                                          size: 15,
                                        ),
                                        SizedBox(child: Text(driver.location)),
                                      ],
                                    ),
                                    if (driver.status == 'accident')
                                      Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.05,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.19,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: Colors.red,
                                        ),
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            driver.status,
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: kTextColor,
                                            ),
                                          ),
                                        ),
                                      )
                                    else if (driver.status == 'Off Road')
                                      Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.05,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.19,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: Colors.yellow,
                                        ),
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            driver.status,
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: kTextColor,
                                            ),
                                          ),
                                        ),
                                      )
                                    else if (driver.status == 'Driver')
                                      Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.05,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.19,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: kPrimaryColor,
                                        ),
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            driver.status,
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: kTextColor,
                                            ),
                                          ),
                                        ),
                                      )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList()),
              ],
            ),
          ))),
    );
  }
}
