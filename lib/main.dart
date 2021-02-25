import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:valorant_agents/backend/backend.dart';
import 'package:valorant_agents/home/home_page.dart';

void main() {

  final backend = Backend(hostUrl: 'https://valorant-api.com/v1/agents');

  runApp(ValorantAgents(backend: backend));
}

class ValorantAgents extends StatelessWidget {

  final Backend backend;

  const ValorantAgents({
    Key key, this.backend
  }) : assert(backend != null), 
       super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider.value(
      value: backend,
      child: MaterialApp(
        theme: ThemeData(
          brightness: Brightness.light,
        ),
        // darkTheme: ThemeData(
        //   brightness: Brightness.dark,
        // ),
        //themeMode: ThemeMode.dark,
        title: 'Valorant Agents',
        /*theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),*/
        home: HomePage(),
      ),
    );
  }
}
