import 'package:flutter/material.dart';
import 'package:woordle/woordlescreen.dart';
import 'globals.dart';

void main() {
  runApp(Material_Woordle());
}

class Material_Woordle extends StatelessWidget {
  const Material_Woordle({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      home: Woordle(),
    );
  }
}

class Woordle extends StatefulWidget {
  const Woordle({super.key});

  @override
  State<Woordle> createState() => _WoordleState();
}

class _WoordleState extends State<Woordle> {
  @override
  void initState() {
    restart();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Woordle",
          ),
          leading: !ishomescreen
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      ishomescreen = true;
                    });
                  },
                  icon: Icon(Icons.arrow_back))
              : null,
          actions: [
            !ishomescreen
                ? IconButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: ((context) {
                            return AlertDialog(
                              title: Text("Restart?"),
                              content: Text(
                                  "Are you sure you want to start again?\nThis deletes your current woordle progress."),
                              actions: [
                                OutlinedButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text("No")),
                                OutlinedButton(
                                    onPressed: () {
                                      setState(() {
                                        Navigator.of(context).pop();
                                        restart();
                                      });
                                    },
                                    child: Text("Yes"))
                              ],
                            );
                          }));
                    },
                    icon: Icon(Icons.restart_alt))
                : SizedBox.shrink()
          ],
          centerTitle: true,
        ),
        body: ishomescreen
            ? Container(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    OutlinedButton(
                        onPressed: () {
                          setState(() {
                            ishomescreen = false;
                          });
                        },
                        child: Text("Play"))
                  ],
                ),
              )
            : Woordlescreen());
  }
}
