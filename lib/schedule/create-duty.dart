import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import 'package:nfc_counter/widgets/city-selector.dart';
import 'package:nfc_counter/schedule/group-select.dart';

class CreateDuty extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CreateDutyState();
  }
}

class CreateDutyState extends State<CreateDuty> {
  late String _duty_name;
  late String _duty_description;
  late String _admin_name;
  late String _admin_email;
  late String _adminphoneNumber;

  String countryValue = "";
  String stateValue = "";
  String cityValue = "";
  String address = "";

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  static const List<String> states = <String>['Maharashtra', 'Haryana', 'Gujurat', 'Punjab','Tamil Nadu','Karnataka','Andhra Pradesh','Goa','Uttar Pradesh','Delhi'];
  static const List<String> cities = <String>['Mumbai','Nashik','Aurangabad','Nagpur','Kolhpaur','Pune','Amravati','Solapur','Jalgaon'];

  Widget _buildName() {
    return TextFormField(
      decoration: const InputDecoration(labelText: 'Enter Duty Name'),
      maxLength: 10,
      validator: (String? value) {
        if(value == null){
          return null;
        }
        if (value.isEmpty) {
          return 'Name is Required';
        }
        return null;
      },
      onSaved: (String? value) {
        _duty_name = value!;
      },
    );
  }

  Widget _buildDescription() {
    return TextFormField(
      decoration: const InputDecoration(labelText: 'Enter Duty Description'),
      maxLength: 200,
      validator: (String? value) {
        if(value == null){
          return null;
        }
        if (value.isEmpty) {
          return 'Description is Required';
        }
        return null;
      },
      onSaved: (String? value) {
        _duty_description = value!;
      },
    );
  }

  Widget _buildAdminName() {
    return TextFormField(
      decoration: const InputDecoration(labelText: 'Enter Admin Name'),
      maxLength: 10,
      validator: (String? value) {
        if(value == null){
          return null;
        }
        if (value.isEmpty) {
          return 'Admin Name is Required';
        }
        return null;
      },
      onSaved: (String? value) {
        _admin_name = value!;
      },
    );
  }

  Widget _buildEmail() {
    return TextFormField(
      decoration: const InputDecoration(labelText: 'Enter Admin email'),
      validator: (String? value) {
        if(value == null){
          return null;
        }
        if (value.isEmpty) {
          return 'Email is Required';
        }

        if (!RegExp(
                r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
            .hasMatch(value)) {
          return 'Please enter a valid email Address';
        }

        return null;
      },
      onSaved: (String? value) {
        _admin_email = value!;
      },
    );
  }

  Widget _buildPhoneNumber() {
    return TextFormField(
      decoration: const InputDecoration(labelText: 'Admin Contact number'),
      keyboardType: TextInputType.phone,
      maxLength: 12,
      validator: (String? value) {
        if(value == null){
          return null;
        }
        if (value.isEmpty) {
          return 'Phone number is Required';
        }

        return null;
      },
      onSaved: (String? value) {
        _adminphoneNumber = value!;
      },
    );
  }

  Widget _buildStateSelector(){
    String dropdownValue = states.first;
    return  DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Color.fromARGB(255, 92, 91, 91)),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
        });
      },
      items: states.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  
  Widget _buildCitySelector(){
    String dropdownValue = cities.first;
    return  DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Color.fromARGB(255, 92, 91, 91)),
      
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
        });
      },
      items: cities.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Schedule a new duty")),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                _buildName(),
                _buildDescription(),
                _buildAdminName(),
                _buildEmail(),
                _buildPhoneNumber(),
                Align(
                    alignment: Alignment.centerLeft,
                    child:  _buildStateSelector(),
                    ),
                
                const SizedBox(height: 10),
                Align(
                    alignment: Alignment.centerLeft,
                    child:  _buildCitySelector(),
                    ),
                //CitySelector(),
                const SizedBox(height: 30),
                ElevatedButton(
                  child: const Text(
                    'Next',
                    style: TextStyle(color: Color.fromARGB(255, 248, 248, 248), fontSize: 16),
                  ),
                  onPressed: () {
                    if (!_formKey.currentState!.validate()) {
                      return;
                    }
                    _formKey.currentState!.save();
                    //Send to API
                     Navigator.push(context, MaterialPageRoute(builder:(context) {
                        return GroupSelect();
                      },));
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}