import 'package:flutter/material.dart';
import 'globals.dart';

class Woordlescreen extends StatefulWidget {
  const Woordlescreen({super.key});

  @override
  State<Woordlescreen> createState() => _WoordlescreenState();
}

class _WoordlescreenState extends State<Woordlescreen> {
  void onenter() {
    if (!guess.contains(" ")) {
      if (allwords.contains(guess.toLowerCase())) {
        setState(() {
          if (words[6 - tries][0].letter == answer[0]) {
            words[6 - tries][0].color = Colors.green;
          } else {
            if (answer.contains(words[6 - tries][0].letter)) {
              words[6 - tries][0].color = Color.fromARGB(231, 245, 221, 0);
            } else {
              words[6 - tries][0].color = Colors.red;
            }
          }

          if (words[6 - tries][1].letter == answer[1]) {
            words[6 - tries][1].color = Colors.green;
          } else {
            if (answer.contains(words[6 - tries][1].letter)) {
              words[6 - tries][1].color = Color.fromARGB(231, 245, 221, 0);
            } else {
              words[6 - tries][1].color = Colors.red;
            }
          }

          if (words[6 - tries][2].letter == answer[2]) {
            words[6 - tries][2].color = Colors.green;
          } else {
            if (answer.contains(words[6 - tries][2].letter)) {
              words[6 - tries][2].color = Color.fromARGB(231, 245, 221, 0);
            } else {
              words[6 - tries][2].color = Colors.red;
            }
          }

          if (words[6 - tries][3].letter == answer[3]) {
            words[6 - tries][3].color = Colors.green;
          } else {
            if (answer.contains(words[6 - tries][3].letter)) {
              words[6 - tries][3].color = Color.fromARGB(231, 245, 221, 0);
            } else {
              words[6 - tries][3].color = Colors.red;
            }
          }

          if (words[6 - tries][4].letter == answer[4]) {
            words[6 - tries][4].color = Colors.green;
          } else {
            if (answer.contains(words[6 - tries][4].letter)) {
              words[6 - tries][4].color = Color.fromARGB(231, 245, 221, 0);
            } else {
              words[6 - tries][4].color = Colors.red;
            }
          }
          tries = tries - 1;
          if (guess.toLowerCase() == answer.toLowerCase()) {
            won = 1;
          } else {
            if (tries == 0) {
              won = -1;
            }
          }
          if (won != 0) {
            showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) {
                return SimpleDialog(
                  title: Text(won == 1 ? "You won" : "You lost"),
                  children: [
                    SimpleDialogOption(
                      child: Text("The word was ${answer}."),
                    ),
                    SimpleDialogOption(
                      child: Text("Play Again?"),
                    ),
                    SimpleDialogOption(
                      child: Text("No"),
                      onPressed: () {
                        setState(() {
                          Navigator.of(context).pop();
                        });
                      },
                    ),
                    SimpleDialogOption(
                      child: Text("Yes"),
                      onPressed: () {
                        setState(() {
                          Navigator.of(context).pop();
                          restart();
                        });
                      },
                    ),
                  ],
                );
              },
            );
          }
          guess = "     ";
        });
      } else {
        final nodicsnack = SnackBar(content: Text("Not in dictionary"));
        ScaffoldMessenger.of(context).showSnackBar(nodicsnack);
      }
    } else {
      final tooshort = SnackBar(content: Text("Too short"));
      ScaffoldMessenger.of(context).showSnackBar(tooshort);
    }
    ;
  }

  void handeltext(int index) {
    String typedlet = abc[index];
    String upcome = "";
    bool update = false;
    if (typedlet == "⌫" && guess != "     ") {
      update = true;
      for (String i in guess.split("")) {
        if (i == " ") {
          break;
        } else {
          upcome = upcome + i;
        }
      }
      upcome = upcome.substring(0, upcome.length - 1);
      while (upcome.length != 5) {
        upcome = upcome + " ";
      }
    }
    if (typedlet != "⌫" && guess.contains(" ")) {
      update = true;
      for (String i in guess.split("")) {
        if (i == " ") {
          break;
        } else {
          upcome = upcome + i;
        }
      }
      upcome = upcome + typedlet;
      while (upcome.length != 5) {
        upcome = upcome + " ";
      }
    }
    if (update == true) {
      guess = upcome;
      setState(() {
        words[6 - tries][0].letter = guess[0];
        words[6 - tries][1].letter = guess[1];
        words[6 - tries][2].letter = guess[2];
        words[6 - tries][3].letter = guess[3];
        words[6 - tries][4].letter = guess[4];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(70),
            child: GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: (words.length * answer.length),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 9,
                    mainAxisSpacing: 9,
                    crossAxisCount: answer.length),
                itemBuilder: (BuildContext c, int index) {
                  int row = (index / answer.length).floor();
                  int col = (index % answer.length);
                  Word word = words[row][col];
                  return AnimatedContainer(
                    height: 20,
                    width: 20,
                    duration: Duration(seconds: 2),
                    foregroundDecoration:
                        BoxDecoration(border: Border.all(color: Colors.grey)),
                    color: word.color,
                    child: Center(
                        child: Text(
                      word.letter,
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    )),
                  );
                }),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: 27,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisSpacing: 9, crossAxisSpacing: 9, crossAxisCount: 7),
                itemBuilder: (BuildContext b, int index) {
                  return InkWell(
                    onTap: () {
                      handeltext(index);
                    },
                    child: Container(
                      height: 15,
                      width: 15,
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(7)),
                      child: Center(child: Text(abc[index])),
                    ),
                  );
                }),
          ),
          TextButton(onPressed: () => onenter(), child: Text("Enter")),
        ],
      ),
    );
    ;
  }
}
