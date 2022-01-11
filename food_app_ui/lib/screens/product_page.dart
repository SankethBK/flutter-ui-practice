import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:food_app_ui/utils/button.dart';
import 'package:food_app_ui/utils/widget_functions.dart';
import '../../utils/constants.dart';
import 'package:slide_to_act/slide_to_act.dart';

class ProductPage extends StatelessWidget {
  final dynamic itemData;

  const ProductPage({Key? key, required this.itemData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    const double commonSpacingValue = 25.0;

    const EdgeInsets commonHorizontalPadding =
        EdgeInsets.symmetric(horizontal: commonSpacingValue);
    return SafeArea(
      child: Scaffold(
        body: LayoutBuilder(builder: (context, constraints) {
          return Stack(children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Column(
                  children: [
                    Container(
                      height: constraints.maxHeight * 0.40,
                      color: Colors.green[50],
                    ),
                    // This Container is necessary for SinglChildScrollView to work
                    Container(
                      height: constraints.maxHeight * 0.6,
                      // color: Colors.amberAccent,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            addVerticalSpace(70),
                            Padding(
                              padding: commonHorizontalPadding,
                              child: mainText(textTheme),
                            ),
                            addVerticalSpace(commonSpacingValue),
                            const Padding(
                              padding: commonHorizontalPadding,
                              child: Divider(
                                thickness: 1.1,
                              ),
                            ),
                            addVerticalSpace(commonSpacingValue),
                            Padding(
                              padding: commonHorizontalPadding,
                              child: descriptionButtons(textTheme),
                            ),
                            addVerticalSpace(commonSpacingValue),
                            const Padding(
                              padding: commonHorizontalPadding,
                              child: Divider(
                                thickness: 1.1,
                              ),
                            ),
                            addVerticalSpace(commonSpacingValue / 4),
                            Padding(
                              padding: commonHorizontalPadding,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Overview",
                                    style: textTheme.headline5,
                                  ),
                                  Text(
                                    itemData["description"],
                                    textAlign: TextAlign.justify,
                                    style: textTheme.bodyText1,
                                  )
                                ],
                              ),
                            ),
                            addVerticalSpace(100)
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Positioned(
                  top: 20,
                  left: 20,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: SquareIconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: Icons.arrow_back_ios_outlined,
                      buttonColor: Colors.orange[100] as Color,
                      iconColor: Colors.orange,
                    ),
                  ),
                ),
                Positioned(
                  height: constraints.maxHeight * 0.40,
                  width: constraints.maxWidth,
                  child: Center(
                    child: Image.asset("assets/images/${itemData['image']}",
                        height: constraints.maxHeight * 0.25),
                  ),
                ),
                heartButton(constraints),
              ],
            ),
            slideToAddButton(constraints)
          ]);
        }),
      ),
    );
  }

  Row mainText(TextTheme textTheme) {
    // This widget contains the title of food, its location and price
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${itemData['name']}",
              style: textTheme.headline5!.copyWith(color: Colors.black),
            ),
            RichText(
              text: TextSpan(children: [
                const WidgetSpan(
                  child: Icon(Icons.location_on, color: Colors.red, size: 15),
                ),
                TextSpan(
                  text: " ${itemData['rest']}",
                  style: textTheme.caption,
                )
              ]),
            )
          ],
        ),
        RichText(
          textAlign: TextAlign.right,
          overflow: TextOverflow.ellipsis,
          text: TextSpan(
              text: "\$",
              style: const TextStyle(
                color: COLOR_ORANGE,
              ),
              children: [
                TextSpan(
                    text: "${itemData['price']}",
                    style: textTheme.headline5!.apply(color: COLOR_ORANGE))
              ]),
        )
      ],
    );
  }

  Row descriptionButtons(TextTheme textTheme) {
    // These are the 3 texts rating, devlery time and distance
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        RichText(
          textAlign: TextAlign.left,
          overflow: TextOverflow.ellipsis,
          text: TextSpan(children: [
            const WidgetSpan(
              child: Icon(
                Icons.star,
                color: Colors.orange,
                size: 15,
              ),
            ),
            TextSpan(
                text: " ${itemData['rating']}",
                style: textTheme.subtitle2!.apply(fontWeightDelta: 4))
          ]),
        ),
        RichText(
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          text: TextSpan(children: [
            const WidgetSpan(
              child: Icon(
                Icons.timer,
                color: Colors.red,
                size: 15,
              ),
            ),
            TextSpan(
                text: " 18 Mins",
                style: textTheme.subtitle2!.apply(fontWeightDelta: 4))
          ]),
        ),
        RichText(
          textAlign: TextAlign.right,
          overflow: TextOverflow.ellipsis,
          text: TextSpan(children: [
            const WidgetSpan(
              child: Icon(
                Icons.location_on,
                color: Colors.green,
                size: 15,
              ),
            ),
            TextSpan(
                text: " 2.3 KM",
                style: textTheme.subtitle2!.apply(fontWeightDelta: 4))
          ]),
        ),
      ],
    );
  }

  Positioned heartButton(BoxConstraints constraints) {
    return Positioned(
      top: constraints.maxHeight * 0.40 - 25,
      right: 25,
      child: Container(
        width: 75,
        height: 75,
        decoration: BoxDecoration(
            color: Colors.redAccent,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.red[100] as Color,
                spreadRadius: 5,
                blurRadius: 10,
                // offset: Offset(0, 7), // changes position of shadow
              ),
            ]),
        child: const Icon(
          Icons.favorite,
          color: Colors.white,
          size: 40,
        ),
      ),
    );
  }

  Positioned slideToAddButton(BoxConstraints constraints) {
    return Positioned(
      bottom: 0,
      left: 0,
      child: Container(
        width: constraints.maxWidth,
        height: constraints.maxHeight * 0.12,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0)),
            color: Colors.white),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: SlideAction(
            text: "Add to Cart",
            sliderButtonIcon: const Icon(
              Icons.shopping_bag,
              color: Colors.white,
            ),
            onSubmit: () {},
            sliderRotate: false,
            borderRadius: 10.0,
            elevation: 0,
            innerColor: COLOR_GREEN,
            outerColor: Colors.grey.shade100,
          ),
        ),
      ),
    );
  }
}
