abstract class NavigationEvent {}

class SwitchNavigationEvent extends NavigationEvent {
  final int index;
  SwitchNavigationEvent(this.index);
}