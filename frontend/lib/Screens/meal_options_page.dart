import 'package:MomFit/Screens/MealPlan.dart';
import 'package:flutter/material.dart';

final Map<int, String> categoryNotes = {
  1: "You have more than one health risk. Keep meals simple and steady. Avoid ultra‑processed snacks, deep‑fried food, sugary drinks, very salty food, energy drinks, and too much caffeine. Choose meals made from whole grains, vegetables, beans, and lean proteins cooked with little oil. Eat at regular times, drink enough water, keep sugar and salt low, and check any new herbal drinks or supplements with your doctor.",
  2: "Help control sugar levels. Avoid sugary drinks, sweets, white‑flour snacks, and very large meals made mostly of starch. Choose slower‑release carbohydrates with fibre and always combine them with protein and a little healthy fat. Spread carbohydrate foods across the day, prefer steaming, boiling, or grilling, and follow your glucose checks with your doctor.",
  3: "Help lower blood pressure. Avoid high‑salt processed foods, salty snacks, instant noodles or soups, pickled foods, stock cubes, and too much caffeine. Cook with less salt and use herbs, spices, or lemon for flavour. Pick fresh foods more often, drink water regularly, and read labels to keep salt low.",
  4: "Support iron and folate. Avoid tea or coffee with meals and do not rely mainly on refined grains. Choose meal plans that often include iron‑ and folate‑supporting foods from plants or animal sources, and add a vitamin‑C‑rich fruit or side to help absorption. Follow your doctor’s guidance.",
  5: "Protect yourself from reactions. Avoid your allergen and prevent cross‑contact in the kitchen or at food stalls. Choose safe proteins that fit your allergy plan, along with vegetables, grains, and legumes. Check labels, ask how food is prepared when eating out, and follow your doctor’s allergy advice.",
  6: "Build healthy weight. Avoid skipping meals and avoid filling up on tea or black coffee instead of food. Choose energy‑ and protein‑rich meals made from whole foods, with some healthy fats and fibre. Keep three meals plus regular snacks, use softer textures if appetite is low, and review progress with your doctor.",
  7: "Lower excess weight safely. Avoid sugary drinks, frequent desserts, deep‑fried foods, and highly refined starches. Base meals on vegetables, whole‑grain carbohydrates, and lean proteins cooked with little oil. Eat at steady times, choose water as your main drink, keep late‑night meals light, and practice mindful eating.",
  8: "Early pregnancy comfort. If you feel nauseous, avoid very greasy or very spicy meals and keep caffeine low. Choose gentle, balanced meals that include carbohydrates, protein, vegetables, and fluids. Small, frequent meals can help. Use simple cooking methods and stay hydrated through the day.",
  9: "Balanced vegetarian eating. Avoid ultra‑processed mock meats that are high in salt or fat. Eat a mix of plant proteins with whole‑grain foods and include regular sources that support iron, calcium, iodine, and vitamin B12 (through foods or supplements as advised). Pair iron‑supporting foods with vitamin‑C‑rich sides and check key nutrients with your doctor when needed.",
  10: "Third‑trimester care. Avoid very heavy late‑night meals and very spicy or fried foods near bedtime to reduce reflux. Choose slightly more protein with fibre‑rich carbohydrates and enough fluids. Try to eat dinner earlier, pick lighter textures if heartburn occurs, keep salt moderate, and follow your doctor’s advice.",
};

class MealOptionsPage extends StatelessWidget {
  final int category;
  final String BF;
  final String MMS;
  final String L;
  final String ES;
  final String D;
  const MealOptionsPage({
    required this.category,
    required this.BF,
    required this.MMS,
    required this.L,
    required this.ES,
    required this.D,
  });

  @override
  Widget build(BuildContext context) {
    var notes = categoryNotes[category] ?? "No guidance available.";

    return Scaffold(
      backgroundColor: Colors.pink.shade50,
      appBar: AppBar(
        title: Text("Your Meal Plan"),
        backgroundColor: Colors.pink.shade400,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 4,
                margin: const EdgeInsets.only(bottom: 20),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Guidance",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(notes, style: TextStyle(fontSize: 16)),
                    ],
                  ),
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Sample Meals",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 12),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.restaurant_menu,
                              color: Colors.pink.shade400,
                              size: 20,
                            ),
                            SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                "Breakfast : " + BF,
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.restaurant_menu,
                              color: Colors.pink.shade400,
                              size: 20,
                            ),
                            SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                "Mid‑morning snack : " + MMS,
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.restaurant_menu,
                              color: Colors.pink.shade400,
                              size: 20,
                            ),
                            SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                "Lunch : " + L,
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.restaurant_menu,
                              color: Colors.pink.shade400,
                              size: 20,
                            ),
                            SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                "Evening snack : " + ES,
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.restaurant_menu,
                              color: Colors.pink.shade400,
                              size: 20,
                            ),
                            SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                "Dinner : " + D,
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MealPlan(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.pink.shade400,
                            padding: EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            "Get Another Meal Plan",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
