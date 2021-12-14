import 'package:bmi/widgets/custom_form.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  CustomForm customForm = const CustomForm();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("BMI Calculator"),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                  decoration: const BoxDecoration(
                    color: Colors.red,
                  ),
                  child: Center(
                    child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7)),
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset("assets/icon/businessman.png"),
                        )),
                  )),
              const ListTile(
                title: Text("Rate this app"),
                leading: Icon(Icons.star),
              ),
              const ListTile(
                title: Text("Share this app"),
                leading: Icon(Icons.share),
              ),
              const ListTile(
                title: Text("Send feedback"),
                leading: Icon(Icons.feedback),
              ),
              const ListTile(
                title: Text("Privacy policy"),
                leading: Icon(Icons.privacy_tip),
              ),
              const ListTile(
                title: Text("Exit"),
                leading: Icon(Icons.exit_to_app),
              ),
            ],
          ),
        ),
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          children: [
            CustomForm(),
          ],
        ),
      ),
    );
  }
}
