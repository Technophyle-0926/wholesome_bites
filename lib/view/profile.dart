import 'package:flutter/material.dart';
import 'package:healthy_recipies/Model/profile.modal.dart';
import 'package:healthy_recipies/view/dashboard.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  List<Orders> ofOrder = [
    Orders(name: "Your Orders"),
    Orders(name: "Membership"),
    Orders(name: "Account Info"),
    Orders(name: "Order History"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("healthy recipies.in"),
        backgroundColor: Colors.pinkAccent.withAlpha((0.5 * 255).toInt()),
        actions: const [
          Icon(
            Icons.settings,
            color: Colors.white,
          ),
          SizedBox(width: 20),
          Icon(Icons.notifications, color: Colors.white),
          SizedBox(
            width: 20,
          ),
          Icon(
            Icons.search,
            color: Colors.white,
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              height: MediaQuery.sizeOf(context).height / 2,
              child: GridView.builder(
                itemCount: ofOrder.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 4),
                itemBuilder: (context, i) {
                  return OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50))),
                    child: Text(ofOrder[i].name),
                  );
                },
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Dashboard()));
                },
                child: const Text("To Dashborad"))
          ],
        ),
      ),
    );
  }
}
