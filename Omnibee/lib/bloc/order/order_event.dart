part of 'order_bloc.dart';

abstract class OrderEvent extends Equatable {
  const OrderEvent();

  @override
  List<Object> get props => [];
}

class OrderLoaded extends OrderEvent {}

class OrderAdded extends OrderEvent {
  final Order order;

  const OrderAdded(this.order);

  @override
  List<Object> get props => [order];

  @override
  String toString() => 'OrderAdded { Order: $order }';
}

class OrdersUpdated extends OrderEvent {
  final List<Order> orders;

  const OrdersUpdated(this.orders);

  @override
  List<Object> get props => [orders];

  @override
  String toString() => 'OrderUpdated { Orders: $orders }';
}

class OrderDeleted extends OrderEvent {
  final Order order;

  const OrderDeleted(this.order);

  @override
  List<Object> get props => [order];

  @override
  String toString() => 'OrderDeleted { Order: $order }';
}

class OrderMarkDelivered extends OrderEvent {
  final Order order;

  const OrderMarkDelivered(this.order);

  @override
  List<Object> get props => [order];

  @override
  String toString() => 'OrderMarkDelivered { Order: $order }';
}

class OrderMarkAccepted extends OrderEvent {
  final Order order;
  final User runner;

  const OrderMarkAccepted(this.order, this.runner);

  @override
  List<Object> get props => [order, runner];

  @override
  String toString() => 'OrderMarkAccepted { Order: $order, Runner: $runner }';
}

class UpdateUser extends OrderEvent {
  final User user;

  const UpdateUser(this.user);

  @override
  List<Object> get props => [user];

  @override
  String toString() => 'UpdateUser { User: $user }';
}

class OrderBlocClosed extends OrderEvent {}
