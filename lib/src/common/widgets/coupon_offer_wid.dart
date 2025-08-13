import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:ikotech/src/data/model/HomeModel/coupon_offer_model.dart';

import '../utils/colours.dart';

class CouponOfferWid extends StatefulWidget {
  final List<CouponOfferModel>? destination;

  const CouponOfferWid({super.key, required this.destination});

  @override
  State<CouponOfferWid> createState() => _CouponOfferWidState();
}

class _CouponOfferWidState extends State<CouponOfferWid> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Offers & Discounts",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: MyColors.black,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        CarouselSlider.builder(
          itemCount: widget.destination!.length,
          itemBuilder: (context, index, realIdx) {
            final offer = widget.destination?[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: (widget.destination?[index].couponCode != '')
                  ? CouponCard(coupon: offer)
                  : SizedBox.shrink(),
            );
          },
          options: CarouselOptions(
            height: 150,
            autoPlay: true,
            viewportFraction: 1.0,
            enlargeCenterPage: false,
            onPageChanged: (index, reason) {
              setState(() => currentIndex = index);
            },
          ),
        ),
      ],
    );
  }
}

class CouponCard extends StatelessWidget {
  final CouponOfferModel? coupon;

  const CouponCard({super.key, required this.coupon});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: ShapeDecoration(
        color: const Color(0xFFFFF3DC),
        shape: TicketShapeBorder(),
      ),
      child: Row(
        children: [
          // Left coupon label
          Container(
            width: 40,
            color: const Color(0xFFFFE4B3),
            alignment: Alignment.center,
            child: RotatedBox(
              quarterTurns: -1,
              child: Text(
                'COUPON',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[700],
                  letterSpacing: 1.5,
                ),
              ),
            ),
          ),
          // Main Content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Code + Date Row
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        // 👈 prevents overflow
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            'CODE: ${coupon?.couponCode ?? ""}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                            overflow: TextOverflow
                                .ellipsis, // 👈 truncates if too long
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(6),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 2,
                              offset: Offset(0, 1),
                            ),
                          ],
                        ),
                        child: Text(
                          coupon?.validDate ?? "",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),
                  Expanded(
                    child: Text(
                      coupon?.heading ?? "",
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                      maxLines: 2, // 👈 wrap to 2 lines
                      overflow: TextOverflow.ellipsis, // 👈 truncate if more
                    ),
                  ),
                  const Divider(height: 16),
                  InkWell(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(16),
                          ),
                        ),
                        builder: (_) => _CouponDetailsModal(coupon: coupon),
                      );
                    },
                    child: Row(
                      children: const [
                        Icon(Icons.description_outlined, size: 16),
                        SizedBox(width: 4),
                        Text(
                          'View More',
                          style: TextStyle(
                            color: Colors.black87,
                            decoration: TextDecoration.underline,
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Right icons section
          Container(
            width: 40,
            decoration: const BoxDecoration(
              color: Color(0xFFFFB84D),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(4),
                bottomRight: Radius.circular(4),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.flight_takeoff, color: Colors.brown, size: 20),
                SizedBox(height: 12),
                Icon(Icons.local_offer_outlined, color: Colors.brown, size: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CouponDetailsModal extends StatelessWidget {
  final CouponOfferModel? coupon;
  const _CouponDetailsModal({required this.coupon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              Text(
                coupon?.heading ?? "",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Text(
                    'Code: ${coupon?.couponCode ?? ""}',
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                  const Spacer(),
                  Text(
                    'Valid till: ${coupon?.validDate ?? ""}',
                    style: const TextStyle(color: Colors.red),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              if (coupon?.aboutOffer != null &&
                  coupon!.aboutOffer!.isNotEmpty) ...[
                const Text(
                  'About Offer',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Html(data: coupon?.aboutOffer ?? ""),
                const SizedBox(height: 12),
              ],
              if (coupon?.termsCondition != null &&
                  coupon!.termsCondition!.isNotEmpty) ...[
                const Text(
                  'Terms & Conditions',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Html(data: coupon?.termsCondition ?? ""),
              ],
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Close'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Custom Ticket Shape with cut edges
class TicketShapeBorder extends ShapeBorder {
  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.zero;

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    return getOuterPath(rect, textDirection: textDirection);
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    const radius = 8.0;
    const notchRadius = 8.0;
    final path = Path()
      ..moveTo(rect.left + radius, rect.top)
      ..arcToPoint(
        Offset(rect.left, rect.top + radius),
        radius: const Radius.circular(radius),
      )
      ..lineTo(rect.left, rect.top + rect.height / 2 - notchRadius)
      ..arcToPoint(
        Offset(rect.left, rect.top + rect.height / 2 + notchRadius),
        radius: const Radius.circular(notchRadius),
        clockwise: false,
      )
      ..lineTo(rect.left, rect.bottom - radius)
      ..arcToPoint(
        Offset(rect.left + radius, rect.bottom),
        radius: const Radius.circular(radius),
      )
      ..lineTo(rect.right - radius, rect.bottom)
      ..arcToPoint(
        Offset(rect.right, rect.bottom - radius),
        radius: const Radius.circular(radius),
      )
      ..lineTo(rect.right, rect.top + rect.height / 2 + notchRadius)
      ..arcToPoint(
        Offset(rect.right, rect.top + rect.height / 2 - notchRadius),
        radius: const Radius.circular(notchRadius),
        clockwise: false,
      )
      ..lineTo(rect.right, rect.top + radius)
      ..arcToPoint(
        Offset(rect.right - radius, rect.top),
        radius: const Radius.circular(radius),
      )
      ..close();
    return path;
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {}

  @override
  ShapeBorder scale(double t) => this;
}
