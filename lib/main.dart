import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:async';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Calculateur de Kalorie'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  double poids;
  int calorieAvecBase ;
  int calorieAvecActivite;
  double age ;
  bool genre =false;
  double taille = 170.0 ;
  int radioSelectionnee;
  Map mapActivite = {
    "faible":0,
    "modere":1,
    "fort":2
  } ;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    /******veirifie le type de la platforme*****/
    if(Platform.isIOS)
      {
     print("nous sommes pas sur ios");
      }
      else {
      print("nous  sommes  sur ios");
    }
    return new GestureDetector(
      onTap: (() => FocusScope.of(context).requestFocus(new FocusNode())),
      child: new Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          backgroundColor: setColor(),

        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              padding(),
              textAvecStyle("remplissez tous les chmaps pour obtenir votre besoin journalier"),
              padding(),
              new Card(
                elevation: 10.0,
                child: new Column(
                  children: <Widget>[
                    padding(),
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly ,
                      children: <Widget>[
                        textAvecStyle("femme",color: Colors.pink),
                        new Switch(value: genre,
                            activeTrackColor: Colors.blue,
                            inactiveTrackColor: Colors.pink

                            , onChanged: (bool b){
                          genre = b ;
                        }),
                        textAvecStyle('homme',color:Colors.blue)
                      ],
                    ),
                    padding(),
                    new RaisedButton(
                      color: setColor(),
                      child: textAvecStyle((age==null)? "Appuyer pour entre votre age": "Votre age est : ${age.toInt()}",
                      color: Colors.white),
                        onPressed: (() => montrerPicker())
                    ),
                    padding(),
                    textAvecStyle("Votre taille est  de: ${taille.toInt()} cm.",color: setColor()),
                    padding(),
                    new Slider(value: taille,
                      activeColor: setColor(),
                      onChanged: (double d) {
                      setState(() {
                        taille = d ;
                      });
                    },
                      max: 215.0,
                      min: 100,
                    ),
                    padding(),
                    new TextField(
                      keyboardType: TextInputType.number,
                      onChanged: (String string) {
                        setState(() {
                          poids = double.tryParse(string);
                        });
                      },
                      decoration: new InputDecoration(
                          labelText: "Entrer votre poids en kilos"),
                    ),
                    padding(),
                    textAvecStyle("Quelle est votre activité sportive?",color:setColor()),
                    padding(),
                    rowRadio(),
                    padding()
                  ],
                ),
              ),
              padding(),
              new RaisedButton(
                color:setColor(),
              child: textAvecStyle("calculer",color:Colors.white)
              ,onPressed: calculeNombreDeCalories,)
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _incrementCounter,
          tooltip: 'Increment',
          child: Icon(Icons.add),
        ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }

  Padding padding()
  {
    return new Padding(padding: EdgeInsets.only(top:20.0)) ;
  }

Future<Null> montrerPicker()  async
  {

     DateTime choix = await showDatePicker(
        context: context,
        initialDate: new DateTime.now(),
        firstDate: new DateTime(1990),
        lastDate: new DateTime.now(),
       initialDatePickerMode: DatePickerMode.year
     );

       if(choix != null)
         {
           var difference = new DateTime.now().difference(choix);
           var jour  = difference.inDays;
           var ans = (jour / 365) ;

           setState(() {
             age = ans;
           });
         }
  }

   Color setColor()
   {
     if (genre) {
       return Colors.blue;
     }
     else {
       return Colors.pink;
     }
   }
  Text textAvecStyle(String data, {color: Colors.black, fontSize: 15.0}) {
    return new Text(data,
        textAlign: TextAlign.center,
        style: new TextStyle(color: color, fontSize: fontSize));
  }

  Row rowRadio () {
    List<Widget> l = [];
    mapActivite.forEach((key,value) {
      Column colonne  =  new Column(
        mainAxisAlignment: MainAxisAlignment.center ,
        children: <Widget>[
          new Radio(
              activeColor: setColor(),
              value: value,
              groupValue: radioSelectionnee,
              onChanged: (Object i) {
           setState(() {
             radioSelectionnee = i ;
           });
          }),
          textAvecStyle(key, color: setColor() )
        ],
      );
      l.add(colonne);
    });
    return new Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly ,
      children: l,
    ) ;
  }
  void calculeNombreDeCalories (){
    if(age !=null && poids != null && radioSelectionnee !=null)
      {

      }
      else {
           alerte() ;
    }
  }

  Future<Null> alerte() async {

    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext buildContext) {
        return new AlertDialog(
          title: textAvecStyle("Erreur"),
          content: textAvecStyle("Tous les champs ne sont pas rempplir"),
          actions: <Widget>[
            new FlatButton(
                onPressed: () {
                  Navigator.pop(buildContext);
                },
                child: textAvecStyle("ok", color: Colors.red))
          ],
        );
      }
    );}

}
