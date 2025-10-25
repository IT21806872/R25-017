import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'base_url.dart';
import 'diabetesData.dart';

class DiabetesFinder extends StatefulWidget {
  @override
  _DiabetesFinderState createState() => _DiabetesFinderState();
}

class _DiabetesFinderState extends State<DiabetesFinder> {
  TextEditingController ageController = TextEditingController();
  TextEditingController bmiController = TextEditingController();
  TextEditingController week8Controller = TextEditingController();
  TextEditingController ogttFastingController = TextEditingController();
  TextEditingController ogttOneHourController = TextEditingController();
  TextEditingController ogttTwoHourController = TextEditingController();

  String? selectedFHDiabetes;

  final yesNoOptions = ['Yes', 'No'];
  final fhDiabetesMap = {'No': 0, 'Yes': 1};

  bool isLoading = false;
  bool isFetching = true;

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        Fluttertoast.showToast(msg: "User not logged in");
        return;
      }

      var doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      if (!doc.exists) {
        Fluttertoast.showToast(msg: "User data not found");
        return;
      }

      var data = doc.data()!;

      setState(() {
        ageController.text =
            data['personalInformation']['age']?.toString() ?? '';
        bmiController.text =
            data['personalInformation']['bmi']?.toString() ?? '';
      });
    } catch (e) {
      Fluttertoast.showToast(msg: "Error fetching data: $e");
    }

    setState(() => isFetching = false);
  }

  Future<void> sendFormData() async {
    if (ageController.text.isEmpty ||
        bmiController.text.isEmpty ||
        selectedFHDiabetes == null ||
        week8Controller.text.isEmpty ||
        ogttFastingController.text.isEmpty ||
        ogttOneHourController.text.isEmpty ||
        ogttTwoHourController.text.isEmpty) {
      Fluttertoast.showToast(msg: "Please fill all fields");
      return;
    }

    setState(() => isLoading = true);

    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('$baseURL:1111/diabetes'),
      );

      request.fields['age_years'] = ageController.text;
      request.fields['bmi_prepreg'] = bmiController.text;
      request.fields['fh_diabetes'] =
          fhDiabetesMap[selectedFHDiabetes].toString();
      request.fields['Blood_suger_week_8'] = week8Controller.text;
      request.fields['Bloog_suger_OGTT_Fasting'] =
          ogttFastingController.text;
      request.fields['Blood_suger_OGTT_one_hour'] =
          ogttOneHourController.text;
      request.fields['Blood_suger_OGTT_two_hour'] =
          ogttTwoHourController.text;

      var response = await request.send();
      var responseString = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        var decoded = jsonDecode(responseString);
        String result = decoded["result"].toString();

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                DiabetesData(predictedValue: double.parse(result)),
          ),
        );
      } else {
        Fluttertoast.showToast(msg: "Server Error: ${response.statusCode}");
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Error: $e");
    }

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink.shade50,
      appBar: AppBar(
        title: Text("Diabetes Finder"),
        backgroundColor: Colors.pink.shade400,
      ),
      body: isFetching
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            buildTextField(
                ageController, "Age (years)", TextInputType.number),
            SizedBox(height: 16),
            buildTextField(bmiController, "Pre-pregnancy BMI",
                TextInputType.number),
            SizedBox(height: 16),
            buildDropdown(
                "Family History of Diabetes",
                yesNoOptions,
                selectedFHDiabetes,
                    (val) => setState(() => selectedFHDiabetes = val)),
            SizedBox(height: 16),
            buildTextField(week8Controller, "Blood Sugar Week 8",
                TextInputType.number),
            SizedBox(height: 16),
            buildTextField(ogttFastingController, "OGTT Fasting",
                TextInputType.number),
            SizedBox(height: 16),
            buildTextField(ogttOneHourController, "OGTT One Hour",
                TextInputType.number),
            SizedBox(height: 16),
            buildTextField(ogttTwoHourController, "OGTT Two Hour",
                TextInputType.number),
            SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: isLoading ? null : sendFormData,
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink.shade400,
                    padding: EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12))),
                child: isLoading
                    ? CircularProgressIndicator(color: Colors.white)
                    : Text("Predict Diabetes Risk",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildTextField(
      TextEditingController controller, String label, TextInputType type) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.grey.shade800,
          ),
        ),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          keyboardType: type,
          decoration: InputDecoration(
            hintText: "Enter $label",
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }

  Widget buildDropdown(
      String label, List<String> items, String? value, Function(String?) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.grey.shade800,
          ),
        ),
        const SizedBox(height: 6),
        DropdownButtonFormField<String>(
          value: value,
          hint: Text("Select $label"),
          isExpanded: true,
          items: items.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
          onChanged: onChanged,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }
}
