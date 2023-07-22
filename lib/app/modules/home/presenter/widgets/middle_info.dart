import 'package:flutter/cupertino.dart';

import '../../../../styles/container_decorators.dart';

class MiddleInfo extends StatelessWidget {
  const MiddleInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Container(
            width: 86.24,
            height: 86.24,
            decoration: const ShapeDecoration(
              image: DecorationImage(
                image: AssetImage("assets/game.png"),
                fit: BoxFit.fill,
              ),
              shape: OvalBorder(),
            ),
          ),
          const SizedBox(width: 16),
          Container(
            decoration: ContainerDecorators().solidGrayCard(),
            child: const Column(
              children: [
                SizedBox(
                  width: 208.30,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Falta pouco!',
                        style: TextStyle(
                          color: Color(0xFF0C1425),
                          fontSize: 15,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 208.30,
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: '\$ ',
                            style: TextStyle(
                              color: Color(0xFF0C1425),
                              fontSize: 15,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          TextSpan(
                            text: '500',
                            style: TextStyle(
                              color: Color(0xFF0C1425),
                              fontSize: 15,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          TextSpan(
                            text: ' para cumprir sua meta de ',
                            style: TextStyle(
                              color: Color(0xFF0C1425),
                              fontSize: 15,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          TextSpan(
                            text: '4.000,00',
                            style: TextStyle(
                              color: Color(0xFF0C1425),
                              fontSize: 15,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
