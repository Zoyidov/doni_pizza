import 'package:flutter/material.dart';
import '../home_screen/home_screen.dart';

class ProductDetailScreen extends StatelessWidget {
  final MenuItem item;

  ProductDetailScreen({required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Hero(
            tag: 'product_${item.name}',
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(12.0),
                    bottomRight: Radius.circular(12.0)),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: Image.asset(item.imagePath,
                    height: MediaQuery.of(context).size.height / 2,
                    width: MediaQuery.of(context).size.width),
              ),
            ),
          ),
          Text(
            item.name,
            style: TextStyle(
                fontFamily: 'Sore', fontWeight: FontWeight.w600, fontSize: 35),
          ),
          SizedBox(height: 10.0),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("""Fast Food ConsumptionHow many times does the average person eat fast food per week?Most Americans eat at a fast food restaurant 1-3 times a week. Statistics from a survey conducted by the National Center for Health Statistics from Center for Disease Control shows that a little over one-third (36.6%) of adults in America eat it on any given day. That’s about 84.8 million adults eating fast food every day! Yikes!AgeDoes age play a role in consumption of fast food? We learned that 44.9% of  Americans aged 20-39 eat fast food on any given day. Slightly less, you'll find 37.7% of the 40-59 years old population partaking, and only 24.1% of the 60+ crowd indulging in fast food. Do people younger than 60 eat out more because they are still in the workforce and have the income to do so? Maybe. People older than 60 are generally moving out of the workforce and now have time to cook for themselves at home. Fast food is expensive, too, and retirement can leave people with fixed incomes. It’s possible that they are choosing to eat at home to be healthier and save money. 
          """),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
