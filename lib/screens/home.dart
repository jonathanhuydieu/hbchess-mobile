import 'package:flutter/material.dart';
// import '/screens/login.dart';
// import '/screens/register.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          // allows custom image for background
          //backgroundColor: Colors.transparent,
          //backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text(widget.title),
          ),
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                const DrawerHeader(
                  decoration: BoxDecoration(
                    // R, G, B, opacity
                    color: Color.fromARGB(255, 31, 41, 55),
                  ),
                  child: Text(
                    'HBChess',
                    style: TextStyle(
                      fontSize: 28,
                      color: Colors.white,
                      // Font not being applied
                      fontFamily: 'Poppins-Regular',
                    ),
                  ),
                ),

                // Need to add routing for other ListTiles
                createDrawerTile(Icons.home, 'Home', '/home'),
                createDrawerTile(
                    Icons.leaderboard, 'Leaderboard', '/leaderboard'),
                createDrawerTile(Icons.book, 'Rules', '/rules'),
                createDrawerTile(
                    Icons.person_add_alt_outlined, 'Sign Up', '/register'),
                createDrawerTile(Icons.login, 'Login', '/login'),
              ],
            ),
          ),

          // Main home page body
          body: Center(
            child: Container(
              //color: Colors.white,
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage("assets/images/background3.jpg"),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Play Hand Brain Chess With Friends!',
                    style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 31, 41, 55)
                        //fontFamily: 'Poppins-Regular',
                        ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 30),
                  FittedBox(
                    child: Image.asset(
                      "assets/images/hblogo.png",
                      width: 300,
                      height: 300,
                    ),
                    fit: BoxFit.fitHeight,
                  ),
                  // Wrap(
                  //   spacing: 100,
                  //   children: [
                  //     createbutton('Sign Up', '/register'),
                  //     createbutton('Login', '/login'),
                  //   ],
                  // ),
                  Column(
                    children: [
                      createbutton('Login', '/login',
                          const Color.fromARGB(255, 31, 41, 55), Colors.white),
                      createbutton('Sign Up', '/register',
                          const Color.fromARGB(141, 31, 41, 55), Colors.white),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Helper function to create Drawer tiles
  // Need to add/update navigator routing once the appropriate
  // pages have been created.
  ListTile createDrawerTile(IconData icon, String title, String route) {
    //BuildContext context
    return ListTile(
        leading: Icon(icon),
        title: Text(title),
        onTap: () {
          Navigator.pushNamed(context, route);
        });
  }

  Padding createbutton(
      String label, String route, Color color, Color textColor) {
    return Padding(
        padding: const EdgeInsets.only(left: 40, right: 40, top: 10),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            textStyle: const TextStyle(fontSize: 30),
            minimumSize: const Size.fromHeight(50),
            primary: color,
            onPrimary: textColor,
            side: const BorderSide(
              width: 1,
              color: Color.fromARGB(31, 16, 23, 94),
              style: BorderStyle.solid,
            ),
          ),
          onPressed: () {
            Navigator.pushNamed(context, route);
          },
          child: Text(label),
        ));
  }
}
