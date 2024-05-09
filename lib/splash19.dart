import 'package:flutter/material.dart';
import 'package:flutter_ruler_picker/flutter_ruler_picker.dart';
import 'package:yoga/Model/MyAppBar.dart';
import 'package:yoga/splash20.dart';

class splash19 extends StatefulWidget {
  const splash19({Key? key}) : super(key: key);

  @override
  _splash19State createState() => _splash19State();
}

class _splash19State extends State<splash19> {
  RulerPickerController? _rulerPickerController;
  num currentValue = 40;
  List<RulerRange> ranges = const [
    RulerRange(begin: 0, end: 200, scale: 0.1),
  ];
  bool selected = false;
  bool isKgSelected = true; // Đơn vị hiện tại là Kg

  @override
  void initState() {
    super.initState();
    _rulerPickerController = RulerPickerController(value: currentValue);
  }

  // Hàm chuyển đổi từ Kg sang Lb và ngược lại
  num convertWeight(num value, bool toKg) {
    if (toKg) {
      // Chuyển từ Lb sang Kg
      return value * 0.453592; // 1 Lb = 0.453592 Kg
    } else {
      // Chuyển từ Kg sang Lb
      return value / 0.453592; // 1 Kg = 2.20462 Lb
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        titleText: '03 BODY DATA',
        onSkipPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => splash20()),
          );
        },
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 20),
            Center(
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "What's your ",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: "target",
                      style: TextStyle(
                          color: Colors.purple,
                          fontSize: 20,
                          fontWeight:
                              FontWeight.bold), // Màu tím cho phần "current"
                    ),
                    TextSpan(
                      text: " weight?",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            ToggleButtons(
              isSelected: [isKgSelected, !isKgSelected],
              onPressed: (index) {
                setState(() {
                  isKgSelected =
                      index == 0; // Chọn Kg khi index == 0, ngược lại chọn Lb
                  // Thực hiện phép tính chuyển đổi giữa hai đơn vị
                  currentValue = convertWeight(currentValue, isKgSelected);
                });
              },
              children: [
                Text('Kg',
                    style: TextStyle(
                        color: isKgSelected ? Colors.white : Colors.black)),
                Text('Lb',
                    style: TextStyle(
                        color: !isKgSelected ? Colors.white : Colors.black)),
              ],
              color: Colors.grey[300],
              selectedColor: Colors.black,
              fillColor: Colors.grey[300],
              borderColor: Colors.grey[300],
              selectedBorderColor: Colors.black,
              borderRadius: BorderRadius.circular(8.0),
            ),
            Text(
              currentValue.toStringAsFixed(1),
              style: const TextStyle(
                color: Colors.purple,
                fontWeight: FontWeight.bold,
                fontSize: 80,
              ),
            ),
            const SizedBox(height: 50),
            RotatedBox(
              quarterTurns: 2,
              child: RulerPicker(
                controller: _rulerPickerController!,
                onBuildRulerScaleText: (index, value) {
                  return value.toInt().toString();
                },
                ranges: ranges,
                scaleLineStyleList: const [
                  ScaleLineStyle(
                      color: Colors.grey, width: 1.5, height: 30, scale: 0),
                  ScaleLineStyle(
                      color: Colors.grey, width: 1, height: 25, scale: 5),
                  ScaleLineStyle(
                      color: Colors.grey, width: 1, height: 15, scale: -1),
                ],
                onValueChanged: (value) {
                  setState(() {
                    currentValue = value;
                  });
                },
                width: MediaQuery.of(context).size.width * 0.8,
                height: 80,
                rulerMarginTop: 8,
              ),
            ),
            SizedBox(height: 40),
            Container(
              padding: EdgeInsets.all(26),
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.2,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Reasonable target",
                      style: TextStyle(fontSize: 22, color: Colors.green[700])),
                  Text(
                    "You will lose 4.2% of body weight",
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Moderate weight loss can also make a big difference:",
                    style: TextStyle(fontSize: 13, color: Colors.grey[700]),
                  ),
                  Text(
                    "- Lower blood pressure",
                    style: TextStyle(fontSize: 13, color: Colors.grey[700]),
                  ),
                  Text(
                    "- Reduce the risk of type 2 diabetes",
                    style: TextStyle(fontSize: 13, color: Colors.grey[700]),
                  )
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.08,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.08,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => splash20()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.black, // Màu nền của nút là đen
                  onPrimary: Colors.white, // Màu chữ của nút là trắng
                ),
                child: Text(
                  'Next',
                  style: TextStyle(
                      color: Colors.white), // Màu chữ của nút là trắng
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
