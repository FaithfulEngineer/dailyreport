import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './icon_select_model.dart';
import '/domain/setting.dart';

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

Widget _iconButtonset(BuildContext context, int index, int onoff) {
  switch (index) {
    case 1:
      return IconButton(
        icon: Icon(
          Icons.account_circle,
        ),
        iconSize: 32,
        color: (onoff == 0) ? Colors.black : Colors.grey,
        onPressed: () {
          if (onoff == 0)
            Navigator.of(context).pop('01');
          else
            null;
        },
      );

    case 2:
      return IconButton(
        icon: Icon(
          Icons.info,
        ),
        iconSize: 32,
        color: (onoff == 0) ? Colors.black : Colors.grey,
        onPressed: () {
          if (onoff == 0)
            Navigator.of(context).pop('02');
          else
            null;
        },
      );

    case 3:
      return IconButton(
        icon: Icon(
          Icons.check_circle,
        ),
        iconSize: 32,
        color: (onoff == 0) ? Colors.black : Colors.grey,
        onPressed: () {
          if (onoff == 0)
            Navigator.of(context).pop('03');
          else
            null;
        },
      );
    case 4:
      return IconButton(
        icon: Icon(
          Icons.article,
        ),
        iconSize: 32,
        color: (onoff == 0) ? Colors.black : Colors.grey,
        onPressed: () {
          if (onoff == 0)
            Navigator.of(context).pop('04');
          else
            null;
        },
      );
    case 5:
      return IconButton(
        icon: Icon(
          Icons.schedule,
        ),
        iconSize: 32,
        color: (onoff == 0) ? Colors.black : Colors.grey,
        onPressed: () {
          if (onoff == 0)
            Navigator.of(context).pop('05');
          else
            null;
        },
      );
    case 6:
      return IconButton(
        icon: Icon(
          Icons.event,
        ),
        iconSize: 32,
        color: (onoff == 0) ? Colors.black : Colors.grey,
        onPressed: () {
          if (onoff == 0)
            Navigator.of(context).pop('06');
          else
            null;
        },
      );
    case 7:
      return IconButton(
        icon: Icon(
          Icons.thumb_up,
        ),
        iconSize: 32,
        color: (onoff == 0) ? Colors.black : Colors.grey,
        onPressed: () {
          if (onoff == 0)
            Navigator.of(context).pop('07');
          else
            null;
        },
      );
    case 8:
      return IconButton(
        icon: Icon(
          Icons.sick,
        ),
        iconSize: 32,
        color: (onoff == 0) ? Colors.black : Colors.grey,
        onPressed: () {
          if (onoff == 0)
            Navigator.of(context).pop('08');
          else
            null;
        },
      );
    case 9:
      return IconButton(
        icon: Icon(
          Icons.mail,
        ),
        iconSize: 32,
        color: (onoff == 0) ? Colors.black : Colors.grey,
        onPressed: () {
          if (onoff == 0)
            Navigator.of(context).pop('09');
          else
            null;
        },
      );
    case 10:
      return IconButton(
        icon: Icon(
          Icons.flag,
        ),
        iconSize: 32,
        color: (onoff == 0) ? Colors.black : Colors.grey,
        onPressed: () {
          if (onoff == 0)
            Navigator.of(context).pop('10');
          else
            null;
        },
      );
    case 11:
      return IconButton(
        icon: Icon(
          Icons.report,
        ),
        iconSize: 32,
        color: (onoff == 0) ? Colors.black : Colors.grey,
        onPressed: () {
          if (onoff == 0)
            Navigator.of(context).pop('11');
          else
            null;
        },
      );
    case 12:
      return IconButton(
        icon: Icon(
          Icons.camera,
        ),
        iconSize: 32,
        color: (onoff == 0) ? Colors.black : Colors.grey,
        onPressed: () {
          if (onoff == 0)
            Navigator.of(context).pop('12');
          else
            null;
        },
      );
    case 13:
      return IconButton(
        icon: Icon(
          Icons.favorite_border,
        ),
        iconSize: 32,
        color: (onoff == 0) ? Colors.black : Colors.grey,
        onPressed: () {
          if (onoff == 0)
            Navigator.of(context).pop('13');
          else
            null;
        },
      );

    case 14:
      return IconButton(
        icon: Icon(
          Icons.local_hospital,
        ),
        iconSize: 32,
        color: (onoff == 0) ? Colors.black : Colors.grey,
        onPressed: () {
          if (onoff == 0)
            Navigator.of(context).pop('14');
          else
            null;
        },
      );

    case 15:
      return IconButton(
        icon: Icon(
          Icons.paid,
        ),
        iconSize: 32,
        color: (onoff == 0) ? Colors.black : Colors.grey,
        onPressed: () {
          if (onoff == 0)
            Navigator.of(context).pop('15');
          else
            null;
        },
      );

    case 16:
      return IconButton(
        icon: Icon(
          Icons.star_rate,
        ),
        iconSize: 32,
        color: (onoff == 0) ? Colors.black : Colors.grey,
        onPressed: () {
          if (onoff == 0)
            Navigator.of(context).pop('16');
          else
            null;
        },
      );

    case 17:
      return IconButton(
        icon: Icon(
          Icons.outbond,
        ),
        iconSize: 32,
        color: (onoff == 0) ? Colors.black : Colors.grey,
        onPressed: () {
          if (onoff == 0)
            Navigator.of(context).pop('17');
          else
            null;
        },
      );

    case 18:
      return IconButton(
        icon: Icon(
          Icons.lightbulb_outline,
        ),
        iconSize: 32,
        color: (onoff == 0) ? Colors.black : Colors.grey,
        onPressed: () {
          if (onoff == 0)
            Navigator.of(context).pop('18');
          else
            null;
        },
      );

    case 19:
      return IconButton(
        icon: Icon(
          Icons.people_alt,
        ),
        iconSize: 32,
        color: (onoff == 0) ? Colors.black : Colors.grey,
        onPressed: () {
          if (onoff == 0)
            Navigator.of(context).pop('19');
          else
            null;
        },
      );

    case 20:
      return IconButton(
        icon: Icon(
          Icons.water_drop,
        ),
        iconSize: 32,
        color: (onoff == 0) ? Colors.black : Colors.grey,
        onPressed: () {
          if (onoff == 0)
            Navigator.of(context).pop('20');
          else
            null;
        },
      );

    case 21:
      return IconButton(
        icon: Icon(
          Icons.waving_hand,
        ),
        iconSize: 32,
        color: (onoff == 0) ? Colors.black : Colors.grey,
        onPressed: () {
          if (onoff == 0)
            Navigator.of(context).pop('21');
          else
            null;
        },
      );

    case 22:
      return IconButton(
        icon: Icon(
          Icons.send,
        ),
        iconSize: 32,
        color: (onoff == 0) ? Colors.black : Colors.grey,
        onPressed: () {
          if (onoff == 0)
            Navigator.of(context).pop('22');
          else
            null;
        },
      );

    case 23:
      return IconButton(
        icon: Icon(
          Icons.insights,
        ),
        iconSize: 32,
        color: (onoff == 0) ? Colors.black : Colors.grey,
        onPressed: () {
          if (onoff == 0)
            Navigator.of(context).pop('23');
          else
            null;
        },
      );

    case 24:
      return IconButton(
        icon: Icon(
          Icons.edit,
        ),
        iconSize: 32,
        color: (onoff == 0) ? Colors.black : Colors.grey,
        onPressed: () {
          if (onoff == 0)
            Navigator.of(context).pop('24');
          else
            null;
        },
      );

    case 25:
      return IconButton(
        icon: Icon(
          Icons.music_note,
        ),
        iconSize: 32,
        color: (onoff == 0) ? Colors.black : Colors.grey,
        onPressed: () {
          if (onoff == 0)
            Navigator.of(context).pop('25');
          else
            null;
        },
      );

    case 26:
      return IconButton(
        icon: Icon(
          Icons.bedtime,
        ),
        iconSize: 32,
        color: (onoff == 0) ? Colors.black : Colors.grey,
        onPressed: () {
          if (onoff == 0)
            Navigator.of(context).pop('26');
          else
            null;
        },
      );

    case 27:
      return IconButton(
        icon: Icon(
          Icons.currency_yen,
        ),
        iconSize: 32,
        color: (onoff == 0) ? Colors.black : Colors.grey,
        onPressed: () {
          if (onoff == 0)
            Navigator.of(context).pop('27');
          else
            null;
        },
      );

    case 28:
      return IconButton(
        icon: Icon(
          Icons.key,
        ),
        iconSize: 32,
        color: (onoff == 0) ? Colors.black : Colors.grey,
        onPressed: () {
          if (onoff == 0)
            Navigator.of(context).pop('28');
          else
            null;
        },
      );

    case 29:
      return IconButton(
        icon: Icon(
          Icons.stay_current_portrait,
        ),
        iconSize: 32,
        color: (onoff == 0) ? Colors.black : Colors.grey,
        onPressed: () {
          if (onoff == 0)
            Navigator.of(context).pop('29');
          else
            null;
        },
      );

    case 30:
      return IconButton(
        icon: Icon(
          Icons.directions_run,
        ),
        iconSize: 32,
        color: (onoff == 0) ? Colors.black : Colors.grey,
        onPressed: () {
          if (onoff == 0)
            Navigator.of(context).pop('30');
          else
            null;
        },
      );

    case 31:
      return IconButton(
        icon: Icon(
          Icons.directions_walk,
        ),
        iconSize: 32,
        color: (onoff == 0) ? Colors.black : Colors.grey,
        onPressed: () {
          if (onoff == 0)
            Navigator.of(context).pop('31');
          else
            null;
        },
      );

    case 32:
      return IconButton(
        icon: Icon(
          Icons.directions_bike,
        ),
        iconSize: 32,
        color: (onoff == 0) ? Colors.black : Colors.grey,
        onPressed: () {
          if (onoff == 0)
            Navigator.of(context).pop('32');
          else
            null;
        },
      );

    case 33:
      return IconButton(
        icon: Icon(
          Icons.fastfood,
        ),
        iconSize: 32,
        color: (onoff == 0) ? Colors.black : Colors.grey,
        onPressed: () {
          if (onoff == 0)
            Navigator.of(context).pop('33');
          else
            null;
        },
      );

    case 34:
      return IconButton(
        icon: Icon(
          Icons.directions_bus,
        ),
        iconSize: 32,
        color: (onoff == 0) ? Colors.black : Colors.grey,
        onPressed: () {
          if (onoff == 0)
            Navigator.of(context).pop('34');
          else
            null;
        },
      );

    case 35:
      return IconButton(
        icon: Icon(
          Icons.local_florist,
        ),
        iconSize: 32,
        color: (onoff == 0) ? Colors.black : Colors.grey,
        onPressed: () {
          if (onoff == 0)
            Navigator.of(context).pop('35');
          else
            null;
        },
      );

    case 36:
      return IconButton(
        icon: Icon(Icons.play_circle),
        iconSize: 32,
        color: (onoff == 0) ? Colors.black : Colors.grey,
        onPressed: () {
          if (onoff == 0)
            Navigator.of(context).pop('36');
          else
            null;
        },
      );

    case 37:
      return IconButton(
        icon: Icon(Icons.savings),
        iconSize: 32,
        color: (onoff == 0) ? Colors.black : Colors.grey,
        onPressed: () {
          if (onoff == 0)
            Navigator.of(context).pop('37');
          else
            null;
        },
      );

    case 38:
      return IconButton(
        icon: Icon(Icons.arrow_right_alt),
        iconSize: 32,
        color: (onoff == 0) ? Colors.black : Colors.grey,
        onPressed: () {
          if (onoff == 0)
            Navigator.of(context).pop('38');
          else
            null;
        },
      );

    case 39:
      return IconButton(
        icon: Icon(Icons.pets),
        iconSize: 32,
        color: (onoff == 0) ? Colors.black : Colors.grey,
        onPressed: () {
          if (onoff == 0)
            Navigator.of(context).pop('39');
          else
            null;
        },
      );

    case 40:
      return IconButton(
        icon: Icon(Icons.flight_takeoff),
        iconSize: 32,
        color: (onoff == 0) ? Colors.black : Colors.grey,
        onPressed: () {
          if (onoff == 0)
            Navigator.of(context).pop('40');
          else
            null;
        },
      );

    case 41:
      return IconButton(
        icon: Icon(Icons.extension),
        iconSize: 32,
        color: (onoff == 0) ? Colors.black : Colors.grey,
        onPressed: () {
          if (onoff == 0)
            Navigator.of(context).pop('41');
          else
            null;
        },
      );

    case 42:
      return IconButton(
        icon: Icon(Icons.rocket_launch),
        iconSize: 32,
        color: (onoff == 0) ? Colors.black : Colors.grey,
        onPressed: () {
          if (onoff == 0)
            Navigator.of(context).pop('42');
          else
            null;
        },
      );

    case 43:
      return IconButton(
        icon: Icon(Icons.nightlight_round),
        iconSize: 32,
        color: (onoff == 0) ? Colors.black : Colors.grey,
        onPressed: () {
          if (onoff == 0)
            Navigator.of(context).pop('43');
          else
            null;
        },
      );

    case 44:
      return IconButton(
        icon: Icon(Icons.anchor),
        iconSize: 32,
        color: (onoff == 0) ? Colors.black : Colors.grey,
        onPressed: () {
          if (onoff == 0)
            Navigator.of(context).pop('44');
          else
            null;
        },
      );

    case 45:
      return IconButton(
        icon: Icon(Icons.home_filled),
        iconSize: 32,
        color: (onoff == 0) ? Colors.black : Colors.grey,
        onPressed: () {
          if (onoff == 0)
            Navigator.of(context).pop('45');
          else
            null;
        },
      );

    case 46:
      return IconButton(
        icon: Icon(Icons.transcribe),
        iconSize: 32,
        color: (onoff == 0) ? Colors.black : Colors.grey,
        onPressed: () {
          if (onoff == 0)
            Navigator.of(context).pop('46');
          else
            null;
        },
      );

    case 47:
      return IconButton(
        icon: Icon(Icons.school),
        iconSize: 32,
        color: (onoff == 0) ? Colors.black : Colors.grey,
        onPressed: () {
          if (onoff == 0)
            Navigator.of(context).pop('47');
          else
            null;
        },
      );

    case 48:
      return IconButton(
        icon: Icon(Icons.sports_esports),
        iconSize: 32,
        color: (onoff == 0) ? Colors.black : Colors.grey,
        onPressed: () {
          if (onoff == 0)
            Navigator.of(context).pop('48');
          else
            null;
        },
      );

    case 49:
      return IconButton(
        icon: Icon(Icons.self_improvement),
        iconSize: 32,
        color: (onoff == 0) ? Colors.black : Colors.grey,
        onPressed: () {
          if (onoff == 0)
            Navigator.of(context).pop('49');
          else
            null;
        },
      );

    case 50:
      return IconButton(
        icon: Icon(Icons.cake),
        iconSize: 32,
        color: (onoff == 0) ? Colors.black : Colors.grey,
        onPressed: () {
          if (onoff == 0)
            Navigator.of(context).pop('50');
          else
            null;
        },
      );

    case 51:
      return IconButton(
        icon: Icon(Icons.whatsapp),
        iconSize: 32,
        color: (onoff == 0) ? Colors.black : Colors.grey,
        onPressed: () {
          if (onoff == 0)
            Navigator.of(context).pop('51');
          else
            null;
        },
      );

    case 52:
      return IconButton(
        icon: Icon(Icons.emoji_emotions),
        iconSize: 32,
        color: (onoff == 0) ? Colors.black : Colors.grey,
        onPressed: () {
          if (onoff == 0)
            Navigator.of(context).pop('52');
          else
            null;
        },
      );

    case 53:
      return IconButton(
        icon: Icon(Icons.front_hand),
        iconSize: 32,
        color: (onoff == 0) ? Colors.black : Colors.grey,
        onPressed: () {
          if (onoff == 0)
            Navigator.of(context).pop('53');
          else
            null;
        },
      );

    case 54:
      return IconButton(
        icon: Icon(Icons.woman),
        iconSize: 32,
        color: (onoff == 0) ? Colors.black : Colors.grey,
        onPressed: () {
          if (onoff == 0)
            Navigator.of(context).pop('54');
          else
            null;
        },
      );

    default:
      return Icon(Icons.stop, size: 64, color: Colors.red);
      break;
  }
}

bool _flg = false;

class Iconsetting extends StatelessWidget {
  final String email;
  Iconsetting(this.email);

  @override
  Widget build(BuildContext context) {
    onWillPop:
    () {
      Navigator.of(context).pop();
      return Future.value(false);
    };

    return ChangeNotifierProvider<IconListModel>(
        create: (_) => IconListModel()..iconfetchList(email),
        child: Scaffold(
          appBar: AppBar(
            title: Text("アイコン設定"),
          ),
          body: Center(
            child: Consumer<IconListModel>(builder: (context, model, child) {
              final Setting = model.settings;

              if (Setting == null) {
                return CircularProgressIndicator();
              }

              return Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(top: 32),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      for (int idx = 1; idx < 7; idx++) ...[
                        _iconButtonset(context, idx, model.GetTypes(idx))
                      ],
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 32),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      for (int idx = 7; idx < 13; idx++) ...[
                        _iconButtonset(context, idx, model.GetTypes(idx))
                      ],
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 32),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      for (int idx = 13; idx < 19; idx++) ...[
                        _iconButtonset(context, idx, model.GetTypes(idx))
                      ],
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 32),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      for (int idx = 19; idx < 25; idx++) ...[
                        _iconButtonset(context, idx, model.GetTypes(idx))
                      ],
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 32),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      for (int idx = 25; idx < 31; idx++) ...[
                        _iconButtonset(context, idx, model.GetTypes(idx))
                      ],
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 32),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      for (int idx = 31; idx < 37; idx++) ...[
                        _iconButtonset(context, idx, model.GetTypes(idx)),
                      ],
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 32),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      for (int idx = 37; idx < 43; idx++) ...[
                        _iconButtonset(context, idx, model.GetTypes(idx)),
                      ],
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 32),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      for (int idx = 43; idx < 49; idx++) ...[
                        _iconButtonset(context, idx, model.GetTypes(idx)),
                      ],
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 32),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      for (int idx = 49; idx < 55; idx++) ...[
                        _iconButtonset(context, idx, model.GetTypes(idx)),
                      ],
                    ],
                  ),
                ],
              );
            }),
          ),
        ));
  }
}
