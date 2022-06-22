import 'dart:convert';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:github_profile/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';

class ResultsScreen extends StatelessWidget {
  final String username;

  const ResultsScreen({Key? key, required this.username}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Perfil'),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: FutureBuilder(
        future: _fetchUser(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final user = snapshot.data;
            User? usuario = user as User?;
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.4,
                  child: Image.network(
                    usuario!.avatarUrl,
                    fit: BoxFit.cover,
                  ),
                ),
                Container(height: 10),
                Text(usuario.name,
                    style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
                Container(height: 10),
                Text(usuario.bio,
                    style:
                        const TextStyle(fontSize: 16.0, color: Colors.white)),
                Container(height: 10),
                usuario.location.isNotEmpty
                    ? Text("📍${usuario.location}",
                        style: const TextStyle(
                            fontSize: 16.0, color: Colors.white))
                    : Container(),
                Container(height: 20),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.fromLTRB(12, 6, 12, 6),
                          decoration: BoxDecoration(
                              color: Colors.deepOrange,
                              borderRadius: BorderRadius.circular(12)),
                          child: Text("Seguidores: ${usuario.followers}",
                              style: const TextStyle(
                                color: Colors.white,
                              )),
                        ),
                        Container(width: 10),
                        Container(
                          padding: const EdgeInsets.fromLTRB(12, 6, 12, 6),
                          decoration: BoxDecoration(
                              color: Colors.blueAccent,
                              borderRadius: BorderRadius.circular(12)),
                          child: Text("Seguindo: ${usuario.following}",
                              style: const TextStyle(
                                color: Colors.white,
                              )),
                        ),
                      ],
                    ),
                    Container(height: 10),
                    Container(
                      padding: const EdgeInsets.fromLTRB(12, 6, 12, 6),
                      decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(12)),
                      child:
                          Text("Repositórios públicos: ${usuario.publicRepos}",
                              style: const TextStyle(
                                color: Colors.white,
                              )),
                    ),
                  ],
                ),
                Container(
                  height: 10,
                ),
                Text(
                  "Criado em: ${UtilData.obterDataDDMMAAAA(DateTime.parse(usuario.created_at))}",
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                ),
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () async {
                      Uri url = Uri.parse(usuario.url);
                      if (await canLaunchUrl(url)) {
                        await launchUrl(url);
                      } else {
                        throw 'Could not launch $url';
                      }
                    },
                    child: const Text(
                      "Visitar perfil",
                      style: TextStyle(fontSize: 22, color: Colors.black),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: const Color.fromARGB(255, 199, 199, 199),
                    ),
                  ),
                )
              ],
            );
          } else if (snapshot.hasError) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.network(
                    "https://assets8.lottiefiles.com/packages/lf20_15jzhigy.json",
                    width: MediaQuery.of(context).size.width),
                const Text(
                  "Perfil não encontrado!",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 12),
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "VOLTAR",
                      style: TextStyle(fontSize: 22, color: Colors.black),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: const Color.fromARGB(255, 199, 199, 199),
                    ),
                  ),
                )
              ],
            );
          }

          return Center(
            child: Lottie.network(
                "https://assets1.lottiefiles.com/packages/lf20_usmfx6bp.json",
                width: 90),
          );
        },
      ),
    );
  }

  Future<User> _fetchUser() async {
    final response =
        await http.get(Uri.parse('https://api.github.com/users/$username'));

    if (response.statusCode == 200) {
      return User.fromJson(json.decode(response.body));
    } else {
      throw Exception('Algo deu errado');
    }
  }
}
