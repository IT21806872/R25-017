import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ExerciseRecommendationPage extends StatefulWidget {
  final int predictedCategory;

  ExerciseRecommendationPage({required this.predictedCategory});

  @override
  _ExerciseRecommendationPageState createState() =>
      _ExerciseRecommendationPageState();
}

class _ExerciseRecommendationPageState
    extends State<ExerciseRecommendationPage> {
  final Map<int, List<Map<String, String>>> exerciseVideos = {
    1: [
      {
        "title": "Walking",
        "videoId": "iLn0qnR0bwU",
        "description":
        "1. Put on supportive shoes and loose clothing.\n2. Start with a slow pace for 2–3 minutes.\n3. Gradually increase to a brisk but comfortable pace (able to talk without gasping).\n4. Swing arms naturally to keep rhythm.\n5. Walk on flat, safe surfaces.\n6. Cool down with slow walking for 2 minutes.\nDuration: 10–30 min depending on comfort."
      },
      {
        "title": "Swimming",
        "videoId": "VyF5J5yXTxI",
        "description":
        "1. Enter water slowly, avoid jumping or diving.\n2. Choose gentle strokes: breaststroke, freestyle, or side stroke.\n3. Keep head and neck comfortable (avoid straining).\n4. Breathe regularly with strokes.\n5. Swim at a steady pace, rest as needed at pool edge.\nDuration: 15–30 min."
      },
    ],
    2: [
      {
        "title": "Walking",
        "videoId": "iLn0qnR0bwU",
        "description":
        "1. Put on supportive shoes and loose clothing.\n2. Start with a slow pace for 2–3 minutes.\n3. Gradually increase to a brisk but comfortable pace.\n4. Swing arms naturally to keep rhythm.\n5. Walk on flat, safe surfaces.\n6. Cool down with slow walking for 2 minutes.\nDuration: 10–30 min."
      },
      {
        "title": "Modified Cat Cow",
        "videoId": "9uY-vvV4Lgc",
        "description":
        "1. Get on hands and knees, wrists under shoulders, knees under hips.\n2. Inhale, lift head and tailbone upward, drop belly down (Cow).\n3. Exhale, tuck chin toward chest, round spine upward (Cat).\n4. Move slowly with breath.\nReps: 5–10 cycles."
      },
    ],
    3: [
      {
        "title": "Kegels",
        "videoId": "1HH4Rz6WKd8",
        "description":
        "1. Sit, stand, or lie comfortably.\n2. Imagine tightening muscles used to stop urine.\n3. Hold contraction for 5 seconds.\n4. Relax fully for 5 seconds.\n5. Breathe normally throughout.\nReps: 10–15 per set, 2–3 sets daily."
      },
      {
        "title": "Mini Squats",
        "videoId": "BMkbGAXWmHc",
        "description":
        "1. Stand with feet hip-width apart.\n2. Hold a chair or wall for balance.\n3. Inhale, bend knees slightly (¼ squat only).\n4. Keep chest lifted, knees behind toes.\n5. Exhale, push through heels to stand tall.\nReps: 8–12."
      },
      {
        "title": "Glute Bridges",
        "videoId": "y8ZHj9Zgzw8",
        "description":
        "1. Lie on back, knees bent, feet flat on floor.\n2. Place arms beside body.\n3. Inhale, then exhale as you lift hips toward ceiling.\n4. Hold 2–3 seconds, squeezing glutes.\n5. Slowly lower hips back down.\nReps: 8–12. (⚠ After 20 weeks, use pillow incline or side-lying option)."
      },
    ],
    4: [
      {
        "title": "Yoga",
        "videoId": "44fYnoSLL3c",
        "description":
        "1. Use safe poses only (Warrior II, seated side stretch, butterfly).\n2. Enter positions slowly with support.\n3. Breathe deeply, never hold breath.\n4. Avoid lying flat on back or twisting deeply.\nDuration: 10–20 min gentle flow."
      },
      {
        "title": "Bhramari Breath",
        "videoId": "6I7BVXiscEY",
        "description":
        "1. Sit upright, close eyes.\n2. Place index fingers gently on ears.\n3. Inhale through nose.\n4. Exhale slowly while making humming “mmm” sound.\n5. Focus on vibration in head and chest.\nReps: 5–7 breaths."
      },
    ],
    5: [
      {
        "title": "Stationary Cycling",
        "videoId": "vl95BKnIGIY",
        "description":
        "1. Adjust seat so knees bend slightly at bottom of pedal.\n2. Sit upright, hands on handlebars.\n3. Start pedaling slowly for 2–3 minutes.\n4. Maintain moderate pace, avoid heavy resistance.\n5. Keep breathing steady.\nDuration: 10–20 min."
      },
      {
        "title": "Seated Forward Bend",
        "videoId": "-01nVuNTeZk",
        "description":
        "1. Sit with legs spread comfortably apart.\n2. Keep back straight, hinge forward from hips.\n3. Rest hands on thighs or shins (not toes if uncomfortable).\n4. Breathe deeply, avoid rounding back.\nHold: 15–20 sec, repeat twice."
      },
    ],
    6: [
      {
        "title": "Pelvic Floor Awareness",
        "videoId": "z8ik-Oje-k4",
        "description":
        "1. Sit upright on chair.\n2. Place hand lightly on lower belly.\n3. Inhale, feel pelvic muscles relax downward.\n4. Exhale, gently contract pelvic floor.\n5. Notice difference between relaxation and contraction.\nDuration: 1–2 minutes."
      },
      {
        "title": "Supported Pigeon Pose",
        "videoId": "H62orQP1LTo",
        "description":
        "1. Place pillow/bolster under hips.\n2. Bring right leg forward, bend knee.\n3. Extend left leg straight behind.\n4. Keep chest upright or lean forward slightly.\n5. Hold for 15–20 sec, switch legs."
      },
    ],
    7: [
      {
        "title": "Modified Push-Ups",
        "videoId": "n65fckZGqE8",
        "description":
        "1. Stand facing wall, hands shoulder-width apart.\n2. Step feet back until body forms straight line.\n3. Bend elbows, bring chest toward wall.\n4. Exhale, push back to start.\nReps: 6–10."
      },
      {
        "title": "Tricep Dips",
        "videoId": "QbZTJRE0lHU",
        "description":
        "1. Sit on sturdy chair edge, hands beside hips.\n2. Slide hips forward, bend elbows slightly.\n3. Lower body a few inches (don’t go deep).\n4. Press back up slowly.\nReps: 6–8."
      },
    ],
    8: [
      {
        "title": "Seated Forward Bend",
        "videoId": "-01nVuNTeZk",
        "description":
        "1. Sit with legs spread comfortably apart.\n2. Keep back straight, hinge forward from hips.\n3. Rest hands on thighs or shins.\n4. Breathe deeply, avoid rounding back.\nHold: 15–20 sec, repeat twice."
      },
      {
        "title": "Bhramari Breath",
        "videoId": "6I7BVXiscEY",
        "description":
        "1. Sit upright, close eyes.\n2. Place index fingers gently on ears.\n3. Inhale through nose.\n4. Exhale slowly while making humming “mmm” sound.\n5. Focus on vibration in head and chest.\nReps: 5–7 breaths."
      },
    ],
    9: [
      {
        "title": "Squat and Rotate",
        "videoId": "UMHwi7TXqDA",
        "description":
        "1. Stand with feet shoulder-width apart.\n2. Lower into shallow squat.\n3. As you rise, rotate torso gently to right.\n4. Alternate sides each rep.\nReps: 6–8 per side."
      },
      {
        "title": "4-Point Kneel",
        "videoId": "eZebaKinw54",
        "description":
        "1. Start on hands and knees.\n2. Inhale, extend right arm forward and left leg back.\n3. Keep hips level, don’t arch back.\n4. Exhale, return to start.\n5. Repeat on opposite side.\nReps: 6 each side."
      },
    ],
    10: [
      {
        "title": "Swimming",
        "videoId": "VyF5J5yXTxI",
        "description":
        "1. Enter water slowly, avoid jumping or diving.\n2. Choose gentle strokes: breaststroke, freestyle, or side stroke.\n3. Keep head and neck comfortable.\n4. Breathe regularly with strokes.\n5. Swim at a steady pace, rest as needed.\nDuration: 15–30 min."
      },
      {
        "title": "Pelvic Floor Awareness",
        "videoId": "z8ik-Oje-k4",
        "description":
        "1. Sit upright on chair.\n2. Place hand lightly on lower belly.\n3. Inhale, feel pelvic muscles relax downward.\n4. Exhale, gently contract pelvic floor.\n5. Notice difference between relaxation and contraction.\nDuration: 1–2 minutes."
      },
    ],
    11: [
      {
        "title": "Yoga",
        "videoId": "44fYnoSLL3c",
        "description":
        "1. Use safe poses only (Warrior II, seated side stretch, butterfly).\n2. Enter positions slowly with support.\n3. Breathe deeply, never hold breath.\n4. Avoid lying flat on back or twisting deeply.\nDuration: 10–20 min gentle flow."
      },
      {
        "title": "Modified Cat Cow",
        "videoId": "9uY-vvV4Lgc",
        "description":
        "1. Get on hands and knees, wrists under shoulders, knees under hips.\n2. Inhale, lift head and tailbone upward, drop belly down (Cow).\n3. Exhale, tuck chin toward chest, round spine upward (Cat).\n4. Move slowly with breath.\nReps: 5–10 cycles."
      },
    ],
    12: [
      {
        "title": "Child’s Pose (Modified)",
        "videoId": "xQYwPT15eeg",
        "description":
        "1. Kneel with knees wide apart, toes touching.\n2. Sit back onto heels.\n3. Stretch arms forward, forehead to mat/pillow.\n4. Relax shoulders, breathe deeply.\nHold: 20–30 sec."
      },
      {
        "title": "Kegels",
        "videoId": "1HH4Rz6WKd8",
        "description":
        "1. Sit, stand, or lie comfortably.\n2. Imagine tightening muscles used to stop urine.\n3. Hold contraction for 5 seconds.\n4. Relax fully for 5 seconds.\n5. Breathe normally throughout.\nReps: 10–15 per set, 2–3 sets daily."
      },
    ],
    13: [
      {
        "title": "Supported V-Sits",
        "videoId": "z8ik-Oje-k4",
        "description":
        "1. Sit with back supported against wall or pillows.\n2. Spread legs into gentle “V” shape.\n3. Lean slightly forward from hips.\n4. Rest hands on thighs.\nHold: 15–20 sec."
      },
      {
        "title": "Pelvic Floor Awareness",
        "videoId": "z8ik-Oje-k4",
        "description":
        "1. Sit upright on chair.\n2. Place hand lightly on lower belly.\n3. Inhale, feel pelvic muscles relax downward.\n4. Exhale, gently contract pelvic floor.\n5. Notice difference between relaxation and contraction.\nDuration: 1–2 minutes."
      },
    ],
    14: [
      {
        "title": "Stationary Cycling",
        "videoId": "vl95BKnIGIY",
        "description":
        "1. Adjust seat so knees bend slightly at bottom of pedal.\n2. Sit upright, hands on handlebars.\n3. Start pedaling slowly for 2–3 minutes.\n4. Maintain moderate pace, avoid heavy resistance.\n5. Keep breathing steady.\nDuration: 10–20 min."
      },
      {
        "title": "Kegels",
        "videoId": "1HH4Rz6WKd8",
        "description":
        "1. Sit, stand, or lie comfortably.\n2. Imagine tightening muscles used to stop urine.\n3. Hold contraction for 5 seconds.\n4. Relax fully for 5 seconds.\n5. Breathe normally throughout.\nReps: 10–15 per set, 2–3 sets daily."
      },
    ],
    15: [
      {
        "title": "Prenatal Pilates (Basics)",
        "videoId": "0mCvtuG_4Og",
        "description":
        "1. Focus on gentle core activation, side-lying moves.\n2. Side-lying leg lifts: Lie on side, lift top leg slowly.\n3. Modified plank: On knees and elbows.\n4. Seated torso circles: Small, slow circles with straight back.\nDuration: 10–15 min routine."
      },
      {
        "title": "Bhramari Breath",
        "videoId": "6I7BVXiscEY",
        "description":
        "1. Sit upright, close eyes.\n2. Place index fingers gently on ears.\n3. Inhale through nose.\n4. Exhale slowly while making humming “mmm” sound.\n5. Focus on vibration in head and chest.\nReps: 5–7 breaths."
      },
    ],
    16: [
      {
        "title": "Glute Bridges",
        "videoId": "rWd21dOpBTM",
        "description":
        "1. Lie on back, knees bent, feet flat on floor.\n2. Place arms beside body.\n3. Inhale, then exhale as you lift hips toward ceiling.\n4. Hold 2–3 seconds, squeezing glutes.\n5. Slowly lower hips back down.\nReps: 8–12. (⚠️ After 20 weeks, use pillow incline or side-lying option)."
      },
      {
        "title": "Mini Squats",
        "videoId": "BMkbGAXWmHc",
        "description":
        "1. Stand with feet hip-width apart.\n2. Hold a chair or wall for balance.\n3. Inhale, bend knees slightly (¼ squat only).\n4. Keep chest lifted, knees behind toes.\n5. Exhale, push through heels to stand tall.\nReps: 8–12."
      },
    ],
    17: [
      {
        "title": "Deep Squats (With Support)",
        "videoId": "OfA1Pbm3Q0w",
        "description":
        "1. Stand with feet wide apart.\n2. Hold sturdy chair/rail for balance.\n3. Inhale, bend knees, lower into deep squat (don’t force).\n4. Keep back straight, heels on ground.\n5. Exhale, rise slowly.\nReps: 5–8."
      },
      {
        "title": "Perineal Massage (from 34+ weeks)",
        "videoId": "Wm2aqVOG6Tc",
        "description":
        "1. Wash hands, apply clean natural oil.\n2. Sit or semi-recline comfortably.\n3. Insert thumbs 2–3 cm inside vaginal opening.\n4. Press gently downward and outward.\n5. Massage U-shaped area for 3–5 min.\nFrequency: 3–4 times/week."
      },
    ],
    18: [
      {
        "title": "Dancing (Gentle)",
        "videoId": "G9NVRZN_gp4",
        "description":
        "1. Play soft or favorite music.\n2. Move side to side, small steps, sways.\n3. Avoid spinning or jumping.\n4. Stop if breathless or dizzy.\nDuration: 5–15 min."
      },
      {
        "title": "Light Weight Training (1–3 kg)",
        "videoId": "qkBc37aBD38",
        "description":
        "1. Stand/sit with weights in each hand.\n2. Bicep curls: bend elbows, bring weights to shoulders.\n3. Lateral raises: lift arms sideways to shoulder height.\n4. Seated presses: push weights upward overhead gently.\nReps: 8–10 per move, 1–2 sets."
      },
    ],
    19: [
      {
        "title": "Modified Cat Cow",
        "videoId": "9uY-vvV4Lgc",
        "description":
        "1. Get on hands and knees, wrists under shoulders, knees under hips.\n2. Inhale, lift head and tailbone upward, drop belly down (Cow).\n3. Exhale, tuck chin toward chest, round spine upward (Cat).\n4. Move slowly with breath.\nReps: 5–10 cycles."
      },
      {
        "title": "Kegels",
        "videoId": "1HH4Rz6WKd8",
        "description":
        "1. Sit, stand, or lie comfortably.\n2. Imagine tightening muscles used to stop urine.\n3. Hold contraction for 5 seconds.\n4. Relax fully for 5 seconds.\n5. Breathe normally throughout.\nReps: 10–15 per set, 2–3 sets daily."
      },
    ],
    20: [
      {
        "title": "Walking",
        "videoId": "iLn0qnR0bwU",
        "description":
        "1. Put on supportive shoes and loose clothing.\n2. Start with a slow pace for 2–3 minutes.\n3. Gradually increase to a brisk but comfortable pace (able to talk without gasping).\n4. Swing arms naturally to keep rhythm.\n5. Walk on flat, safe surfaces.\n6. Cool down with slow walking for 2 minutes.\nDuration: 10–30 min depending on comfort."
      },
      {
        "title": "Seated Pelvic Awareness",
        "videoId": "5T2-0JZhcqw",
        "description":
        "1. Sit upright on chair.\n2. Inhale, release pelvic muscles completely.\n3. Exhale, gently contract pelvic muscles.\n4. Relax again fully.\nDuration: 1–2 minutes."
      },
    ],
    21: [
      {
        "title": "Modified Side Plank",
        "videoId": "JdL-XF7QI8g",
        "description":
        "1. Lie on side, knees bent, forearm under shoulder.\n2. Exhale, lift hips slightly off floor.\n3. Keep body in straight line from head to knees.\n4. Hold 5–10 sec, lower down.\nReps: 5 each side."
      },
      {
        "title": "Psoas Stretch (Hip Flexor Stretch)",
        "videoId": "qKUu9mvCbWA",
        "description":
        "1. Kneel on right knee, left foot in front (lunge position).\n2. Keep chest upright, shoulders relaxed.\n3. Shift hips forward gently until stretch felt in front hip.\n4. Hold 15–20 sec, switch legs."
      },
    ],
    22: [
      {
        "title": "Swimming",
        "videoId": "VyF5J5yXTxI",
        "description":
        "1. Enter water slowly, avoid jumping or diving.\n2. Choose gentle strokes: breaststroke, freestyle, or side stroke.\n3. Keep head and neck comfortable (avoid straining).\n4. Breathe regularly with strokes.\n5. Swim at a steady pace, rest as needed at pool edge.\nDuration: 15–30 min."
      },
      {
        "title": "Light Weight Training (1–3 kg)",
        "videoId": "qkBc37aBD38",
        "description":
        "1. Stand/sit with weights in each hand.\n2. Bicep curls: bend elbows, bring weights to shoulders.\n3. Lateral raises: lift arms sideways to shoulder height.\n4. Seated presses: push weights upward overhead gently.\nReps: 8–10 per move, 1–2 sets."
      },
    ],
    23: [
      {
        "title": "Perineal Bulges (Bearing Down)",
        "videoId": "2fIPRseZyJM",
        "description":
        "1. Sit or lie comfortably.\n2. Inhale deeply, relax belly.\n3. Exhale, gently bear down as if passing stool.\n4. Relax fully after each attempt.\nReps: 4–5."
      },
      {
        "title": "Breathing Exercises",
        "videoId": "2fIPRseZyJM",
        "description":
        "1. Sit with back supported or lie on side.\n2. Place one hand on belly, one on chest.\n3. Inhale slowly through nose, belly rises.\n4. Exhale through mouth, belly falls.\n5. Focus on slow, even rhythm.\nReps: 5–10 breaths, repeat daily."
      },
    ],
    24: [
      {
        "title": "Yoga",
        "videoId": "44fYnoSLL3c",
        "description":
        "1. Use safe poses only (Warrior II, seated side stretch, butterfly).\n2. Enter positions slowly with support.\n3. Breathe deeply, never hold breath.\n4. Avoid lying flat on back or twisting deeply.\nDuration: 10–20 min gentle flow."
      },
      {
        "title": "Supported Pigeon Pose",
        "videoId": "H62orQP1LTo",
        "description":
        "1. Place pillow/bolster under hips.\n2. Bring right leg forward, bend knee.\n3. Extend left leg straight behind.\n4. Keep chest upright or lean forward slightly.\n5. Hold for 15–20 sec, switch legs."
      },
    ],
    25: [
      {
        "title": "Walking",
        "videoId": "iLn0qnR0bwU",
        "description":
        "1. Put on supportive shoes and loose clothing.\n2. Start with a slow pace for 2–3 minutes.\n3. Gradually increase to a brisk but comfortable pace (able to talk without gasping).\n4. Swing arms naturally to keep rhythm.\n5. Walk on flat, safe surfaces.\n6. Cool down with slow walking for 2 minutes.\nDuration: 10–30 min depending on comfort."
      },
      {
        "title": "Stationary Cycling",
        "videoId": "vl95BKnIGIY",
        "description":
        "1. Adjust seat so knees bend slightly at bottom of pedal.\n2. Sit upright, hands on handlebars.\n3. Start pedaling slowly for 2–3 minutes.\n4. Maintain moderate pace, avoid heavy resistance.\n5. Keep breathing steady.\nDuration: 10–20 min."
      },
    ]
  };

  List<Map<String, String>> exercises = [];

  @override
  void initState() {
    super.initState();
    exercises = exerciseVideos[widget.predictedCategory] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink.shade50,
      appBar: AppBar(
        title: Text("Exercise Recommendation"),
        backgroundColor: Colors.pink.shade400,
      ),
      body: exercises.isEmpty
          ? Center(child: Text("No exercises available for this category"))
          : ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: exercises.length,
        itemBuilder: (context, index) {
          final exercise = exercises[index];
          final controller = YoutubePlayerController(
            initialVideoId: exercise['videoId']!,
            flags: YoutubePlayerFlags(
              autoPlay: false,
              controlsVisibleAtStart: true,
            ),
          );

          return Card(
            margin: EdgeInsets.only(bottom: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(12),
                  ),
                  child: YoutubePlayer(
                    controller: controller,
                    showVideoProgressIndicator: true,
                    progressIndicatorColor: Colors.pink.shade400,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    exercise['title']!,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.pink.shade400,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12.0, vertical: 8),
                  child: Text(
                    exercise['description']!,
                    style: TextStyle(fontSize: 14, color: Colors.black87),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
