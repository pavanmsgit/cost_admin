import 'package:cost_admin/widgets/app_bar.dart';
import 'package:flutter/material.dart';



class PurchaseCostItemPage extends StatefulWidget {
  const PurchaseCostItemPage({Key? key}) : super(key: key);

  @override
  State<PurchaseCostItemPage> createState() => _PurchaseCostItemPageState();
}

class _PurchaseCostItemPageState extends State<PurchaseCostItemPage> {

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBarLogo(),

        SliverToBoxAdapter(
          child: Column(
            children: [

            ],
          ),
        ),
      ],
    );
  }
}
