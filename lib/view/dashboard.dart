import 'package:flutter/material.dart';
import 'package:healthy_recipies/Controller/healty.controller.dart';
import 'package:healthy_recipies/view/dashboard_details.dart';
import 'package:healthy_recipies/view/login.dart';
import 'package:healthy_recipies/view/profile.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  DashboardState createState() => DashboardState();
}

class DashboardState extends State<Dashboard> {
  void clearData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.remove('email');
    await prefs.remove('password');
  }

  @override
  void initState() {
    context.read<HealthyController>().gethealthyData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            DrawerHeader(
                decoration: BoxDecoration(
                    color: Colors.pinkAccent.withAlpha((0.5 * 255).toInt())),
                child: const Column(
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: AssetImage("assets/logo.png"),
                          radius: 40,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Hello,"),
                            Text("Technophyle"),
                          ],
                        )
                      ],
                    )
                  ],
                )),
            ListTile(
              leading: Icon(
                Icons.person,
                color: Colors.pinkAccent.withAlpha((0.5 * 255).toInt()),
              ),
              title: const Text("Profile"),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Profile()));
              },
            ),
            ListTile(
              leading: Icon(
                Icons.settings,
                color: Colors.pink.withAlpha((0.5 * 255).toInt()),
              ),
              title: const Text("Settings"),
              trailing: const Icon(Icons.arrow_forward),
            ),
            const SizedBox(
              height: 400,
            ),
            ElevatedButton(
              onPressed: () {
                clearData();
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const Login()));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    Colors.pinkAccent.withAlpha((0.5 * 255).toInt()),
              ),
              child: const Text(
                "Logout",
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        title: const Text(
          "Healthy Recipe",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 30,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/background-gradient-pink.jpg"),
                fit: BoxFit.fill)),
        child: context.watch<HealthyController>().getPost == null
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : context.watch<HealthyController>().getPost!.isEmpty
                ? const Text("No Data ")
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: GridView(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              crossAxisCount: 2,
                              childAspectRatio: 1.2),
                      children: [
                        for (var i
                            in context.watch<HealthyController>().getPost!) ...[
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          DashboartdDetails(getPost: i)));
                            },
                            child: Card(
                              child: ClipRRect(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                                child: Image.network(
                                  i.postImage!,
                                  fit: BoxFit.cover,
                                  loadingBuilder: (context, child, progress) {
                                    if (progress == null) return child;
                                    return Shimmer.fromColors(
                                      baseColor: Colors.grey[300]!,
                                      highlightColor: Colors.grey[100]!,
                                      child: Container(
                                        color: Colors.white,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          )
                        ]
                      ],
                    ),
                  ),
      ),
    );
  }
}
