import 'package:app_weather/bloc/weather_bloc.dart';
import 'package:app_weather/bloc/weather_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final bloc = WeatherBloc(WeatherRepository());
  TextEditingController _controller = TextEditingController();
  String city = "Бишкек";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: BlocBuilder(
          bloc: bloc,
          builder: (context, state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  city,
                  style: Theme.of(context).textTheme.headline4,
                ),
                SizedBox(height: 30),
                Container(
                  padding: EdgeInsets.all(20),
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(hintText: "Введите город"),
                  ),
                )
              ],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          city = _controller.text;
          bloc.add(GetWeatherEvent(city));
        },
        tooltip: 'Increment',
        child: Icon(Icons.search),
      ),
    );
  }
}
