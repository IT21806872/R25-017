import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'RecommendationPage.dart';
import 'base_url.dart';

class AutoRisk extends StatefulWidget {
  @override
  _AutoRiskState createState() => _AutoRiskState();
}

class _AutoRiskState extends State<AutoRisk> {
  String? riskLevel;
  bool isLoading = true;
  String? userId;

  @override
  void initState() {
    super.initState();
    _loadUserIdAndPredict();
  }

  Future<void> _loadUserIdAndPredict() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? uid = prefs.getString('userid');

      if (uid == null) {
        Fluttertoast.showToast(msg: "No user ID found in SharedPreferences");
        setState(() => isLoading = false);
        return;
      }

      setState(() => userId = uid);
      await _fetchAndPredictRisk(uid);
    } catch (e) {
      Fluttertoast.showToast(msg: "Error loading user ID: $e");
      setState(() => isLoading = false);
    }
  }

  Future<void> _fetchAndPredictRisk(String uid) async {
    try {
      DocumentSnapshot snapshot =
      await FirebaseFirestore.instance.collection("users").doc(uid).get();

      if (!snapshot.exists) {
        Fluttertoast.showToast(msg: "No user data found");
        setState(() => isLoading = false);
        return;
      }

      var data = snapshot.data() as Map<String, dynamic>;
      var personal = data["personalInformation"] ?? {};
      var medical = data["medicalHistory"] ?? {};
      var health = data["healthInfo"] ?? {};
      var prePregnancy = data["prePregnancy"] ?? {};

      var request = http.MultipartRequest(
        'POST',
        Uri.parse('$baseURL:1111/risk'),
      );

      request.fields['age'] = (personal["age"] ?? 0).toString();
      request.fields['bmi'] = (personal["bmi"] ?? 0).toString();
      request.fields['previous_complications'] =
      (prePregnancy["previousComplications"] == true) ? "1" : "0";
      request.fields['preexisting_diabetes'] =
      (medical["diabetes"] == true) ? "1" : "0";
      request.fields['bp'] =
      (medical["highBloodPressure"] == true) ? "1" : "0";
      request.fields['blood_sugar'] =
      (medical["diabetes"] == true) ? "1" : "0";

      String heartRateVal = "1";
      if (health["heartRate"] != null) {
        int hr = int.tryParse(health["heartRate"].toString()) ?? 0;
        if (hr > 100) heartRateVal = "2"; // High
        else if (hr < 60) heartRateVal = "3"; // Low
        else heartRateVal = "1"; // Normal
      }
      request.fields['heart_rate'] = heartRateVal;

      var response = await request.send();
      var responseString = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        var decoded = jsonDecode(responseString);
        setState(() {
          riskLevel = decoded["result"].toString();
          isLoading = false;
        });
      } else {
        Fluttertoast.showToast(msg: "Server Error: ${response.statusCode}");
        setState(() => isLoading = false);
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Error: $e");
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink.shade50,
      appBar: AppBar(
        title: const Text("Exercise Recommendations"),
        backgroundColor: Colors.pink.shade400,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : (riskLevel == null)
          ? const Center(child: Text("Unable to load risk data"))
          : _buildContent(),
    );
  }

  Widget _buildContent() {
    Color riskColor = Colors.orange;
    if (riskLevel!.toLowerCase() == "high") riskColor = Colors.red;
    if (riskLevel!.toLowerCase() == "low") riskColor = Colors.green;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 8,
                  offset: Offset(0, 3),
                )
              ],
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(Icons.warning_amber_rounded,
                        color: riskColor, size: 28),
                    const SizedBox(width: 8),
                    const Text(
                      "Health Risk Assessment",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  "Your Health Risk: $riskLevel",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: riskColor,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                const Text(
                  "Please consult with your healthcare provider before exercising",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, color: Colors.black87),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RecommendationPage(riskLevel: riskLevel.toString()),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pink.shade400,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: const Text(
                      "Let's Get Started",
                      style:
                      TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 8,
                  offset: Offset(0, 3),
                )
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "⚠️ Safety Reminder (To show the first page after entering this component.):",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.blue,
                  ),
                ),
                SizedBox(height: 12),
                GuidelinesItem("Always get approval from your doctor before starting"),
                GuidelinesItem("Warm up for 3–5 minutes (gentle walking or arm circles)."),
                GuidelinesItem("Breathe normally—don’t hold your breath."),
                GuidelinesItem("Stop if you feel pain, dizziness, contractions, bleeding, or unusual shortness of breath."),
                GuidelinesItem("Use pillows, walls, or chairs for support when needed."),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class GuidelinesItem extends StatelessWidget {
  final String text;
  const GuidelinesItem(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.circle, size: 8, color: Colors.blue),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}
