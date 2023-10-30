import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:emmorceapp/constants/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  String name = "";
  String email = "";

  @override
  void initState() {
    super.initState();
    _viewProfile();
  }

  Future<void> _viewProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int outid = (prefs.getInt('login_id') ?? 0);
    final url = Apiconstants.baseurl + Apiconstants.view_profile + outid.toString();
    var response = await http.get(Uri.parse(url));
    var body = json.decode(response.body);
    setState(() {
      name = body['data']['Name'];
      email = body['data']['Email'];
      nameController.text = name;
      emailController.text = email;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back),
        ),
        title: Text("My Profile"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // Profile Image
              Stack(
                children: [
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.asset("images/profile.jpeg"),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.blue,
                      ),
                      child: const Icon(
                        Icons.edit,
                        color: Colors.black,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(name, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              Text(email, style: TextStyle(color: Colors.grey)),
              const SizedBox(height: 20),

              // Edit Profile Button
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: () {
                    // Navigate to the edit profile screen
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text("Edit Profile", style: TextStyle(color: Colors.white)),
                ),
              ),
              const SizedBox(height: 30),

              // Divider
              const Divider(),
              const SizedBox(height: 10),

              // Profile Menu
              ProfileMenuItem(title: "Order History", icon: Icons.receipt, onTap: () {}),
              ProfileMenuItem(title: "Shipping Address", icon: Icons.location_on, onTap: () {}),
              ProfileMenuItem(title: "Payment Methods", icon: Icons.credit_card, onTap: () {}),
              ProfileMenuItem(title: "Contact Us", icon: Icons.mail, onTap: () {}),
              const Divider(),
              const SizedBox(height: 10),

              // Logout Button
              ProfileMenuItem(title: "Logout", icon: Icons.exit_to_app, textColor: Colors.red, onTap: () {

                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileMenuItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color textColor;
  final Function onTap;

  const ProfileMenuItem({
    Key? key,
    required this.title,
    required this.icon,
    this.textColor = Colors.black,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title, style: TextStyle(color: textColor)),
      onTap: () {
        onTap();
      },
    );
  }
}
