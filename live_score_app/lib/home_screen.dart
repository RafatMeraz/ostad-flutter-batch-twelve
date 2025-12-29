import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<FootballMatch> _footballMatches = [];
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // @override
  // void initState() {
  //   super.initState();
  //   _fetchFootballMatches();
  // }
  //
  // Future<void> _fetchFootballMatches() async {
  //   _footballMatches.clear();
  //   QuerySnapshot<Map<String, dynamic>> snapshot = await _firestore
  //       .collection('football')
  //       .get();
  //   for (QueryDocumentSnapshot<Map<String, dynamic>> doc in snapshot.docs) {
  //     _footballMatches.add(FootballMatch.fromJson(doc.data()));
  //   }
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Football Live Score')),
      body: StreamBuilder(
        stream: _firestore.collection('football').snapshots(),
        builder: (context, asyncSnapshot) {
          if (asyncSnapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (asyncSnapshot.hasError) {
            return Center(child: Text('Error: ${asyncSnapshot.error}'));
          }

          if (asyncSnapshot.hasData) {
            _footballMatches.clear();
            for (QueryDocumentSnapshot<Map<String, dynamic>> doc
                in asyncSnapshot.data!.docs) {
              _footballMatches.add(FootballMatch.fromJson(doc.data()));
            }

            return _buildListView();
          }

          return SizedBox();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add new match
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildListView() {
    return ListView.separated(
      itemCount: _footballMatches.length,
      itemBuilder: (context, index) {
        final footballMatch = _footballMatches[index];
        return ListTile(
          leading: CircleAvatar(
            radius: 8,
            backgroundColor: footballMatch.isRunning
                ? Colors.green
                : Colors.grey,
          ),
          title: Text(
            '${footballMatch.team1Name} vs ${footballMatch.team2Name}',
          ),
          subtitle: Text('Winner Team: ${footballMatch.winnerTeam}'),
          trailing: Text(
            '${footballMatch.team1Score}:${footballMatch.team2Score}',
            style: TextTheme.of(context).titleLarge,
          ),
        );
      },
      separatorBuilder: (context, index) {
        return Divider();
      },
    );
  }
}

class FootballMatch {
  final String team1Name;
  final String team2Name;
  final int team1Score;
  final int team2Score;
  final bool isRunning;
  final String winnerTeam;

  FootballMatch({
    required this.team1Name,
    required this.team2Name,
    required this.team1Score,
    required this.team2Score,
    required this.isRunning,
    required this.winnerTeam,
  });

  factory FootballMatch.fromJson(Map<String, dynamic> jsonData) {
    return FootballMatch(
      team1Name: jsonData['team1_name'],
      team2Name: jsonData['team2_name'],
      team1Score: jsonData['team1_score'],
      team2Score: jsonData['team2_score'],
      isRunning: jsonData['is_running'],
      winnerTeam: jsonData['winner_team'],
    );
  }
}
