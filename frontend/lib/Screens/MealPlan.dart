import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'meal_options_page.dart';
import 'base_url.dart';

class MealPlan extends StatefulWidget {
  @override
  _MealPlanState createState() => _MealPlanState();
}

class _MealPlanState extends State<MealPlan> {
  TextEditingController ageController = TextEditingController();

  int? selectedBMI;
  int? selectedTrimester;
  int? selectedEthnicity;
  int? selectedDiet;
  int? selectedAllergy;
  int? selectedDiabetes;
  int? selectedHighBp;
  int? selectedAnemia;

  bool isLoading = false;

  final Map<int, String> bmiOptions = {0: 'Normal', 1: 'Obese', 2: 'Overweight', 3: 'Underweight'};
  final Map<int, String> trimesterOptions = {0: '1', 1: '2', 2: '3'};
  final Map<int, String> ethnicityOptions = {0: 'Muslim', 1: 'Sinhala', 2: 'Tamil'};
  final Map<int, String> dietOptions = {0: 'Non-Vegetarian', 1: 'Vegetarian'};
  final Map<int, String> allergyOptions = {0: 'No', 1: 'Red meat', 2: 'Shellfish'};
  final Map<int, String> yesNoOptions = {0: 'No', 1: 'Yes'};
  final Map<int, String> anemiaOptions = {0: 'No', 1: 'Yes'};

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  Future<void> loadUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    try {
      DocumentSnapshot doc =
      await FirebaseFirestore.instance.collection("users").doc(user.uid).get();
      if (!doc.exists) return;

      var data = doc.data() as Map<String, dynamic>;

      ageController.text = data["personalInformation"]?["age"]?.toString() ?? "";

      double? bmi = (data["personalInformation"]?["bmi"] as num?)?.toDouble();
      if (bmi != null) {
        if (bmi < 18.5)
          selectedBMI = 3;
        else if (bmi < 25)
          selectedBMI = 0;
        else if (bmi < 30)
          selectedBMI = 2;
        else
          selectedBMI = 1;
      }

      String? eth = data["personalInformation"]?["ethnicity"];
      selectedEthnicity = ethnicityOptions.entries
          .firstWhere((e) => e.value == eth, orElse: () => MapEntry(0, 'Muslim'))
          .key;

      String? diet = data["lifestyle"]?["dietaryPreference"];
      selectedDiet = dietOptions.entries
          .firstWhere((e) => e.value == diet, orElse: () => MapEntry(0, 'Non-Vegetarian'))
          .key;

      selectedDiabetes = (data["medicalHistory"]?["diabetes"] == true) ? 1 : 0;
      selectedHighBp = (data["medicalHistory"]?["highBloodPressure"] == true) ? 1 : 0;
      selectedAnemia = (data["medicalHistory"]?["anemia"] == true) ? 1 : 0;

      bool? allergyS = data["healthInfo"]?["allergyShellfish"];
      bool? allergyR = data["healthInfo"]?["allergyRedMeat"];
      if (allergyS == true)
        selectedAllergy = 2;
      else if (allergyR == true)
        selectedAllergy = 1;
      else
        selectedAllergy = 0;

      String? pregDate = data["personalInformation"]?["pregnantDate"];
      if (pregDate != null && pregDate.isNotEmpty) {
        try {
          List<String> parts = pregDate.split("-");
          DateTime start = DateTime(
            int.parse(parts[2]),
            int.parse(parts[1]),
            int.parse(parts[0]),
          );
          int weeks = DateTime.now().difference(start).inDays ~/ 7;
          if (weeks < 13)
            selectedTrimester = 0;
          else if (weeks < 27)
            selectedTrimester = 1;
          else
            selectedTrimester = 2;
        } catch (_) {}
      }

      setState(() {});
    } catch (e) {
      Fluttertoast.showToast(msg: "⚠️ Failed to load profile: $e");
    }
  }

  Future<void> sendFormData() async {
    if (ageController.text.isEmpty ||
        selectedBMI == null ||
        selectedTrimester == null ||
        selectedEthnicity == null ||
        selectedDiet == null ||
        selectedDiabetes == null ||
        selectedHighBp == null ||
        selectedAllergy == null ||
        selectedAnemia == null) {
      Fluttertoast.showToast(msg: "Please fill all fields");
      return;
    }

    setState(() => isLoading = true);

    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('$baseURL:1111/main_meal'),
      );

      request.fields['age'] = ageController.text;
      request.fields['bmi'] = selectedBMI.toString();
      request.fields['trimester'] = selectedTrimester.toString();
      request.fields['ethnicity'] = selectedEthnicity.toString();
      request.fields['dietary_preference'] = selectedDiet.toString();
      request.fields['diabetes'] = selectedDiabetes.toString();
      request.fields['high_bp'] = selectedHighBp.toString();
      request.fields['allergies'] = selectedAllergy.toString();
      request.fields['anemia'] = selectedAnemia.toString();

      var response = await request.send();
      var responseString = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        var decoded = jsonDecode(responseString);
        int category = int.parse(decoded["main"].toString());
        String BF = decoded["BF"].toString();
        String MMS = decoded["MMS"].toString();
        String L = decoded["L"].toString();
        String ES = decoded["ES"].toString();
        String D = decoded["D"].toString();

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => MealOptionsPage(
              category: category,
              BF: BF,
              MMS: MMS,
              L: L,
              ES: ES,
              D: D,
            ),
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
        title: Text("Meal Plan"),
        backgroundColor: Colors.pink.shade400,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            buildTextField(ageController, "Age", TextInputType.number),
            SizedBox(height: 16),
            buildDropdown("BMI Category", bmiOptions, selectedBMI,
                    (val) => setState(() => selectedBMI = val)),
            buildDropdown("Trimester", trimesterOptions, selectedTrimester,
                    (val) => setState(() => selectedTrimester = val)),
            buildDropdown("Ethnicity", ethnicityOptions, selectedEthnicity,
                    (val) => setState(() => selectedEthnicity = val)),
            buildDropdown("Dietary Preference", dietOptions, selectedDiet,
                    (val) => setState(() => selectedDiet = val)),
            buildDropdown("Diabetes", yesNoOptions, selectedDiabetes,
                    (val) => setState(() => selectedDiabetes = val)),
            buildDropdown("High Blood Pressure", yesNoOptions, selectedHighBp,
                    (val) => setState(() => selectedHighBp = val)),
            buildDropdown("Anemia", anemiaOptions, selectedAnemia,
                    (val) => setState(() => selectedAnemia = val)),
            buildDropdown("Allergies", allergyOptions, selectedAllergy,
                    (val) => setState(() => selectedAllergy = val)),
            SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: isLoading ? null : sendFormData,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink.shade400,
                  padding: EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                child: isLoading
                    ? CircularProgressIndicator(color: Colors.white)
                    : Text(
                  "Predict Meal Plan",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
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
      String label, Map<int, String> options, int? value, Function(int?) onChanged) {
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
        DropdownButtonFormField<int>(
          value: value,
          hint: Text("Select $label"),
          items: options.entries
              .map((e) => DropdownMenuItem<int>(
            value: e.key,
            child: Text(e.value),
          ))
              .toList(),
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
