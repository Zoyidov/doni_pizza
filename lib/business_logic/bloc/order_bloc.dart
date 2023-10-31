// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:pizza/data/database/orders_database.dart';
import 'package:pizza/data/model/order_model.dart';

// Events
abstract class OrderEvent {}

class LoadOrdersEvent extends OrderEvent {}

class AddOrderEvent extends OrderEvent {
  final OrderModel order;

  AddOrderEvent(this.order);
}

class ClearOrdersEvent extends OrderEvent {}

class DeleteOrderEvent extends OrderEvent {
  final OrderModel order;

  DeleteOrderEvent(this.order);
}

// States
abstract class OrderState {}

class OrderInitialState extends OrderState {}

class OrderLoadingState extends OrderState {}

class OrderLoadedState extends OrderState {
  final List<OrderModel> orders;

  OrderLoadedState(this.orders);
}

class OrderErrorState extends OrderState {
  final String errorMessage;

  OrderErrorState(this.errorMessage);
}

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final OrderDatabase ordersRepository = OrderDatabase.instance;

  OrderBloc() : super(OrderInitialState()) {
    on<LoadOrdersEvent>(_handleLoadOrdersEvent);
    on<AddOrderEvent>(_handleAddOrderEvent);
    on<ClearOrdersEvent>(_handleClearOrdersEvent);
  }

  void _handleLoadOrdersEvent(LoadOrdersEvent event, Emitter<OrderState> emit) async {
    emit(OrderLoadingState());
    try {
      final orders = await ordersRepository.getAllOrders();
      emit(OrderLoadedState(orders));
    } catch (e) {
      emit(OrderErrorState('Failed to load orders: $e'));
    }
  }

  void _handleAddOrderEvent(AddOrderEvent event, Emitter<OrderState> emit) async {
    emit(OrderLoadingState());
    try {
      await ordersRepository.insertOrder(event.order);
      final orders = await ordersRepository.getAllOrders();
      emit(OrderLoadedState(orders));
    } catch (e) {
      emit(OrderErrorState('Failed to add order: $e'));
    }
  }

  void _handleClearOrdersEvent(ClearOrdersEvent event, Emitter<OrderState> emit) async {
    emit(OrderLoadingState());
    try {
      await ordersRepository.deleteAllOrders();
      final orders = await ordersRepository.getAllOrders();
      emit(OrderLoadedState(orders));
    } catch (e) {
      emit(OrderErrorState('Failed to clear orders: $e'));
    }
  }
}
