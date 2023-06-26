import 'package:flutter/material.dart';

import '../designer_system/text_styles.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                decoration: const BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                height: 300,
                child: Center(
                  child: Text(
                    '\$ 3.248,95',
                    style: CustomTextStyles().title.copyWith(
                          color: Colors.white,
                        ),
                  ),
                )),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16),
              child: Column(
                children: [
                  ...List.generate(
                      10,
                          (index) =>  Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const CircleAvatar(),
                            const SizedBox(width: 10),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text('Name',style: CustomTextStyles().smallSubtitle.copyWith(fontWeight: FontWeight.normal),),
                                Text('\$ 500,00',style: CustomTextStyles().smallTitle.copyWith(fontWeight: FontWeight.normal)),
                              ],
                            )
                          ],
                        ),
                      ))
                ],
              ),
            )

          ],
        ),
      ),
    );
  }
}
