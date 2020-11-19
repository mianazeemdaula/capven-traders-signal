import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:tradiing_app/bloc/inapp_subscription_service.dart';
import 'package:tradiing_app/components/default_button.dart';
import 'package:tradiing_app/models/otoplan_model.dart';
import 'package:tradiing_app/screens/subscribe/components/bullet.dart';
import 'package:provider/provider.dart';

class ServiceCarouselSlider extends StatelessWidget {
  const ServiceCarouselSlider({
    Key key,
    @required List<OtherSerice> list,
  })  : _list = list,
        super(key: key);

  final List<OtherSerice> _list;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: CarouselSlider(
        options: CarouselOptions(
          aspectRatio: 9 / 16,
          enableInfiniteScroll: false,
          enlargeCenterPage: true,
        ),
        items: _list.map((service) {
          return Builder(
            builder: (BuildContext context) {
              return Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Text(
                        "${service.title}",
                        style: Theme.of(context).textTheme.headline3,
                      ),
                      SizedBox(height: 10),
                      Text(
                        "${service.description}",
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      SizedBox(height: 20),
                      Text("${service.price}",
                          style: Theme.of(context).textTheme.headline3),
                      SizedBox(height: 20),
                      ...service.features
                          .map((e) => Bullet(
                                title: e,
                              ))
                          .toList(),
                      Spacer(),
                      DefaultButton(
                        press: () async {
                          await context
                              .read<IAPService>()
                              .purchaseItem(service.id);
                        },
                        text: "BUY NOW",
                      )
                    ],
                  ),
                ),
              );
            },
          );
        }).toList(),
      ),
    );
  }
}
