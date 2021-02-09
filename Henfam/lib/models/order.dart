import 'dart:math';
import 'package:Henfam/entities/entities.dart';

import 'package:meta/meta.dart';

@immutable
class Order {
  final String name;
  final String uid;
  final Point userCoordinates;
  final String restaurantName;
  final Point restaurantCoordinates;
  final List<dynamic> basket;
  final String location;
  final String startTime;
  final String endTime;
  final DateTime expirationTime;
  final bool isAccepted;
  final bool isDelivered;
  final bool isReceived;
  final String runnerUid;
  final String runnerName;
  final double price;
  final double applicationFee;
  final double minEarnings;
  final String restaurantImage;
  final String paymentMethodId;
  final String stripeAccountId;
  final String docID;
  final String runnerPhone;
  final String phone;
  final String deliveryIns;

  Order(
    this.name,
    this.uid,
    this.userCoordinates,
    this.restaurantName,
    this.restaurantCoordinates,
    this.basket,
    this.location,
    this.startTime,
    this.endTime,
    this.expirationTime,
    this.isAccepted,
    this.isDelivered,
    this.isReceived,
    this.runnerUid,
    this.runnerName,
    this.price,
    this.applicationFee,
    this.minEarnings,
    this.restaurantImage,
    this.paymentMethodId,
    this.stripeAccountId,
    this.docID,
    this.runnerPhone,
    this.phone,
    this.deliveryIns,
  );

  Order copyWith({
    String name,
    String uid,
    Point userCoordinates,
    String restaurantName,
    Point restaurantCoordinates,
    List<dynamic> basket,
    String location,
    String startTime,
    String endTime,
    DateTime expirationTime,
    bool isAccepted,
    bool isDelivered,
    bool isReceived,
    String runnerUid,
    String runnerName,
    double price,
    double applicationFee,
    double minEarnings,
    String restaurantImage,
    String paymentMethodId,
    String stripeAccountId,
    String docID,
    String runnerPhone,
    String phone,
    String deliveryIns,
  }) {
    return Order(
      name,
      uid,
      userCoordinates,
      restaurantName,
      restaurantCoordinates,
      basket,
      location,
      startTime,
      endTime,
      expirationTime,
      isAccepted,
      isDelivered,
      isReceived,
      runnerUid,
      runnerName,
      price,
      applicationFee,
      minEarnings,
      restaurantImage,
      paymentMethodId,
      stripeAccountId,
      docID,
      runnerPhone,
      phone,
      deliveryIns,
    );
  }

  @override
  int get hashCode =>
      name.hashCode ^
      uid.hashCode ^
      userCoordinates.hashCode ^
      restaurantName.hashCode ^
      restaurantCoordinates.hashCode ^
      basket.hashCode ^
      location.hashCode ^
      startTime.hashCode ^
      endTime.hashCode ^
      expirationTime.hashCode ^
      isAccepted.hashCode ^
      isDelivered.hashCode ^
      isReceived.hashCode ^
      runnerUid.hashCode ^
      runnerName.hashCode ^
      price.hashCode ^
      applicationFee.hashCode ^
      minEarnings.hashCode ^
      restaurantImage.hashCode ^
      paymentMethodId.hashCode ^
      stripeAccountId.hashCode ^
      docID.hashCode ^
      runnerPhone.hashCode ^
      phone.hashCode ^
      deliveryIns.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Order &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          uid == other.uid &&
          userCoordinates == other.userCoordinates &&
          restaurantName == other.restaurantName &&
          restaurantCoordinates == other.restaurantCoordinates &&
          basket == other.basket &&
          location == other.location &&
          startTime == other.startTime &&
          endTime == other.endTime &&
          expirationTime == other.expirationTime &&
          isAccepted == other.isAccepted &&
          isDelivered == other.isDelivered &&
          isReceived == other.isReceived &&
          runnerUid == other.runnerUid &&
          runnerName == other.runnerName &&
          price == other.price &&
          applicationFee == other.applicationFee &&
          minEarnings == other.minEarnings &&
          restaurantImage == other.restaurantImage &&
          paymentMethodId == other.paymentMethodId &&
          stripeAccountId == other.stripeAccountId &&
          docID == other.docID &&
          runnerPhone == other.runnerPhone &&
          phone == other.phone &&
          deliveryIns == other.deliveryIns;

  @override
  String toString() {
    return 'Order { name: $name, uid: $uid, userCoordinates: $userCoordinates, restaurantName: $restaurantName, restaurantCoordinates: $restaurantCoordinates, basket: $basket, location: $location, startTime: $startTime, endTime: $endTime, expirationTime: $expirationTime, isAccepted: $isAccepted, isDelivered $isDelivered, isReceived $isReceived, runner: $runnerUid, runnerName: $runnerName, price: $price, applicationFee $applicationFee, minEarnings: $minEarnings, restaurantImage: $restaurantImage, paymentMethodId: $paymentMethodId, stripeAccountId: $stripeAccountId, runnerPhone: $runnerPhone, phone: $phone, deliveryIns $deliveryIns }';
  }

  OrderEntity toEntity() {
    return OrderEntity(
      name,
      uid,
      userCoordinates,
      restaurantName,
      restaurantCoordinates,
      basket,
      location,
      startTime,
      endTime,
      expirationTime,
      isAccepted,
      isDelivered,
      isReceived,
      runnerUid,
      runnerName,
      price,
      applicationFee,
      minEarnings,
      restaurantImage,
      paymentMethodId,
      stripeAccountId,
      docID,
      runnerPhone,
      phone,
      deliveryIns,
    );
  }

  static Order fromEntity(OrderEntity entity) {
    return Order(
      entity.name,
      entity.uid,
      entity.userCoordinates,
      entity.restaurantName,
      entity.restaurantCoordinates,
      entity.basket,
      entity.location,
      entity.startTime,
      entity.endTime,
      entity.expirationTime,
      entity.isAccepted,
      entity.isDelivered,
      entity.isReceived,
      entity.runnerUid,
      entity.runnerName,
      entity.price,
      entity.applicationFee,
      entity.minEarnings,
      entity.restaurantImage,
      entity.paymentMethodID,
      entity.stripeAccountId,
      entity.docID,
      entity.runnerPhone,
      entity.phone,
      entity.deliveryIns,
    );
  }

  bool isComplete() {
    return isReceived == true && isDelivered == true;
  }

//TODO: notification flow should have failsafe for cases when order accepted
//but too much time has passed. add warning notifications as well.
  bool isExpired() {
    return (expirationTime.millisecondsSinceEpoch <
                DateTime.now().millisecondsSinceEpoch &&
            !isAccepted) ||
        (isReceived);
  }

  String getDeliveryWindow() {
    return "$startTime to $endTime ${expirationTime.timeZoneName} on ${expirationTime.month}/${expirationTime.day}/${expirationTime.year}";
  }

  double getSubtotal() {
    double subtotal = 0.0;
    for (int i = 0; i < basket.length; i++) {
      subtotal += basket[i]['price'];
    }
    return subtotal;
  }
}
