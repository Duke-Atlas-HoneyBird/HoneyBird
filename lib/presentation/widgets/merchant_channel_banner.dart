import 'package:flutter/material.dart';
import '../theme/colours.dart';
import '../theme/spacing.dart';
import '../theme/text_styles.dart';
import '../theme/border_radius.dart';

/// Banner explaining that messaging is a mediated B2C channel to the merchant.
class MerchantChannelBanner extends StatelessWidget {
  final String restaurantName;

  const MerchantChannelBanner({
    super.key,
    required this.restaurantName,
  });

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
    //   return Container(
    //     width: double.infinity,
    //     margin: const EdgeInsets.fromLTRB(spacingM, spacingS, spacingM, 0),
    //     padding: const EdgeInsets.all(spacingM),
    //     decoration: BoxDecoration(
    //       color: primaryPurple.withValues(alpha: 0.12),
    //       borderRadius: BorderRadius.circular(cardBorderRadius),
    //       border: Border.all(color: primaryPurple.withValues(alpha: 0.25)),
    //     ),
    //     child: Row(
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       children: [
    //         Icon(Icons.storefront_outlined, color: primaryPurple, size: 22),
    //         const SizedBox(width: spacingS),
    //         Expanded(
    //           child: Column(
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: [
    //               Text(
    //                 'Merchant channel',
    //                 style: labelLarge.copyWith(color: primaryPurple),
    //               ),
    //               const SizedBox(height: spacingXs),
    //               Text(
    //                 'Messages to $restaurantName are routed through Honey Bird '
    //                 'for order-related inquiries. You are not chatting with other users.',
    //                 style: bodyMedium.copyWith(color: textSecondary),
    //               ),
    //             ],
    //           ),
    //         ),
    //       ],
    //     ),
    //   );
    // }
  }
}
