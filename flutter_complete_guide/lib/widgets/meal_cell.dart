import 'package:flutter/material.dart';
import '../models/meal.dart';
import '../utils/extension.dart';
import 'package:shimmer/shimmer.dart';

class MealCell extends StatelessWidget {
  final Meal mealItem;

  MealCell({this.mealItem});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      height: 250,
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: LayoutBuilder(builder: (ctx, constraint) {
            return Stack(
              children: <Widget>[
                Container(
                  width: constraint.maxWidth,
                  height: constraint.maxHeight,
                  child: Image.network(
                    mealItem.imageUrl,
                    fit: BoxFit.cover,
                    frameBuilder: (ctx, child, frame, wasSynchronouslyLoaded) {
                      if (wasSynchronouslyLoaded) {
                        print(child.runtimeType);
                        return child;
                      }

                      return Container(
                        height: constraint.maxHeight,
                        width: constraint.maxWidth,
                        child: Stack(
                          children: <Widget>[
                            AnimatedOpacity(
                              child: Shimmer.fromColors(
                                child: Container(
                                  color: Colors.white,
                                ),
                                baseColor: Colors.grey[300],
                                highlightColor: Colors.grey[100],
                              ),
                              opacity: frame == null ? 1 : 0,
                              duration: const Duration(seconds: 1),
                              curve: Curves.easeOut,
                            ),
                            Positioned.fill(
                              child: AnimatedOpacity(
                                child: child,
                                opacity: frame == null ? 0 : 1,
                                duration: const Duration(seconds: 1),
                                curve: Curves.easeOut,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Positioned(
                  bottom: 70,
                  right: 0,
                  child: Container(
                    width: constraint.maxWidth * 0.65,
                    height: 60,
                    alignment: AlignmentDirectional.centerStart,
                    color: Colors.black54,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    child: Text(
                      mealItem.title,
                      style: TextStyle(
                        fontFamily: 'NunitoSans',
                        fontSize: 17,
                        color: Colors.white,
                      ),
                      softWrap: true,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: Container(
                    height: 50,
                    width: constraint.maxWidth,
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            const Icon(Icons.schedule),
                            const SizedBox(width: 5),
                            Text('${mealItem.duration} min'),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            const Icon(Icons.work),
                            const SizedBox(width: 5),
                            Text('${mealItem.complexity.title}'),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            const Icon(Icons.schedule),
                            const SizedBox(width: 5),
                            Text('${mealItem.affordability.title}'),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned.fill(
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      focusColor: context.theme.primaryColor,
                      onTap: () {},
                    ),
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
