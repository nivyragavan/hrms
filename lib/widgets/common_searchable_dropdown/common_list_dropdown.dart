import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CommonListDropdown extends StatefulWidget {
  final List<String> items;
  final TextEditingController controller;
  final Function(dynamic) onChanged;
  CommonListDropdown(
      {Key? key,
      required this.items,
      required this.onChanged,
      required this.controller});

  @override
  State<CommonListDropdown> createState() => _CommonListDropdownState();
}

class _CommonListDropdownState extends State<CommonListDropdown> {
  final List<String> maritalStatusList = ["Married", "Single"];
  String? selectedMaritalStatus;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: DropdownButton<String>(
        value: selectedMaritalStatus,
        items: maritalStatusList.map((String status) {
          return DropdownMenuItem<String>(
            value: status,
            child: Text(status),
          );
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            selectedMaritalStatus = newValue;
          });
        },
      ),
    );
  }
}
