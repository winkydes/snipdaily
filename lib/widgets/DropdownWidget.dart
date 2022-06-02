import 'package:flutter/material.dart';

class DropdownWidget extends StatefulWidget {
  final List<String> dropdownList;
  const DropdownWidget({Key? key, required this.dropdownList})
      : super(key: key);

  @override
  State<DropdownWidget> createState() => _DropdownWidgetState();
}

class _DropdownWidgetState extends State<DropdownWidget> {
  static Color dropDownColor = const Color.fromARGB(255, 174, 123, 241);
  static const String selectDefault = "Select";
  String varValue = "Select";
  static const defaultItem = DropdownMenuItem<String>(
    value: selectDefault,
    child: Text("Select"),
  );

  @override
  Widget build(BuildContext context) {
    List<DropdownMenuItem<String>> widgetList =
        widget.dropdownList.map((String items) {
          return DropdownMenuItem<String>(
            value: items,
            child: Text(items),
          );
        }).toList();
    widgetList.insert(0, defaultItem);

    return (DecoratedBox(
      decoration: BoxDecoration(
          color: dropDownColor, //background color of dropdown button
          border: Border.all(
              color: Colors.black38, width: 2), //border of dropdown button
          borderRadius:
              BorderRadius.circular(20), //border raiuds of dropdown button
          boxShadow: const <BoxShadow>[
            //apply shadow on Dropdown button
            BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.57), //shadow for button
                blurRadius: 3) //blur radius of shadow
          ]),
      child: Padding(
          padding: const EdgeInsets.only(left: 30, right: 30),
          child: DropdownButton(
            value: varValue,
            items: widgetList,
            onChanged: (String? newValue) {
              setState(() {
                varValue = newValue!;
              });
            },
            icon: const Padding(
                padding: EdgeInsets.only(left: 20),
                child: Icon(Icons.arrow_drop_down)),
            iconEnabledColor: Colors.white,
            dropdownColor: dropDownColor,
            style: const TextStyle(
                color: Colors.white, //Font color
                fontSize: 20 //font size on dropdown button
                ),
            underline: Container(),
            isExpanded: true,
          )),
    ));
  }
}
