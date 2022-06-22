import 'package:flutter/material.dart';
import 'package:github_profile/ui/results_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatelessWidget {
  TextEditingController _username = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: <Widget>[
          Container(
            // color: Colors.black,
            width: double.maxFinite,
            // height: 300.0,
            child: Padding(
              padding: const EdgeInsets.all(50.0),
              child: Column(
                children: [
                  Lottie.asset(
                    "assets/anim/github_anim.json",
                    repeat: true,
                    width: 180,
                  ),
                  Container(
                    height: 20,
                  ),
                  const Text(
                    "BUSCAR PERFIL DO GITHUB",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            decoration: const BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(120.0),
                )),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Container(height: 30.0),
                TextField(
                  controller: _username,
                  decoration: const InputDecoration(
                      filled: true,
                      prefixIcon: Icon(Icons.person, color: Colors.black),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          borderSide:
                              BorderSide(color: Colors.black, width: 1.0)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          borderSide:
                              BorderSide(color: Colors.black, width: 1.0)),
                      labelText: 'Nome do usuário',
                      labelStyle: TextStyle(color: Colors.black)),
                ),
                Container(height: 10.0),
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      child: const Text(
                        "BUSCAR",
                        style: TextStyle(
                            fontFamily: "Roboto", fontWeight: FontWeight.bold),
                      ),
                      style: ElevatedButton.styleFrom(
                          elevation: 12,
                          primary: Color.fromARGB(255, 0, 0, 0),
                          padding: const EdgeInsets.all(14),
                          textStyle: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          )),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ResultsScreen(
                                    username: _username.value.text)));
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.35,
            height: MediaQuery.of(context).size.height * 0.1,
            child: Column(
              children: [
                const Text(
                  "Conecte-se comigo:",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Container(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        Uri url = Uri.parse("https://github.com/EduAzevedo");
                        if (await canLaunchUrl(url)) {
                          await launchUrl(url);
                        } else {
                          throw 'Could not launch $url';
                        }
                      },
                      child: Image.network(
                        "https://cdn-icons-png.flaticon.com/512/25/25231.png",
                        width: 40,
                      ),
                    ),
                    Container(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () async {
                        Uri url = Uri.parse(
                            "https://www.linkedin.com/in/eduardo-azevedo-8b504821b/");
                        if (await canLaunchUrl(url)) {
                          await launchUrl(url);
                        } else {
                          throw 'Could not launch $url';
                        }
                      },
                      child: Image.network(
                        "https://cdn-icons-png.flaticon.com/512/174/174857.png",
                        width: 40,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
