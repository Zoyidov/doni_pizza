import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizza/business_logic/bloc/order_bloc.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  @override
  void initState() {
    super.initState();
    context.read<OrderBloc>().add(LoadOrdersEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        centerTitle: false,
        backgroundColor: Colors.white,
        title: const Text(
          'Orders',
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Sora',
            fontWeight: FontWeight.w600,
            fontSize: 30,
          ),
        ),
        actions: [
          ZoomTapAnimation(
            onTap: () {
              context.read<OrderBloc>().add(ClearOrdersEvent());
            },
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10.0,
              ),
              child: const Center(
                child: Text(
                  'Clear',
                  style: TextStyle(
                    color: Colors.red,
                    fontFamily: 'Sora',
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: BlocBuilder<OrderBloc, OrderState>(
        builder: (context, state) {
          if (state is OrderInitialState || state is OrderLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is OrderLoadedState) {
            final orders = state.orders;
            return orders.isEmpty
                ? const Center(
                    child: Icon(
                    CupertinoIcons.news,
                    size: 100,
                    color: Colors.black,
                  ))
                : ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    itemCount: orders.length,
                    separatorBuilder: (context, index) {
                      return const Divider(
                        height: 1,
                        color: Colors.black,
                      );
                    },
                    itemBuilder: (context, index) {
                      final order = orders[index];
                      final timestamp = DateTime.parse(order.timestamp);
                      final formattedTimestamp = DateFormat('yyyy-MM-dd HH:mm').format(timestamp);
                      return ListTile(
                        title: Text(
                          order.foodNames,
                          style: const TextStyle(
                            color: Colors.black,
                            fontFamily: 'Sora',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        trailing: Text(
                          '\$${order.totalCost.toStringAsFixed(2)}',
                          style: const TextStyle(
                            color: Colors.indigo,
                            fontFamily: 'Sora',
                          ),
                        ),
                        subtitle: Row(
                          children: [
                            Text(
                              'Ordered at: $formattedTimestamp',
                              style: const TextStyle(
                                color: Colors.grey,
                                fontFamily: 'Sora',
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
          } else if (state is OrderErrorState) {
            return Center(child: Text('Error: ${state.errorMessage}'));
          } else {
            return const Text('Unknown state');
          }
        },
      ),
    );
  }
}
