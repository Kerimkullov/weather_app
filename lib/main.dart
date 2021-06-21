import 'package:app_weather/bloc/weather_bloc.dart';
import 'package:app_weather/bloc/weather_repository.dart';
import 'package:app_weather/components/loading.dart';
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
  var _scaffoldkey = GlobalKey<ScaffoldState>();
  TextEditingController _controller = TextEditingController();
  String city = "Бишкек";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          SizedBox(height: 30),
          Center(
            child: BlocListener(
              bloc: bloc,
              listener: (context, state) {
                if (state is WeatherError) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(state.message.message.toString())));
                } else if (state is WeatherLoaded) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Успешно загрузилось")));
                }
              },
              child: BlocBuilder(
                bloc: bloc,
                builder: (context, state) {
                  if (state is WeatherInitial) {
                    return Loading();
                  } else if (state is WeatherLoaded) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          state.model.name.toString(),
                          style: Theme.of(context).textTheme.headline4,
                        ),
                        SizedBox(height: 30),
                        Text(
                          "Температура: " +
                              state.model.main!.temp.toString() +
                              " C",
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ],
                    );
                  } else if (state is WeatherError) {
                    return Column(
                      children: [
                        Text("OOps произошла ошибка"),
                        SizedBox(
                          height: 30,
                        ),
                        TextButton(
                            onPressed: () {
                              bloc.add(GetWeatherEvent(city));
                              city = _controller.text;
                            },
                            child: Text("Повторить снова"))
                      ],
                    );
                  }
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "",
                        style: Theme.of(context).textTheme.headline4,
                      ),
                      SizedBox(height: 30),
                    ],
                  );
                },
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(20),
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(hintText: "Введите город"),
            ),
          )
        ],
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
