import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:valorant_agents/backend/backend.dart';
import 'package:valorant_agents/home/agent_list_tile.dart';
import 'package:valorant_agents/models/agent.dart';
import 'package:provider/provider.dart';
import 'package:valorant_agents/pages/agent_details.dart';
import 'package:valorant_agents/pages/info_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin{

  AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[600],
      appBar: AppBar(
        title: Text('Valorant Agents'),
        backgroundColor: Colors.blueGrey,
        actions: [
          IconButton(
            icon: Icon(Icons.info, size: 26,), 
            onPressed: () {
              Navigator.of(context).push(
                _createRoute()
              );
            }
          )
        ],
      ),
      body: FutureBuilder<List<Agent>>(
        future: context.watch<Backend>().getAgents(),
        builder: (context, snapshot) {
          if(snapshot.hasError) {
            print(snapshot.error.toString());
            return Center(
              child: const Text('oops! something went wrong'),
            );
          } else if(!snapshot.hasData) {
            return CupertinoActivityIndicator();
          } else {
            final agents = snapshot.data;

            print(agents[0].displayName);

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: agents.length,
                itemBuilder: (BuildContext context, int index) {
                  print(agents[index].displayName);
                  return AgentListTile(agent: agents[index], index: index,);
                },
                // children: [


                //   // for(var agent in agents)
                //   //   AgentListTile(agent: agent),

                //   // for(int index = 0; index < agents.length; index++)
                //   //  AgentListTile(agent: agents[index]),
                // ],
              ),
            );
          }
        }
      ),
    );
  }
}

Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => InfoPage(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(0.0, 1.0);
      var end = Offset.zero;
      var curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

/* 
Card(
  child: ListTile(
    contentPadding: EdgeInsets.all(8),
    leading: Image.network(
      '${agent.displayIcon}'
    ),
    title: Text(
      '${agent.displayName}'
    ),
    subtitle: Text(
      '${agent.description}',
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
    ),
    onTap: () {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => AgetDetailsScreen(agent: agent,))
      );
    },
  ),
),
*/