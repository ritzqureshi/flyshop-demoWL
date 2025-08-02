import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CommonSectionShimmer extends StatelessWidget {
  final double height;
  final int itemCount;
  final Axis scrollDirection;
  final double spacing;
  final BorderRadius borderRadius;

  const CommonSectionShimmer({
    super.key,
    this.height = 180,
    this.itemCount = 3,
    this.scrollDirection = Axis.horizontal,
    this.spacing = 10,
    this.borderRadius = const BorderRadius.all(Radius.circular(12)),
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: scrollDirection == Axis.horizontal ? height : null,
      child: ListView.separated(
        scrollDirection: scrollDirection,
        shrinkWrap: scrollDirection == Axis.vertical,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: itemCount,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        separatorBuilder: (_, __) => SizedBox(
          width: scrollDirection == Axis.horizontal ? spacing : 0,
          height: scrollDirection == Axis.vertical ? spacing : 0,
        ),
        itemBuilder: (context, index) {
          return Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Container(
              width: scrollDirection == Axis.horizontal
                  ? MediaQuery.of(context).size.width * 0.6
                  : double.infinity,
              height: height,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: borderRadius,
              ),
            ),
          );
        },
      ),
    );
  }
}
