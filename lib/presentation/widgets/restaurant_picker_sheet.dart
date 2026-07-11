import 'package:flutter/material.dart';
import '../../domain/entities/restaurant.dart';
import '../theme/colours.dart';
import '../theme/spacing.dart';
import '../theme/text_styles.dart';
import '../theme/border_radius.dart';

/// Bottom sheet for picking a restaurant to contact via the B2C channel.
class RestaurantPickerSheet extends StatelessWidget {
  final List<Restaurant> restaurants;
  final bool isLoading;
  final void Function(Restaurant restaurant) onRestaurantSelected;

  const RestaurantPickerSheet({
    super.key,
    required this.restaurants,
    required this.isLoading,
    required this.onRestaurantSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(spacingM, spacingM, spacingM, spacingL),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Contact a restaurant', style: headlineMedium),
            const SizedBox(height: spacingS),
            Text(
              'Select a merchant to ask about orders, reservations, or menu items. '
              'All messages are routed through Honey Bird — not to other users.',
              style: bodyMedium.copyWith(color: textSecondary),
            ),
            const SizedBox(height: spacingM),
            if (isLoading)
              const Padding(
                padding: EdgeInsets.all(spacingL),
                child: Center(child: CircularProgressIndicator()),
              )
            else if (restaurants.isEmpty)
              Padding(
                padding: const EdgeInsets.all(spacingL),
                child: Text(
                  'No restaurants available right now.',
                  style: bodyMedium.copyWith(color: textSecondary),
                  textAlign: TextAlign.center,
                ),
              )
            else
              ...restaurants.map(
                (restaurant) => ListTile(
                  leading: CircleAvatar(
                    backgroundColor: primaryPurple,
                    child: Icon(Icons.storefront, color: surfaceColor, size: 20),
                  ),
                  title: Text(restaurant.name, style: labelLarge),
                  subtitle: Text(
                    'Order & reservation inquiries',
                    style: bodyMedium.copyWith(color: textSecondary),
                  ),
                  trailing: Icon(Icons.chevron_right, color: textSecondary),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(cardBorderRadius),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    onRestaurantSelected(restaurant);
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
