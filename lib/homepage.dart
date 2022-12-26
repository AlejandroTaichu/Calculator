 import 'package:flutter/material.dart';
import 'package:calculator/main.dart';
import 'package:math_expressions/math_expressions.dart';

class Homepage extends StatefulWidget {
   @override
   State<Homepage> createState() => _HomepageState();
 }

 class _HomepageState extends State<Homepage> {
  String userInput = "";
  String result = "0";

  List<String> buttonList=[
    'AC',
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '+',
    '=',
  ];

   @override
   Widget build(BuildContext context) {
     return Scaffold(
       backgroundColor: Colors.indigo,
       body: Column(
         children: [
           SizedBox(
             height: MediaQuery.of(context).size.height/3,
             child: Column(
               mainAxisAlignment: MainAxisAlignment.end,
               children: [
                 Container(
                   padding: EdgeInsets.all(20),
                   alignment: Alignment.centerRight,
                   child: Text(
                     userInput,
                   style: TextStyle(
                       fontSize: 32,color: Colors.yellow
                   ),
                   ),
                 ),
                 Container(
                   padding: EdgeInsets.all(10),
                   alignment: Alignment.centerRight,
                   child: Text(
                     result,
                     style: TextStyle(
                         fontSize: 48,color: Colors.yellow,
                       fontWeight: FontWeight.bold,
                     ),
                   ),
                 ),
               ],),
           ),
           Divider(color: Colors.yellow),
           Expanded(child: Container(
             padding: EdgeInsets.all(10),
             child: GridView.builder(
                 itemCount: buttonList.length,
                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                     crossAxisCount: 4,
                     crossAxisSpacing: 12,
                     mainAxisSpacing: 12
                 ),
                 itemBuilder: (BuildContext contex, int index){
                   return CustomButton(buttonList[index]);
                 },
             ),
           ),
           ),
         ],
       ),
     );
   }
   Widget CustomButton(String text){
     return InkWell(
       splashColor: Colors.yellow,
        onTap: (){
         setState(() {
           handleButtons(text);
         });
        },
      child: Ink(
        decoration: BoxDecoration(
          color: Colors.yellow,
            borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              blurRadius: 4,
              spreadRadius: 0.5,
              offset: Offset(-3, 3),
            ),
          ],
     ),
        child: Center(
          child: Text(text,
          style: TextStyle(fontSize: 30,
              fontWeight: FontWeight.bold
          ),
          ),
        ),
       ),
     );
   }
  handleButtons(String text){
     if(text == "AC"){
       userInput = "";
       result = "0";
       return;
     }
     if(text == "="){
        result = calculate();
        if(result.endsWith(".0")){
          result = result.replaceAll(".0", "");
          return;
        }
     }
     userInput = userInput + text;
   }
   String calculate(){
     try{
       var exp = Parser().parse(userInput);
       var evaluation = exp.evaluate(EvaluationType.REAL, ContextModel());
       return evaluation.toString();
     }catch(e){
       return "Error";
     }
   }
 }