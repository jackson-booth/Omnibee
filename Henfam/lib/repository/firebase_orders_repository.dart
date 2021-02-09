import 'dart:async';
import 'package:Henfam/models/models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'repositories.dart';
import 'package:Henfam/entities/entities.dart';

class FirebaseOrdersRepository implements OrdersRepository {
  final orderCollection = Firestore.instance.collection('orders');

  @override
  Future<void> addOrder(Order order) {
    return orderCollection.add(order.toEntity().toDocument());
  }

  @override
  Future<void> deleteOrder(Order order) {
    return orderCollection.document(order.docID).delete();
  }

  @override
  Future<void> updateOrder(Order order) {
    return orderCollection
        .document(order.docID)
        .updateData(order.toEntity().toDocument());
  }

  @override
  Future<void> markOrderDelivered(Order order) {
    return orderCollection
        .document(order.docID)
        .updateData({'is_delivered': true});
  }

  @override
  Future<void> markOrderAccepted(Order order, User runner) {
    return orderCollection.document(order.docID).updateData({
      'is_accepted': true,
      'runner': runner.uid,
      'runner_name': runner.name,
      'stripeAccountId': runner.stripeAccountId,
      'runner_phone': runner.phone,
    });
  }

  @override
  Stream<List<Order>> orders() {
    return orderCollection.snapshots().map((snapshot) {
      return snapshot.documents
          .map((doc) => Order.fromEntity(OrderEntity.fromSnapshot(doc)))
          .toList();
    });
  }
}
