import 'package:flutter/material.dart';
import 'package:salon_clock/Screens/authentication_screen.dart';

class Start_screen extends StatelessWidget {
  static const routeName = '/start';

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    // final transformConfig = Matrix4.rotationZ(-8 * pi / 180);
    // transformConfig.translate(-10.0);
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          // RaisedButton.icon(onPressed: () {}),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color.fromRGBO(111, 212, 255, 1).withOpacity(0.5),
                  const Color.fromRGBO(150, 12, 213, 1).withOpacity(0.9),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [0, 1],
              ),
            ),
          ),
          SingleChildScrollView(
            child: SizedBox(
              height: deviceSize.height,
              width: deviceSize.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Flexible(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          child: Container(
                            width: 900,
                            margin: const EdgeInsets.only(bottom: 20.0),
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 30.0),
                            // transform: Matrix4.rotationZ(-8 *
                            //     pi /
                            //     180) //? here we used the transform to make the container rolate, and the pi to calculate thr rotation.
                            //   ..translate(
                            //       -10.0), //! Here we put ..translate bcz because you don't return what translate returns but you instead return what the previous method returned.
                            // ..translate(-10.0),

                            child: const Text(
                              'SALON O CLOCK',
                              softWrap: true,
                              style: TextStyle(
                                color: Colors.blueGrey,
                                fontSize: 37,
                                fontFamily: 'JosefinSans-SemiBold',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          child: Image.asset(
                              'assets/images/PicsArt_03-06-07.21.39.png'),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        InkWell(
                          child: Container(
                            width: 900,
                            margin: const EdgeInsets.only(bottom: 20.0),
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 30.0),
                            // transform: Matrix4.rotationZ(-8 *
                            //     pi /
                            //     180) //? here we used the transform to make the container rolate, and the pi to calculate thr rotation.
                            //   ..translate(
                            //       -10.0), //! Here we put ..translate bcz because you don't return what translate returns but you instead return what the previous method returned.
                            // ..translate(-10.0),
                          ),
                        ),
                        InkWell(
                          child: Container(
                            width: 350,
                            margin: const EdgeInsets.only(bottom: 20.0),
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 30.0),
                            // transform: Matrix4.rotationZ(-8 *
                            //     pi /
                            //     180) //? here we used the transform to make the container rolate, and the pi to calculate thr rotation.
                            //   ..translate(
                            //       -10.0), //! Here we put ..translate bcz because you don't return what translate returns but you instead return what the previous method returned.
                            // ..translate(-10.0),

                            child: Text(
                              'JOIN AS:',
                              softWrap: true,
                              style: TextStyle(
                                color: Theme.of(context)
                                    .accentTextTheme
                                    .headline6
                                    .color,
                                fontSize: 25,
                                fontFamily: 'JosefinSans-SemiBold',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.of(context)
                                .pushReplacementNamed(auth_screen.routeName);
                          },
                          child: Container(
                            width: 350,

                            margin: const EdgeInsets.only(bottom: 20.0),
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 30.0),
                            // transform: Matrix4.rotationZ(-8 *
                            //     pi /
                            //     180) //? here we used the transform to make the container rolate, and the pi to calculate thr rotation.
                            //   ..translate(
                            //       -10.0), //! Here we put ..translate bcz because you don't return what translate returns but you instead return what the previous method returned.
                            // ..translate(-10.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Color.fromRGBO(150, 12, 213, 1)
                                  .withOpacity(0.9),
                              boxShadow: const [
                                BoxShadow(
                                  blurRadius: 8,
                                  color: Colors.black,
                                  offset: Offset(0, 2),
                                )
                              ],
                            ),
                            child: Text(
                              'Service Provider',
                              softWrap: true,
                              style: TextStyle(
                                color: Theme.of(context)
                                    .accentTextTheme
                                    .headline6
                                    .color,
                                fontSize: 35,
                                fontFamily: 'JosefinSans-SemiBold',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {},
                          child: Container(
                            width: 350,

                            margin: const EdgeInsets.only(bottom: 20.0),
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 30.0),
                            // transform: Matrix4.rotationZ(-8 *
                            //     pi /
                            //     180) //? here we used the transform to make the container rolate, and the pi to calculate thr rotation.
                            //   ..translate(
                            //       -10.0), //! Here we put ..translate bcz because you don't return what translate returns but you instead return what the previous method returned.
                            // ..translate(-10.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Color.fromRGBO(150, 12, 213, 1)
                                  .withOpacity(0.9),
                              boxShadow: const [
                                BoxShadow(
                                  blurRadius: 8,
                                  color: Colors.black,
                                  offset: Offset(0, 2),
                                )
                              ],
                            ),
                            child: Text(
                              'Customer',
                              softWrap: true,
                              style: TextStyle(
                                color: Theme.of(context)
                                    .accentTextTheme
                                    .headline6
                                    .color,
                                fontSize: 35,
                                fontFamily: 'JosefinSans-SemiBold',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}


//flutter build apk --build-name=1.0 --build-number=1
