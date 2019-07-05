import 'package:flutter/material.dart';

class CalculateWidget extends StatefulWidget {
  @override
  _CalculateWidgetState createState() => _CalculateWidgetState();
}

class _CalculateWidgetState extends State<CalculateWidget> {
  List<int> items = <int>[1, 2, 3, 4, 5];
  List<FocusNode> _focus = new List();
  List<TextEditingController> _controllers = new List();

  String textToShow = "";

  void sum() {
    int result = 0;
    for (var i = 0; i < items.length - 2; i++ ) {
      result += int.parse(_controllers[i].text);
    }
    setState(() {
      textToShow = "$result";
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          if (index != items.length - 1 && index != items.length - 2) {
            _focus.add(new FocusNode());
            _controllers.add(new TextEditingController());
            return TextFormField(
              decoration: InputDecoration(suffixText: "จำนวน.", hintText: "00.00"),
              textInputAction: TextInputAction.next,
              focusNode: _focus[index],
              onFieldSubmitted: (v) {
                FocusScope.of(context).requestFocus(_focus[index + 1]);
              },
              controller: _controllers[index],
            );
          } else if (index == items.length - 2) {
            return RaisedButton(
              child: Text("Submit"),
              onPressed: sum,
            );
          } else if (index == items.length - 1) {
            return Text(textToShow);
          }
        },
      ),
    );
  }
}
