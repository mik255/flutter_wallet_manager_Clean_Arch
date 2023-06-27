import 'package:flutter/material.dart';

import '../styles/container_decorators.dart';
import '../styles/text_styles.dart';



class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/home_background.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  height: 300,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Container(
                              clipBehavior: Clip.antiAlias,
                              height: 80,
                              width: 80,
                              decoration:
                                  ContainerDecorators().getBoxDecoration(
                                color: Colors.white,
                              ),
                              child: Image.network(
                                'https://www.publicbooks.org/wp-content/uploads/2019/11/joel-mott-LaK153ghdig-unsplash-scaled-e1574787737429.jpg',
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(width: 8,),
                            Text(
                              'Larissa',
                              style: CustomTextStyles()
                                  .smallTitle
                                  .copyWith(color: Colors.black),
                            ),
                            Spacer(),
                            const Column(
                              children: [
                                Text('26/08/2021'),
                                Text('Quarta-feira'),
                              ],
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: 100,
                              width: MediaQuery.of(context).size.width * 0.8,
                              padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 32),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.transparent,
                                border: Border.all(
                                  color: Colors.black,
                                  width: 2,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  '\$ 3.248,95',
                                  style: CustomTextStyles().title.copyWith(
                                        color: Colors.black,
                                      ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      ...List.generate(
                          10,
                          (index) => Container(
                            margin: const EdgeInsets.symmetric(horizontal: 8.0),
                            decoration: const BoxDecoration(
                              color: Color(0xFFDDE2EB),
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                            ),
                            child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8,vertical: 16),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        clipBehavior: Clip.antiAlias,
                                        height: 50,
                                        width: 50,
                                        decoration: ContainerDecorators()
                                            .getBoxDecoration(
                                          color: Colors.white,
                                        ),
                                        child: Image.network(
                                          'https://t.ctcdn.com.br/3tQdC0dhzmQcV8uSocwIy8gtyic=/400x400/smart/filters:format(webp)/i624750.png',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            'NuBank',
                                            style: CustomTextStyles()
                                                .smallSubtitle
                                                .copyWith(
                                                    fontWeight: FontWeight.w500),
                                          ),
                                          Text('\$ 500,00',
                                              style: CustomTextStyles()
                                                  .smallTitle
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.bold)),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                          ))
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
