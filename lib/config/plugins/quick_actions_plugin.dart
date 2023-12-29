import 'package:quick_actions/quick_actions.dart';

import '../router/app_router.dart';

class QuickActionsPlugin {
  static registerActions() {
    const QuickActions quickActions = QuickActions();
    quickActions.initialize((type) {
      print(type);
      switch (type) {
        case 'biometric':
          router.push('/biometric');
          break;
        case 'brujula':
          router.push('/brujula');
          break;
        case 'pokemons':
          router.push('/pokemons');
          break;
        case 'charmander':
          router.push('/pokemons/25');
          break;
      }
    });
    quickActions.setShortcutItems(<ShortcutItem>[
      const ShortcutItem(
          type: 'biometric', localizedTitle: 'Biometric', icon: 'finger'),
      const ShortcutItem(
          type: 'brujula', localizedTitle: 'Compass', icon: 'compass'),
      const ShortcutItem(
          type: 'pokemons', localizedTitle: 'Pokemons', icon: 'pokemons'),
      const ShortcutItem(
          type: 'charmander', localizedTitle: 'Charmander', icon: 'charmander'),
    ]);
  }
}
