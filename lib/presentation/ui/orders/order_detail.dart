import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pizza/presentation/widgets/global_textfield.dart';
import '../../../data/model/order_model.dart';
import '../../../business_logic/bloc/order_bloc.dart';
import '../../../business_logic/bloc/state_bloc.dart';
import '../../../data/model/food_model.dart';
import '../../../generated/locale_keys.g.dart';


class OrderDetailScreen extends StatefulWidget {
  final List<FoodModel> foodItems;
  const OrderDetailScreen({super.key, required this.foodItems});

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  PaymentMethod _selectedPaymentMethod = PaymentMethod.cash;
  OrderRecipient _selectedRecipient = OrderRecipient.me;

  TextEditingController addressController = TextEditingController();
  TextEditingController recipientPhoneController = TextEditingController();

  double calculateTotalPrice(List<FoodModel> foodItems) {
    double totalPrice = 0.0;
    for (final food in foodItems) {
      totalPrice += food.count * food.price;
    }
    return totalPrice;
  }

  void orderNow({double? newTotalCost}) async {
    final orderDate = DateTime.now();

    final foodNames = widget.foodItems.map((item) => item.name).join(', ');

    final order = OrderModel(
      foodNames: foodNames,
      totalCost: newTotalCost ?? 0.0,
      timestamp: orderDate.toString(),
    );

    context.read<OrderBloc>().add(AddOrderEvent(order));
  }
  bool showLottie = false;

  void placeOrderAndDeleteCart(List<FoodModel> foodItems) async{
    setState(() {
      showLottie = true;
    });

    await Future.delayed(const Duration(seconds: 4));

    double newTotalCost = calculateTotalPrice(foodItems);

    orderNow(newTotalCost: newTotalCost);

    Fluttertoast.showToast(
      timeInSecForIosWeb: 3,
      msg: LocaleKeys.order_success.tr(),
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER_RIGHT,
      backgroundColor: Colors.white,
      textColor: Colors.black,
      fontSize: 22.0,
    );
    // ignore: use_build_context_synchronously
    context.read<FoodBloc>().add(DeleteFoods());

    setState(() {
      showLottie = false;
    });
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: false,
          backgroundColor: Colors.white,
          elevation: 0,
          automaticallyImplyLeading: false,
          title: Text(
            LocaleKeys.order_detail.tr(),
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'Sora',
              fontWeight: FontWeight.w600,
              fontSize: 30,
            ),
          ),
        ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: ListTile(
                    title:
                        Text(LocaleKeys.recipient.tr(), style: TextStyle(fontSize: 18)),
                    contentPadding: EdgeInsets.zero,
                    dense: true,
                  ),
                ),
                RadioListTile<OrderRecipient>(
                  activeColor: Colors.black,
                  title: Text(LocaleKeys.me.tr()),
                  value: OrderRecipient.me,
                  groupValue: _selectedRecipient,
                  onChanged: (value) {
                    setState(() {
                      _selectedRecipient = value!;
                    });
                  },
                ),
                RadioListTile<OrderRecipient>(
                  activeColor: Colors.black,
                  title: Text(LocaleKeys.another.tr()),
                  value: OrderRecipient.lovedOne,
                  groupValue: _selectedRecipient,
                  onChanged: (value) {
                    setState(() {
                      _selectedRecipient = value!;
                    });
                  },
                ),
                Visibility(
                  visible: _selectedRecipient == OrderRecipient.lovedOne,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: GlobalTextField(
                      hintText: LocaleKeys.recipient_phone_number.tr(),
                      keyboardType: TextInputType.phone,
                      textInputAction: TextInputAction.next,
                      caption: LocaleKeys.mandatory.tr(),
                      validator: (value) {
                        if (_selectedRecipient == OrderRecipient.lovedOne &&
                            value!.isEmpty) {
                          return LocaleKeys.phone_number.tr();
                        }
                        return null;
                      },
                      controller: recipientPhoneController,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      GlobalTextField(
                        hintText: LocaleKeys.enter_address.tr(),
                        keyboardType: TextInputType.streetAddress,
                        textInputAction: TextInputAction.next,
                        caption: LocaleKeys.mandatory.tr(),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return LocaleKeys.address_mandatory.tr();
                          }
                          return null;
                        },
                        controller: addressController,
                      ),

                      ListTile(
                        title: Text(LocaleKeys.payment_method.tr(), style: TextStyle(fontSize: 18)),
                        contentPadding: EdgeInsets.zero,
                        dense: true,
                      ),
                    ],
                  ),
                ),
                RadioListTile<PaymentMethod>(
                  activeColor: Colors.black,
                  title: Text(LocaleKeys.cash_on_delivery.tr()),
                  value: PaymentMethod.cash,
                  groupValue: _selectedPaymentMethod,
                  onChanged: (value) {
                    setState(() {
                      _selectedPaymentMethod = value!;
                    });
                  },
                ),
                RadioListTile<PaymentMethod>(
                  activeColor: Colors.black,
                  title: Text(LocaleKeys.card_on_delivery.tr()),
                  value: PaymentMethod.card,
                  groupValue: _selectedPaymentMethod,
                  onChanged: (value) {
                    setState(() {
                      _selectedPaymentMethod = value!;
                    });
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16.0,right: 16.0, bottom: height/2),
                  child: InkWell(
                    onTap: () {
                      if (_formKey.currentState!.validate()){
                        placeOrderAndDeleteCart(widget.foodItems);
                        Future.delayed(const Duration(seconds: 4), () {
                          Navigator.of(context).pop();
                        });
                      }
                    },
                    borderRadius: BorderRadius.circular(16.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: showLottie? CupertinoActivityIndicator():Text(LocaleKeys.confirm_order.tr()),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

enum PaymentMethod { cash, card }

enum OrderRecipient { me, lovedOne }