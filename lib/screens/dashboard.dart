import 'package:flutter/material.dart';
import 'package:hb_chess/main.dart';
import 'package:hb_chess/utils/getPreviousGames.dart';

List<Result> prevGames = [];

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);
  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  @override
  Widget build(BuildContext context) {
    _getPreviousGames();

    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: const Text('Dashboard'),
          ),

          // Menu
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                const DrawerHeader(
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 31, 41, 55),
                  ),
                  child: Text(
                    'HBChess',
                    style: TextStyle(
                      fontSize: 28,
                      color: Colors.white,
                      fontFamily: 'Poppins-Regular',
                    ),
                  ),
                ),
                createDrawerTile(Icons.home, 'Dashboard', '/dashboard'),
                createDrawerTile(
                    Icons.leaderboard, 'Leaderboard', '/leaderboard'),
                createDrawerTile(Icons.book, 'Rules', '/rules'),
                createDrawerTile(Icons.person, 'Teams', '/teams'),
                //createDrawerTile(Icons.settings, 'Settings', '/settings'),
                ListTile(
                    leading: const Icon(Icons.logout),
                    title: const Text("Log Out"),
                    onTap: () async {
                      await storage.deleteAll();
                      Navigator.pushNamed(context, '/home');
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("You have logged out")),
                      );
                    }),
              ],
            ),
          ),

          // Dashboard
          body: Center(
            // Center is a layout widget. It takes a single child and positions it
            // in the middle of the parent.
            child: Column(children: [
              // Wins/Draws/Losses
              const SizedBox(height: 20),
              const Text(
                'Previous Games',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black, fontSize: 25),
              ),
              const SizedBox(height: 20),
              Row(
                children: const <Widget>[
                  Expanded(
                    child: Text('Your Team',
                        style: TextStyle(color: Colors.black, fontSize: 15),
                        textAlign: TextAlign.center),
                  ),
                  Expanded(
                    child: Text('Opponent Team',
                        style: TextStyle(color: Colors.black, fontSize: 15),
                        textAlign: TextAlign.center),
                  ),
                  Expanded(
                    child: Text('Result',
                        style: TextStyle(color: Colors.black, fontSize: 15),
                        textAlign: TextAlign.center),
                  ),
                ],
              ),
              const SizedBox(height: 25),

              //Text('${results.length}'),
              // Scrollable list of prev games
              Expanded(
                child: Card(
                  child: CustomScrollView(
                    slivers: <Widget>[
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                            return Card(
                              margin: const EdgeInsets.all(5),
                              color: index % 2 == 0
                                  ? const Color.fromARGB(255, 173, 218, 175)
                                  : const Color.fromARGB(255, 214, 224, 215),
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(
                                    color: Color.fromARGB(255, 31, 41, 55),
                                    width: 1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Container(
                                height: 80,
                                alignment: Alignment.center,
                                child: Row(
                                  children: <Widget>[
                                    // Team
                                    Expanded(
                                      child: Text(
                                          prevGames[index].getBlackSenderUser() +
                                              ' - ' +
                                              prevGames[index]
                                                  .getBlackRecipientUser(),
                                          textAlign: TextAlign.center),
                                    ),
                                    // Result
                                    Expanded(
                                      child: Text(
                                          prevGames[index].getWhiteSenderUser() +
                                              ' - ' +
                                              prevGames[index]
                                                  .getWhiteRecipientUser(),
                                          textAlign: TextAlign.center),
                                    ),
                                    Expanded(
                                      child: Text(prevGames[index].winner,
                                          textAlign: TextAlign.center),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          childCount: prevGames.length,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ]),
          ),
        ),
      ],
    );
  }

_getPreviousGames() async {
  Future<List<Result>> res2 = getPreviousGames();
  prevGames = await res2;
}


  ListTile createDrawerTile(IconData icon, String title, String route) {
    //BuildContext context
    return ListTile(
        leading: Icon(icon),
        title: Text(title),
        onTap: () {
          Navigator.pushNamed(context, route);
        });
  }
}
