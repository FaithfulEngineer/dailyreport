import 'package:flutter/material.dart';

Widget _iconset(int index) {
  switch (index) {
    case 1:
      return Icon(Icons.account_circle, size: 64, color: Colors.black);
      break;
    case 2:
      return Icon(Icons.info, size: 64, color: Colors.black);
      break;
    case 3:
      return Icon(Icons.check_circle, size: 64, color: Colors.black);
      break;
    case 4:
      return Icon(Icons.article, size: 64, color: Colors.black);
      break;
    case 5:
      return Icon(Icons.schedule, size: 64, color: Colors.black);
      break;
    case 6:
      return Icon(Icons.event, size: 64, color: Colors.black);
      break;
    case 7:
      return Icon(Icons.thumb_up, size: 64, color: Colors.black);
      break;
    case 8:
      return Icon(Icons.sick, size: 64, color: Colors.black);
      break;
    case 9:
      return Icon(Icons.mail, size: 64, color: Colors.black);

      break;
    case 10:
      return Icon(Icons.flag, size: 64, color: Colors.black);
      break;
    case 11:
      return Icon(Icons.report, size: 64, color: Colors.black);
      break;
    case 12:
      return Icon(Icons.camera, size: 64, color: Colors.black);
      break;
    default:
      return Icon(Icons.stop, size: 64, color: Colors.red);
      break;
  }
}

Widget _iconButtonset(BuildContext context, int index) {
  switch (index) {
    case 1:
      return IconButton(
        icon: Icon(
          Icons.account_circle,
        ),
        iconSize: 64,
        color: Colors.black,
        onPressed: () => {Navigator.of(context).pop('01')},
      );
      break;
    case 2:
      return IconButton(
        icon: Icon(
          Icons.info,
        ),
        iconSize: 64,
        color: Colors.black,
        onPressed: () => {Navigator.of(context).pop('02')},
      );
      break;
    case 3:
      return IconButton(
        icon: Icon(
          Icons.check_circle,
        ),
        iconSize: 64,
        color: Colors.black,
        onPressed: () => {Navigator.of(context).pop('03')},
      );
      break;
    case 4:
      return IconButton(
        icon: Icon(
          Icons.article,
        ),
        iconSize: 64,
        color: Colors.black,
        onPressed: () => {Navigator.of(context).pop('04')},
      );
      break;
    case 5:
      return IconButton(
        icon: Icon(
          Icons.schedule,
        ),
        iconSize: 64,
        color: Colors.black,
        onPressed: () => {Navigator.of(context).pop('05')},
      );
      break;
    case 6:
      return IconButton(
        icon: Icon(
          Icons.event,
        ),
        iconSize: 64,
        color: Colors.black,
        onPressed: () => {Navigator.of(context).pop('06')},
      );
      break;
    case 7:
      return IconButton(
        icon: Icon(
          Icons.thumb_up,
        ),
        iconSize: 64,
        color: Colors.black,
        onPressed: () => {Navigator.of(context).pop('07')},
      );
      break;
    case 8:
      return IconButton(
        icon: Icon(
          Icons.sick,
        ),
        iconSize: 64,
        color: Colors.black,
        onPressed: () => {Navigator.of(context).pop('08')},
      );
      break;
    case 9:
      return IconButton(
        icon: Icon(
          Icons.mail,
        ),
        iconSize: 64,
        color: Colors.black,
        onPressed: () => {Navigator.of(context).pop('09')},
      );
      break;
    case 10:
      return IconButton(
        icon: Icon(
          Icons.flag,
        ),
        iconSize: 64,
        color: Colors.black,
        onPressed: () => {Navigator.of(context).pop('10')},
      );
      break;
    case 11:
      return IconButton(
        icon: Icon(
          Icons.report,
        ),
        iconSize: 64,
        color: Colors.black,
        onPressed: () => {Navigator.of(context).pop('11')},
      );
      break;
    case 12:
      return IconButton(
        icon: Icon(
          Icons.camera,
        ),
        iconSize: 64,
        color: Colors.black,
        onPressed: () => {Navigator.of(context).pop('12')},
      );
      break;
    default:
      return Icon(Icons.stop, size: 64, color: Colors.red);
      break;
  }
}

class Iconsetting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    onWillPop:
    () {
      Navigator.of(context).pop();
      return Future.value(false);
    };
    return Scaffold(
      appBar: AppBar(
        title: Text("アイコン設定"),
      ),
      body: Column(
        children: <Widget>[
          //for (int idx2 = 1; idx2>4; idx2++)...[
          Container(
            padding: EdgeInsets.only(top: 32),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              for (int idx = 1; idx < 4; idx++) ...[
                _iconButtonset(context, idx)
              ],
            ],
          ),
          Container(
            padding: EdgeInsets.only(top: 32),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              for (int idx = 4; idx < 7; idx++) ...[
                _iconButtonset(context, idx)
              ],
            ],
          ),
          Container(
            padding: EdgeInsets.only(top: 32),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              for (int idx = 7; idx < 10; idx++) ...[
                _iconButtonset(context, idx)
              ],
            ],
          ),
          Container(
            padding: EdgeInsets.only(top: 32),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              for (int idx = 10; idx < 13; idx++) ...[
                _iconButtonset(context, idx)
              ],
            ],
          ),
        ],
      ),
    );
  }
}
