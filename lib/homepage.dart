import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  bool xTurn = true; // the first player is X
  List<String> displayXO = ['', '', '', '', '', '', '', '', '']; 
  int oScore = 0;
  int xScore = 0;
  int filledBoxes = 0;

  //Text Customization
  var textStyle = const TextStyle(color: Colors.white, fontSize: 30); 
  static var newFontBlack = GoogleFonts.pressStart2p(textStyle: const TextStyle(color: Colors.black, letterSpacing: 3)); 
  static var newFontWhite = GoogleFonts.pressStart2p(textStyle: const TextStyle(color: Colors.white, letterSpacing: 3, fontSize: 15)); 

  //Grid Customization
  static var backgroundColor = Colors.grey[900];
  static var gridColor = Colors.grey;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Column(
        children: [
          Expanded(
            child: Container(
              child:  Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Player X', style: newFontWhite),
                      Text(xScore.toString(), style: newFontWhite),
                    ],
                  ),
                  const SizedBox(width: 50),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Player O', style: newFontWhite),
                      Text(oScore.toString(), style: newFontWhite),
                    ],
                  ),
                ],
              ),
            )
          ),
          Expanded(
            flex: 3,
            child: GridView.builder(
              itemCount: 9,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3), 
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: (){
                    _tapped(index);
                  },
                  child: Container(
                    decoration:  BoxDecoration(
                      border: Border.all(color: gridColor),
                    ),
                    child: Center(
                      child: Text(displayXO[index], style: textStyle,),
                    )
                  ),
                );
              }),
          ),
          const SizedBox(height: 70),
          Expanded(
            child: Container(
              child: Text('TIC TAC TOE', style: newFontWhite,),
            )
          ),
        ],
      )
      );
  }

  void _tapped (int index) {
    setState((){
      if(xTurn && displayXO[index] == ''){
        displayXO[index] = 'x';
        filledBoxes += 1;
      } else if (!xTurn && displayXO[index] == ''){
        displayXO[index] = 'o'; 
        filledBoxes += 1; 
      }
      xTurn = !xTurn;
      _chekWinner();
    });
  }

  void _chekWinner(){

    bool drawChecker = true;

    // check first row
    if(displayXO[0] == displayXO[1] && displayXO[0] == displayXO[2] && displayXO[0] != ''){
      _showWinDialog(displayXO[0]);
      drawChecker = false;
    }

    // check second row
    if(displayXO[3] == displayXO[4] && displayXO[3] == displayXO[5] && displayXO[3] != ''){
      _showWinDialog(displayXO[3]);
      drawChecker = false;
    }

    // check third row
    if(displayXO[6] == displayXO[7] && displayXO[6] == displayXO[8] && displayXO[6] != ''){
      _showWinDialog(displayXO[6]);
      drawChecker = false;
    }

    // check first column
    if(displayXO[0] == displayXO[3] && displayXO[0] == displayXO[6] && displayXO[0] != ''){
      _showWinDialog(displayXO[0]);
      drawChecker = false;
    }

    // check second column
    if(displayXO[1] == displayXO[4] && displayXO[1] == displayXO[7] && displayXO[1] != ''){
      _showWinDialog(displayXO[1]);
      drawChecker = false;
    }

    // check third column
    if(displayXO[2] == displayXO[5] && displayXO[2] == displayXO[8] && displayXO[2] != ''){
      _showWinDialog(displayXO[2]);
      drawChecker = false;
    }

    // check main diagonal
    if(displayXO[0] == displayXO[4] && displayXO[0] == displayXO[8] && displayXO[0] != ''){
      _showWinDialog(displayXO[0]);
      drawChecker = false;
    }

    // check diagonal
    if(displayXO[2] == displayXO[4] && displayXO[2] == displayXO[6] && displayXO[2] != ''){
      _showWinDialog(displayXO[2]);
      drawChecker = false;
    }
    
    else if(filledBoxes == 9 && drawChecker){
      _showDrawDialog();
    }
  }

  void _showWinDialog(String winner){
    showDialog(
      barrierDismissible: false,
      context: context, 
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(winner + ' WINS', style: newFontBlack,),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                _clearBoard();
                Navigator.of(context).pop(); // deletes the barrier
              },
              child: Text('Play Again', style: newFontBlack,),
            )
          ],
        );
      });

    incrementWinnerScore(winner);
  }

  void _showDrawDialog(){
    showDialog(
      barrierDismissible: false,
      context: context, 
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('IT\'S A DRAW', style: newFontBlack,),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                _clearBoard();
                Navigator.of(context).pop(); // deletes the barrier
              },
              child: Text('Play Again', style: newFontBlack,),
            )
          ],
        );
      });
  }

  void _clearBoard(){
    setState(() {
      for(int i=0; i < displayXO.length; i++){
        displayXO[i] = '';
      }
      filledBoxes = 0;
    });
  }

  void incrementWinnerScore(String winner){
    if(winner == 'o'){
      oScore += 1;
    } else{
      xScore += 1;
    }
  }
}