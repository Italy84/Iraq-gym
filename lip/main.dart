import 'package:flutter/material.dart';

void main() {
  runApp(const GymOfIraqApp());
}

class GymOfIraqApp extends StatelessWidget {
  const GymOfIraqApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gym of Iraq',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF121212),
        primaryColor: const Color(0xFFFFD700),
      ),
      home: const MainNavigationScreen(),
    );
  }
}

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({Key? key}) : super(key: key);

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;

  // قائمة التمارين التفاعلية المجهزة
  List<Map<String, String>> memberWorkoutPlan = [
    {
      "name": "Bench Press - بنج بريس مستوي",
      "sets": "4",
      "reps": "12-10-8-6",
      "youtubeUrl": "https://www.youtube.com/watch?v=rT7DgCr-3pg"
    },
    {
      "name": "Incline Dumbbell Press - تجميع أعلى",
      "sets": "3",
      "reps": "12",
      "youtubeUrl": "https://www.youtube.com/watch?v=8iPEnn-ltC8"
    },
    {
      "name": "Cable Fly - تجميع كبل صدر",
      "sets": "4",
      "reps": "15",
      "youtubeUrl": "https://www.youtube.com/watch?v=Iwe6AmxVf7o"
    },
  ];

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      const OwnerDashboardScreen(),
      MemberProfileScreen(workoutPlan: memberWorkoutPlan),
      CoachWorkoutScreen(
        workoutPlan: memberWorkoutPlan,
        onAddExercise: (newExercise) {
          setState(() {
            memberWorkoutPlan.add(newExercise);
          });
        },
        onDeleteExercise: (index) {
          setState(() {
            memberWorkoutPlan.removeAt(index);
          });
        },
      ),
    ];

    return Scaffold(
      body: screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF1E1E1E),
        selectedItemColor: const Color(0xFFFFD700),
        unselectedItemColor: Colors.grey,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'الإدارة'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'ملف المتدرب'),
          BottomNavigationBarItem(icon: Icon(Icons.fitness_center), label: 'لوحة الكابتن'),
        ],
      ),
    );
  }
}

// 1. لوحة تحكم صاحب القاعة
class OwnerDashboardScreen extends StatelessWidget {
  const OwnerDashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E1E1E),
        elevation: 0,
        title: Row(
          children: const [
            CircleAvatar(
              backgroundColor: Color(0xFFFFD700),
              child: Icon(Icons.fitness_center, color: Colors.black),
            ),
            SizedBox(width: 12),
            Text("Gym of Iraq - جم العراق", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF1E1E1E),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFFFD700).withOpacity(0.5)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("المتواجدون بالقاعة الآن", style: TextStyle(color: Colors.grey, fontSize: 14)),
                      SizedBox(height: 6),
                      Text("32 متدرب", style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  Icon(Icons.sensors, color: Color(0xFFFFD700), size: 36),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text("إحصائيات المشتركين اليوم", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.3,
              children: [
                _buildStatCard("المشتركين الجدد", "5", Icons.person_add, Colors.green),
                _buildStatCard("ينتهي اشتراكهم قريباً", "12", Icons.warning_amber_rounded, Colors.orange),
                _buildStatCard("إجمالي المشتركين", "240", Icons.groups, Colors.blue),
                _buildStatCard("اشتراكات منتهية", "18", Icons.cancel_outlined, Colors.red),
              ],
            ),
            const SizedBox(height: 20),
            const Text("التقرير المالي (اليوم)", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF1E1E1E),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: const [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("الواردات (الاشتراكات):", style: TextStyle(color: Colors.grey)),
                      Text("250,000 د.ع", style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  Divider(color: Colors.grey, height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("المصاريف اليومية:", style: TextStyle(color: Colors.grey)),
                      Text("30,000 د.ع", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  Divider(color: Colors.grey, height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("الصافي المتبقي:", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      Text("220,000 د.ع", style: TextStyle(color: Colors.amber, fontSize: 18, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _buildStatCard(String title, String count, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: const Color(0xFF1E1E1E), borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(icon, color: color, size: 24),
              Text(count, style: TextStyle(color: color, fontSize: 20, fontWeight: FontWeight.bold)),
            ],
          ),
          Text(title, style: const TextStyle(color: Colors.grey, fontSize: 12)),
        ],
      ),
    );
  }
}

// 2. واجهة المتدرب (جدول التمارين والشرح والقياسات)
class MemberProfileScreen extends StatelessWidget {
  final List<Map<String, String>> workoutPlan;

  const MemberProfileScreen({Key? key, required this.workoutPlan}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E1E1E),
        title: const Text("ملف المتدرب والجدول التدريبي"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // معلومات المتدرب
            Center(
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 40,
                    backgroundColor: Color(0xFFFFD700),
                    child: Icon(Icons.person, size: 50, color: Colors.black),
                  ),
                  const SizedBox(height: 😎,
                  const Text("علي أحمد حسام", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.green),
                    ),
                    child: const Text("الاشتراك نشط (باقي 15 يوم)", style: TextStyle(color: Colors.green, fontSize: 11)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            const Text("الجدول التدريبي اليومي 🏋️‍♂️", style: TextStyle(color: Color(0xFFFFD700), fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),

            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: workoutPlan.length,
              itemBuilder: (context, index) {
                final ex = workoutPlan[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E1E1E),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(ex["name"]!, style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Text("الجولات: ${ex["sets"]}", style: const TextStyle(color: Colors.grey, fontSize: 13)),
                          const SizedBox(width: 16),
                          Text("التكرار: ${ex["reps"]}", style: const TextStyle(color: Colors.grey, fontSize: 13)),
                        ],
                      ),
                      const Divider(color: Colors.grey, height: 16),
                      InkWell(
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("جاري فتح فيديو الشرح للتمرين: ${ex["name"]}"),
                              backgroundColor: Colors.redAccent,
                            ),
                          );
                        },
                        child: Row(
                          children: const [
                            Icon(Icons.play_circle_fill, color: Colors.red, size: 20),
                            SizedBox(width: 😎,
                            Text("شاهد طريقة أداء التمرين (يوتيوب)", style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold, fontSize: 12)),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

// 3. لوحة الكابتن (إضافة التمارين ورابط يوتيوب)
class CoachWorkoutScreen extends StatelessWidget {
  final List<Map<String, String>> workoutPlan;
  final Function(Map<String, String>) onAddExercise;
  final Function(int) onDeleteExercise;

  const CoachWorkoutScreen({
    Key? key,
    required this.workoutPlan,
    required this.onAddExercise,
    required this.onDeleteExercise,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E1E1E),
        title: const Text("لوحة الكابتن (إدارة التمارين)"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("جدول المتدرب علي", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFFD700)),
                  onPressed: () => _showAddExerciseDialog(context),
                  icon: const Icon(Icons.add, color: Colors.black, size: 18),
                  label: const Text("إضافة تمرين", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: workoutPlan.length,
                itemBuilder: (context, index) {
                  final ex = workoutPlan[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(color: const Color(0xFF1E1E1E), borderRadius: BorderRadius.circular(12)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(ex["name"]!, style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 4),
                            Text("الجولات: ${ex["sets"]} | التكرار: ${ex["reps"]}", style: const TextStyle(color: Colors.amber, fontSize: 12)),
                          ],
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
                          onPressed: () => onDeleteExercise(index),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showAddExerciseDialog(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController setsController = TextEditingController();
    TextEditingController repsController = TextEditingController();
    TextEditingController youtubeController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF1E1E1E),
          title: const Text("إضافة تمرين وشرح يوتيوب", style: TextStyle(color: Colors.white)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: nameController, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "اسم التمرين", labelStyle: TextStyle(color: Colors.grey))),
              TextField(controller: setsController, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "عدد الجولات", labelStyle: TextStyle(color: Colors.grey))),
              TextField(controller: repsController, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "التكرارات", labelStyle: TextStyle(color: Colors.grey))),
              TextField(controller: youtubeController, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "رابط فيديو يوتيوب", labelStyle: TextStyle(color: Colors.grey))),
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text("إلغاء", style: TextStyle(color: Colors.grey))),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFFD700)),
              onPressed: () {
                if (nameController.text.isNotEmpty) {
                  onAddExercise({
                    "name": nameController.text,
                    "sets": setsController.text.isEmpty ? "3" : setsController.text,
                    "reps": repsController.text.isEmpty ? "12" : repsController.text,
                    "youtubeUrl": youtubeController.text.isEmpty ? "https://youtube.com" : youtubeController.text,
                  });
                  Navigator.pop(context);
                }
              },
              child: const Text("حفظ التغيرات", style: TextStyle(color: Colors.black)),
            ),
          ],
        );
      },
    );
  }
}
