import 'package:flutter/material.dart';
import 'package:slivers_workshop/data.dart';

void main() {
  runApp(HorizonsApp());
}

class HorizonsApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        // This is the theme of your application.
        theme: ThemeData.dark(),
        // Scrolling in Flutter behaves differently depending on the
        // ScrollBehavior. By default, ScrollBehavior changes depending
        // on the current platform. For the purposes of this scrolling
        // workshop, we're using a custom ScrollBehavior so that the
        // experience is the same for everyone - regardless of the
        // platform they are using.
        scrollBehavior: const ConstantScrollBehavior(),
        title: 'Horizons Weather',
        home: Scaffold(
          appBar: AppBar(
            title: Text('Horizons'),
            backgroundColor: Colors.teal[800],
          ),
          body: WeeklyForecastList(),
        ));
  }
}

class WeeklyForecastList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final DateTime currentDate = DateTime.now();
    final TextTheme textTheme = Theme.of(context).textTheme;
    final List<DailyForecast> forecasts = Server.getDailyForecastList();

    return SingleChildScrollView(
        child: Column(
      children: forecasts.map((DailyForecast dailyForecast) {
        return Card(
          child: ListTile(
            leading: Text(
              dailyForecast.getDate(currentDate.day).toString(),
              style: textTheme.headline4,
            ),
            title: Text(
              dailyForecast.getWeekday(currentDate.weekday),
              style: textTheme.headline5,
            ),
            subtitle: Text(dailyForecast.description),
            trailing: Text(
              '${dailyForecast.highTemp} | ${dailyForecast.lowTemp} F',
              style: textTheme.subtitle2,
            ),
          ),
        );
      }).toList(),
    ));
  }
}

class ConstantScrollBehavior extends ScrollBehavior {
  const ConstantScrollBehavior();

  @override
  Widget buildScrollbar(
          BuildContext context, Widget child, ScrollableDetails details) =>
      child;

  @override
  Widget buildOverscrollIndicator(
          BuildContext context, Widget child, ScrollableDetails details) =>
      child;

  @override
  TargetPlatform getPlatform(BuildContext context) => TargetPlatform.macOS;

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) =>
      const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics());
}
