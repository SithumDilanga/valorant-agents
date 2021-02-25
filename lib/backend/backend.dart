import 'dart:convert';

import 'package:flutter/cupertino.dart';
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
      var agent =  List<Map<String, dynamic>>.from(json.decode(response.body)['data']).map<Agent>((item) => Agent.fromJson(item)).where(
        (element) => element.uuid != 'ded3520f-4264-bfed-162d-b080e2abccf9'
      ).toList(); //toList()

      return agent;

    } else {
      throw Exception(response.statusCode.toString() + 'Failed to load data');
    }

  }

}