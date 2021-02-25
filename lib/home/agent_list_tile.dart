import 'package:flutter/material.dart';
import 'package:valorant_agents/models/agent.dart';
import 'package:valorant_agents/pages/agent_details.dart';

class AgentListTile extends StatelessWidget {

  final Agent agent;
  final int index;

  const AgentListTile({
    Key key, 
    this.agent,
    this.index
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blueGrey[900],
      child: InkWell(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: ClipRRect(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(4.0), bottomLeft: Radius.circular(4.0)),
              child: agent.displayIcon.isEmpty ? null : 
                Hero(
                  tag: 'hero-${agent.uuid}-image',
                  child: Image.network(
                    agent.displayIcon,
                    fit: BoxFit.cover,
                    height: 110,
                  ),
                ),         
            ),
          ),
          SizedBox(width: 8.0),
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.only(top: 12.0),
              height: 110,
              // color: Colors.yellow,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Text(
                    agent.displayName,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    agent.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.white
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      onTap: () {
        print(index);
        Navigator.of(context).push(
         MaterialPageRoute(builder: (context) => AgetDetailsScreen(agent: agent, index: index,))
        );
      },
    ),
    );
  }
}