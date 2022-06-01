import 'package:flutter/material.dart';

class AddSnippetFragment extends StatefulWidget {
  const AddSnippetFragment({Key? key}) : super(key: key);

  @override
  State<AddSnippetFragment> createState() => _AddSnippetFragmentState();
}

class _AddSnippetFragmentState extends State<AddSnippetFragment> {

  // Initial Selected Value
  String dropdownvalue = 'C++';  

  var dropdownItems = ["C++", "JavaScript", "Python"];
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:[
              DropdownButton(
                // Initial Value
                value: dropdownvalue,
                items: dropdownItems.map((String items) {
                  return DropdownMenuItem(
                    value: items,
                    child: Text(items),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                setState(() {
                  dropdownvalue = newValue!;
                });
              },
              )
            ]
          )
        )
      )
    );
  }
}