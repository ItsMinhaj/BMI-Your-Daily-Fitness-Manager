import 'package:d_chart/d_chart.dart';
import 'package:flutter/material.dart';

enum Gender {
  male,
  female,
}

class CustomForm extends StatefulWidget {
  const CustomForm({Key? key}) : super(key: key);

  @override
  _CustomFormState createState() => _CustomFormState();
}

class _CustomFormState extends State<CustomForm> {
  List heighScaleList = ["ft", "cm"];
  List weightScaleList = ["kg", "lbs"];
  var isHeightSelectedItem;
  var isWeigthSelectedItem;

  Gender? selectedGender;

  final _heightController = TextEditingController();
  final _inchController = TextEditingController();
  final _weightController = TextEditingController();
  final _ageController = TextEditingController();

  final _formkey = GlobalKey<FormState>();

  double? _bmi;
  String? _message = "Let's try";

  bool isCalculated = false;

  void reset() {
    _heightController.clear();
    _inchController.clear();
    _weightController.clear();
    _ageController.clear();
    setState(() {
      _message = "";
      _bmi = 0;
      isHeightSelectedItem = null;
      isWeigthSelectedItem = null;
      selectedGender = null;
    });
  }

  void _calculation() {
    double? height = double.tryParse(_heightController.value.text);
    double? inch = double.tryParse(_inchController.value.text);
    double? weight = double.tryParse(_weightController.value.text);

    setState(() {
      if (isHeightSelectedItem == "ft" && isWeigthSelectedItem == "kg") {
        height = (height! * 12) + inch!;
        weight = weight! * 2.20462;
        _bmi = (weight! / (height! * height!)) * 703;

        if (_bmi! < 18.5) {
          _message = "You are underweight";
        } else if (_bmi! < 25) {
          _message = 'Your body is fine';
        } else if (_bmi! < 30) {
          _message = 'You are overweight';
        } else {
          _message = 'You are obese';
        }
      } else if (isHeightSelectedItem == "cm" &&
          isWeigthSelectedItem == "lbs") {
        height = (height! * 0.01);
        weight = (weight! * 0.4535);

        _bmi = weight! / (height! * height!);

        if (_bmi! < 18.5) {
          _message = "You are underweight";
        } else if (_bmi! < 25) {
          _message = 'You body is fine';
        } else if (_bmi! < 30) {
          _message = 'You are overweight';
        } else {
          _message = 'You are obese';
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formkey,
      child: SizedBox(
        child: Column(
          children: [
            // Row one........
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _ageController,
                    textAlign: TextAlign.center,
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    decoration: const InputDecoration(
                      label: Center(child: Text("Age")),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    decoration: const InputDecoration(
                      label: Center(child: Text("Height")),
                    ),
                    controller: _heightController,
                  ),
                ),
                const Text("\'", style: TextStyle(fontSize: 28)),
                const SizedBox(width: 20),
                Expanded(
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    controller: _inchController,
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    decoration: const InputDecoration(
                      label: Center(child: Text("")),
                    ),
                  ),
                ),
                const Text("\"", style: TextStyle(fontSize: 28)),
                const SizedBox(width: 20),
                DropdownButton(
                  hint: const Text("ft"),
                  underline: const SizedBox(),
                  value: isHeightSelectedItem,
                  onChanged: (newValue) {
                    setState(() {
                      isHeightSelectedItem = newValue;
                    });
                  },
                  items: heighScaleList.map((value) {
                    return DropdownMenuItem(
                        value: value,
                        child: Text(
                          value.toString(),
                          style: const TextStyle(
                              color: Colors.deepOrange,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ));
                  }).toList(),
                )
              ],
            ),
            // Row Two.......
            const SizedBox(height: 20),
            SizedBox(
              height: 60,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedGender = Gender.male;
                          });
                        },
                        child: Image.asset(
                          "assets/icon/man.png",
                          color: selectedGender == Gender.male
                              ? Colors.red
                              : Colors.grey,
                        )),
                  ),
                  const Text(
                    "|",
                    style: TextStyle(fontSize: 40, color: Colors.grey),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedGender = Gender.female;
                          });
                        },
                        child: Image.asset(
                          "assets/icon/female.png",
                          color: selectedGender == Gender.female
                              ? Colors.red
                              : Colors.grey,
                        )),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      controller: _weightController,
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      decoration: const InputDecoration(
                        label: Text(
                          "Weight",
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  DropdownButton(
                    hint: const Text("kg"),
                    underline: const SizedBox(),
                    value: isWeigthSelectedItem,
                    onChanged: (newValue) {
                      setState(() {
                        isWeigthSelectedItem = newValue;
                      });
                    },
                    items: weightScaleList.map((value) {
                      return DropdownMenuItem(
                          value: value,
                          child: Text(
                            value.toString(),
                            style: const TextStyle(
                                color: Colors.deepOrange,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ));
                    }).toList(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // SizedBox(
            //   height: 200,
            //   width: double.infinity,
            //   child: DChartGauge(
            //     data: const [
            //       {'domain': '16.0 - 18.4', 'measure': 0},
            //       {'domain': 'Underweight', 'measure': 35},
            //       {'domain': 'Normal', 'measure': 30},
            //       {'domain': '18.0 - 24.9', 'measure': 0},
            //       {'domain': 'Overweight', 'measure': 35},
            //       {'domain': '25.0 - 40.0', 'measure': 0},
            //     ],
            //     fillColor: (pieData, index) {
            //       switch (pieData['domain']) {
            //         case 'Underweight':
            //           return Colors.green;
            //         case 'Normal':
            //           return Colors.orange;
            //         default:
            //           return Colors.red;
            //       }
            //     },
            //     showLabelLine: false,
            //     pieLabel: (pieData, index) {
            //       return "${pieData['domain']}";
            //     },
            //     labelPosition: PieLabelPosition.outside,
            //     labelPadding: 0,
            //     labelColor: Colors.red,
            //     labelFontSize: 14,
            //     labelLineThickness: 4,
            //   ),
            // ),

            SizedBox(
              child: Center(
                child: Column(
                  children: [
                    Container(
                      height: 80,
                      width: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.deepOrange.shade200,
                      ),
                      child: Center(
                        child: Text(
                          _bmi == null ? 'No Result' : _bmi!.toStringAsFixed(1),
                          style: const TextStyle(fontSize: 28),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Text(
                      _message == null ? "" : _message.toString(),
                      style: const TextStyle(fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                    width: 120,
                    child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            isCalculated = true;
                          });

                          _calculation();
                          // reset();
                        },
                        child: const Text("Calculate"))),
                const SizedBox(width: 30),
                SizedBox(
                    width: 120,
                    child: OutlinedButton.icon(
                      label: const Text("Reset"),
                      onPressed: () {
                        reset();
                      },
                      icon: const Icon(Icons.restore),
                    )),
              ],
            ),

            DataTable(columns: const [
              DataColumn(label: Text("Health States")),
              DataColumn(label: Text("values")),
            ], rows: const [
              DataRow(cells: [
                DataCell(Text("Very Severely Underweight")),
                DataCell(Text("<= 15.9")),
              ]),
              DataRow(cells: [
                DataCell(Text("Severly Underweight")),
                DataCell(Text("16.0 - 16.9")),
              ]),
              DataRow(cells: [
                DataCell(Text("Underweight")),
                DataCell(Text("17.0 - 18.4")),
              ]),
              DataRow(cells: [
                DataCell(Text("Normal")),
                DataCell(Text("18.5 - 24.9")),
              ]),
              DataRow(cells: [
                DataCell(Text("Overweight")),
                DataCell(Text("25.0 - 29.9")),
              ]),
              DataRow(cells: [
                DataCell(Text("Obese Class I")),
                DataCell(Text("30.0 - 34.9")),
              ]),
              DataRow(cells: [
                DataCell(Text("Obese Class II")),
                DataCell(Text("35.0 - 39.9")),
              ]),
              DataRow(cells: [
                DataCell(Text("Obese Class III")),
                DataCell(Text(">= 40.0")),
              ]),
            ])
          ],
        ),
      ),
    );
  }
}
