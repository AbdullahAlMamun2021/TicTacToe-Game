import 'package:flutter/material.dart';
import 'package:tictactoe/src/presentation/screens/screen_gameboard.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Tic tac toe',
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 24),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('images/tic-tac.gif'),
             const  SizedBox(
                height: 40,
              ),
              InkWell(
                child: Container(
                  padding: const EdgeInsets.only(top: 12, bottom: 12),
                  margin: const EdgeInsets.only(left: 16, right: 16),
                  decoration: BoxDecoration(
                      color: Colors.black, borderRadius: BorderRadius.circular(15)),
                  child: const Center(
                      child: Text(
                    "Start Game",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                        color: Colors.white),
                  )),
                ),
                onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>const GameBoardScreen())),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
