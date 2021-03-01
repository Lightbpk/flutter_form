import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum GenderList {male,female}

class MyForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MyFormState();
}

class MyFormState extends State {
  final _formkey = GlobalKey<FormState>();
  GenderList _gender;
  bool _agreement = false;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(10.0),
        child: new Form(
          key: _formkey,
          child: new Column(
            children: <Widget>[
              new Text(
                'Как звать?',
                style: TextStyle(fontSize: 20.0),
              ),
              new TextFormField(validator: (value) {
                if (value.isEmpty)
                  return "Введите что-то";
                else
                  return null;
              }),
              new SizedBox(
                height: 20.0,
              ),
              new Text(
                'мыло есть?',
                style: TextStyle(fontSize: 20.0),
              ),
              new TextFormField(
                validator: (value) {
                  if (value.isEmpty) return "мыло то хде?";
                  String p = "[a-zA-Z0-9+.\_\%-+]{1,256}@[a-zA-Z0-9][a-zA-Z0-9-]{0,64}(.[a-zA-Z0-9][a-zA-Z0-9-]{0,25})+";
                  RegExp regExp = new RegExp(p);
                  if (regExp.hasMatch(value)) return null;
                  return "че то вы мне парите";
                },
              ),
              new SizedBox(
                height: 20.0,
              ),

              new Text("Кто по жизни",
                style: TextStyle(fontSize: 20.0),),
              new RadioListTile(title: const Text('Мужик'), value: GenderList.male,
                  groupValue: _gender, onChanged: (GenderList value){setState(() {
                    _gender = value;
                  });}),
              new RadioListTile(title: const Text('Баба'), value: GenderList.female,
                  groupValue: _gender, onChanged: (GenderList value){setState(() {
                    _gender = value;
                  });}),
              new SizedBox(
                height: 20.0,
              ),
              new CheckboxListTile(value: _agreement,
                  title: new Text('Я ознакомлен'+(_gender == null?'(а)':_gender ==GenderList.male?'':'а')+
                      ' с документом "Согласие на обработку персональных данных" и даю согласие на обработку моих персональных данных в соответствии с требованиями "Федерального закона О персональных данных № 152-ФЗ" а также переписываете на Буглак ПК все свое имущество, ценные бумаги, транспорт и недвигу.'),
                  onChanged: (bool value) => setState(()=>_agreement = value)),
              new RaisedButton(
                onPressed: () {
                  if (_formkey.currentState.validate()) {
                    Color color = Colors.red;
                    String text;
                    if (_gender == null)
                      text = 'че не определился с полом еще?';
                    else if (_agreement == false)
                      text = 'не примите уловия - взорву ваше устройство';
                    else {
                      text = "Ну вот и ладушки";
                      color = Colors.green;
                    }
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(text),
                      backgroundColor: color,
                    ));
                  }
                },
                child: Text('проверить'),
                color: Colors.blue,
                textColor: Colors.white,
              ),
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
