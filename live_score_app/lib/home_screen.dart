import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
      appBar: AppBar(
        title: Text(
          'Football Live Score ${FirebaseAuth.instance.currentUser?.email}',
        ),
        actions: [
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
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
      floatingActionButton: Row(
        mainAxisAlignment: .spaceAround,
        children: [
          FloatingActionButton(
            onPressed: () {
              // Add new match
              FootballMatch match = FootballMatch(
                team1Name: 'Uruguay',
                team2Name: 'Brazil',
                team1Score: 1,
                team2Score: 2,
                isRunning: true,
                winnerTeam: '',
              );
              _firestore
                  .collection('football')
                  .doc('uruvsbra')
                  .set(match.toJson());
            },
            child: Icon(Icons.add),
          ),
          FloatingActionButton(
            onPressed: () {
              // Add new match
              // FootballMatch match = FootballMatch(
              //     team1Name: 'Uruguay',
              //     team2Name: 'Brazil',
              //     team1Score: 1,
              //     team2Score: 2,
              //     isRunning: false,
              //     winnerTeam: 'Brazil');
              // _firestore.collection('football').doc('uruvsbra').update(match.toJson());
              _firestore.collection('football').doc('uruvsbra').update({
                'is_running': true,
                'winner_team': '',
              });
              // _firestore.collection('football').doc('uruvsbra').delete();
            },
            child: Icon(Icons.update),
          ),
        ],
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

  Map<String, dynamic> toJson() {
    return {
      'team1_name': team1Name,
      'team2_name': team2Name,
      'team1_score': team1Score,
      'team2_score': team2Score,
      'is_running': isRunning,
      'winner_team': winnerTeam,
    };
  }
}
