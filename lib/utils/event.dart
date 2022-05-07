import 'package:calculator/models/pad_item.dart';
import 'package:event_bus/event_bus.dart';

abstract class EventBusController {
  static EventBus eventBus = EventBus();

  static void fireEvent(EventData event) {
    eventBus.fire(event);
  }
}

class EventData {
  final PadItem padItem;
  final dynamic data;

  EventData({required this.padItem, this.data});
}
