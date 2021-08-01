import 'package:flutter/material.dart';
import 'package:test_flutter_app/widgets/myAppBar.dart';
import 'package:test_flutter_app/widgets/myDrawer.dart';


class AboutPage extends StatefulWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(titleText: 'Обо мне',),
      drawer: MyDrawer(),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: Text('Меня зовут Дмитрий Донцов.', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Text(
                'Мне 24 года. Окончил бакалавриат (2015-2019) и магистратуру (2019-2021) '
                    'по направлению "Программная инженерия" в ВолгГТУ.',
                style: TextStyle(fontSize: 20, ),),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Text(
                'С программированием познакомился на уроках информатики в 9 классе. '
                    'Нам давали задачки, которые нужно было закодить на Pascal ABC. '
                    'В 10 классе рассказали и показали, что такое HTML и как на нём верстать.',
                style: TextStyle(fontSize: 20, ),),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Text(
                'На текущей работе занимаюсь вёрсткой лэндингов / сайтов, а также их дальнейшей поддержкой. '
                    'Front - ванильные HTML, CSS, JS. '
                    'Back - PHP, MySQL, CMS Bitrix, CMS Netcat, CMS Modx.',
                style: TextStyle(fontSize: 20, ),),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Text(
                'Хобби: музыка (игра на гитаре), волейбол, история кино, настольные игры.',
                style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic),),
            ),
          ],
        ),
      ),
    );
  }
}
