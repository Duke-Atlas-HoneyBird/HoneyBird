/// Canonical restaurant IDs seeded in Firestore (`scripts/seed_firestore.mjs`).
/// Keep in sync with the seed script — these are merchant entity IDs, not user UIDs.
class SeedRestaurants {
  SeedRestaurants._();

  static const capeGrill = 'rest_cape_grill';
  static const mediterraneo = 'rest_mediterraneo';
  static const honeyHive = 'rest_honey_hive';

  static const allIds = [capeGrill, mediterraneo, honeyHive];
}
