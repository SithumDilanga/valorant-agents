import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:valorant_agents/models/agent.dart';


class Backend {

  final String hostUrl;

  Backend({this.hostUrl});

  Future<List<Agent>> getAgents() async { //<List<Map<String, dynamic>>>
    
    final url = hostUrl;

    final response = await http.get(url);

    if(response.statusCode == 200) {

      // var agentsList = json.decode(response.body).map<Agent>((item) => Agent.fromJson(item)).toList();
      
      // fetching agents list
      var agent =  List<Map<String, dynamic>>.from(json.decode(response.body)['data']).map<Agent>((item) => Agent.fromJson(item)).toList();

      return agent;

    } else {
      throw Exception('Failed to load data');
    }

  }

}