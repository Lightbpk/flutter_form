import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MyFormState();
}

class MyFormState extends State {
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(10.0),
        child: new Form(
          key: _formkey,
          child: new Column(
            children: <Widget>[
              new Text(
                'Введите текст',
                style: TextStyle(fontSize: 20.0),
              ),
              new TextFormField(validator: (value) {
                if (value.isEmpty) return "Введите чтото";
              }),
              new SizedBox(height: 20.0,),
              new RaisedButton(onPressed: () {
                if (_formkey.currentState.validate())
                  Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text('успех форма заполнена'),
                    backgroundColor: Colors.green,));
              },
                child: Text('проверить'),
                color: Colors.blue,
                textColor: Colors.white,),
            ],

          ),
        ));
  }
}

void main() {
  runApp(new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('Форма ввода'),
        ),
        body: new MyForm(),
      )));
}
