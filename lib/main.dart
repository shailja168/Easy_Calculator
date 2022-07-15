// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  const Calculator({Key? key}) : super(key: key);

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  Widget calbutton(String bttext, btcolor, txtcolor) {
    return Container(
      child: RaisedButton(
        onPressed: (){
          calculation(bttext);
        },
        child: Text(bttext,
          style: TextStyle(
            fontSize: 30.0,
            color: txtcolor,
          ),
        ),
        shape: CircleBorder(),
        color: btcolor,
        padding: EdgeInsets.all(20.0),
      ), 
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 6, 25, 54),
      appBar: AppBar(
        title: Text('Calculator'),
        backgroundColor: Colors.purple[900],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            //Main Display
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    text,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 80,
                    ),
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //calling button functionality by passing some argument
                calbutton('AC', Colors.purple[900], Colors.white),
                calbutton('+/-', Colors.purple[900], Colors.white),
                calbutton('%', Colors.purple[900], Colors.white),
                calbutton('/', Colors.amber[700], Colors.white),
              ],
            ),
            SizedBox(height: 10.0,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //calling button functionality by passing some argument
                calbutton('7', Colors.grey[500], Colors.white),
                calbutton('8', Colors.grey[500], Colors.white),
                calbutton('9', Colors.grey[500], Colors.white),
                calbutton('*', Colors.amber[700], Colors.white),
              ],
            ),
            SizedBox(height: 10.0,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //calling button functionality by passing some argument
                calbutton('4', Colors.grey[500], Colors.white),
                calbutton('5', Colors.grey[500], Colors.white),
                calbutton('6', Colors.grey[500], Colors.white),
                calbutton('-', Colors.amber[700], Colors.white),
              ],
            ),
            SizedBox(height: 10.0,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //calling button functionality by passing some argument
                calbutton('1', Colors.grey[500], Colors.white),
                calbutton('2', Colors.grey[500], Colors.white),
                calbutton('3', Colors.grey[500], Colors.white),
                calbutton('+', Colors.amber[700], Colors.white),
              ],
            ),
            SizedBox(height: 10.0,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //This is button 0
                RaisedButton(
                  padding: EdgeInsets.fromLTRB(34.0, 20.0, 128.0, 20.0),
                  onPressed: (){
                    //button function
                    calculation('0');
                  },
                  shape: StadiumBorder(),
                  child: Text('0',
                    style: TextStyle(
                      fontSize: 35.0,
                      color: Colors.white,
                    ),
                  ),
                  color: Colors.grey,
                ),
                calbutton('.', Colors.grey[500], Colors.white),
                calbutton('=', Colors.amber[700], Colors.white),
              ],
            )
          ],
        ),
      ),
    );
  }

//Calculator logic
  dynamic text ='0';
  double numOne = 0;
  double numTwo = 0;

  dynamic result = '';
  dynamic finalResult = '';
  dynamic opr = '';
  dynamic preOpr = '';
   void calculation(btnText) {
    if(btnText  == 'AC') {
      text ='0';
      numOne = 0;
      numTwo = 0;
      result = '';
      finalResult = '0';
      opr = '';
      preOpr = '';
    } 
    else if( opr == '=' && btnText == '=') {
      if(preOpr == '+') {
         finalResult = add();
      } 
      else if( preOpr == '-') {
          finalResult = sub();
      } 
      else if( preOpr == '*') {
          finalResult = mul();
      } 
      else if( preOpr == '/') {
          finalResult = div();
      } 
    } 
    else if(btnText == '+' || btnText == '-' || btnText == '*' || btnText == '/' || btnText == '=') {
      if(numOne == 0) {
          numOne = double.parse(result);
      } 
      else {
          numTwo = double.parse(result);
      }

      if(opr == '+') {
          finalResult = add();
      }
      else if( opr == '-') {
          finalResult = sub();
      } 
      else if( opr == '*') {
          finalResult = mul();
      } 
      else if( opr == '/') {
          finalResult = div();
      } 
      preOpr = opr;
      opr = btnText;
      result = '';
    }
    else if(btnText == '%') {
     result = numOne / 100;
     finalResult = doesContainDecimal(result);
    } 
    else if(btnText == '.') {
      if(!result.toString().contains('.')) {
        result = result.toString()+'.';
      }
      finalResult = result;
    }
    else if(btnText == '+/-') {
        result.toString().startsWith('-') ? result = result.toString().substring(1): result = '-'+result.toString();        
        finalResult = result;        
    } 
    else{
        result = result + btnText;
        finalResult = result;        
    }

    setState(() {
          text = finalResult;
        });

  }
  String add() {
         result = (numOne + numTwo).toString();
         numOne = double.parse(result);           
         return doesContainDecimal(result);
  }

  String sub() {
         result = (numOne - numTwo).toString();
         numOne = double.parse(result);
         return doesContainDecimal(result);
  }
  String mul() {
         result = (numOne * numTwo).toString();
         numOne = double.parse(result);
         return doesContainDecimal(result);
  }
  String div() {
          result = (numOne / numTwo).toString();
          numOne = double.parse(result);
          return doesContainDecimal(result);
  }

  String doesContainDecimal(dynamic result) {

    if(result.toString().contains('.')) {
        List<String> splitDecimal = result.toString().split('.');
        if(!(int.parse(splitDecimal[1]) > 0))
         return result = splitDecimal[0].toString();
    }
    return result; 
  }
}
