import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:ionicons/ionicons.dart';

import '../../../../../controller/Localization.dart';

class languageOption extends StatefulWidget {
  const languageOption({super.key});

  @override
  State<languageOption> createState() => _languageOptionState();
}

class _languageOptionState extends State<languageOption> {
  TextEditingController englishcontoller = TextEditingController();
  TextEditingController amahariccontoller = TextEditingController();
  TextEditingController afanoromocontoller = TextEditingController();
  bool isSelect = false;
  bool isamaharic = false;
  bool _isChecked = true;
  bool isafanoromo = false;
  String? alertType;
  int selectedIndex = -1;
  var locale;
  List<String> type = [
    "Amahric",
    "Afaan oromo",
    "English",
  ];
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    final TranslationController controller = Get.put(TranslationController());
    print(Locale('hi', 'IN'));

    return Scaffold(
      body: Container(
        height: screenHeight,
        margin: EdgeInsets.only(top: screenHeight * 0.1),
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Ionicons.arrow_back)),
                Container(
                    margin: EdgeInsets.only(left: screenWidth * 0.1),
                    child: Text(
                      TranslationUtil.text('Language'),
                      style: const TextStyle(
                          fontFamily: 'Nunito',
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    )),
              ],
            ),
            Container(
              height: screenHeight * 0.6,
              child: ListView.builder(
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return Container(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            SizedBox(
                                height: screenHeight * 0.1,
                                width: screenWidth - 32,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.2),
                                        spreadRadius: 2,
                                        blurRadius: 5,
                                        offset: Offset(0,
                                            4), // Adjust the offset to control the shadow's position
                                      ),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(children: [
                                      SizedBox(
                                        width: 4,
                                      ),
                                      Container(
                                        height: screenHeight * 0.02,
                                        width: screenWidth * 0.04,
                                        child: Transform.scale(
                                          scale: 1.6,
                                          child: Radio(
                                            value: index,
                                            groupValue: selectedIndex,
                                            onChanged: (value) {
                                              setState(() {
                                                selectedIndex = value!;
                                                alertType = type[index];

                                                if (alertType ==
                                                    "Afaan oromo") {
                                                  locale = 'a_OR';
                                                } else if (alertType ==
                                                    "Amahric") {
                                                  locale = 'am_AM';
                                                } else {
                                                  locale = 'en_us';
                                                }

                                                final translationController =
                                                    Get.put(
                                                        TranslationController());
                                                translationController
                                                    .loadTranslations(locale);
                                                Get.updateLocale(
                                                    Locale(locale));
                                                _isChecked = false;
                                              });
                                            },
                                          ),
                                        ),
                                      ),
                                      // Checkbox(
                                      //     activeColor: Colors.green,
                                      //     shape: CircleBorder(),
                                      //     value: isafanoromo,
                                      //     onChanged: ((value) {
                                      //       setState(() {

                                      //       });
                                      //     })),
                                      SizedBox(width: screenWidth * 0.05),
                                      Align(
                                        alignment: Alignment.bottomCenter,
                                        child: Container(
                                            height: screenHeight * 0.053,
                                            child: Text(
                                              type[index],
                                              style: const TextStyle(
                                                  fontFamily: 'Nunito',
                                                  fontSize: 14,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                            )),
                                      )
                                    ]),
                                  ),
                                ))
                          ],
                        ),
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
