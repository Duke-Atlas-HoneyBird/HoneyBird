/// Value object representing navigation options in the side menu.
/// 
/// This enum is framework-agnostic and contains no UI dependencies.
/// Each value has an associated displayName for presentation purposes.
enum SideMenuTab {
  home('Home'),
  store('Store'),
  notifications('Notifications'),
  profile('Profile'),
  settings('Settings');

  final String displayName;
  
  const SideMenuTab(this.displayName);
}
