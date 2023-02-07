import 'package:cost_admin/const/app_colors.dart';
import 'package:cost_admin/const/screen_size.dart';
import 'package:cost_admin/controllers/cost_item_controller.dart';
import 'package:cost_admin/models/cost_items.dart';
import 'package:cost_admin/widgets/app_bar.dart';
import 'package:cost_admin/widgets/app_buttons.dart';
import 'package:cost_admin/widgets/loading_widget.dart';
import 'package:cost_admin/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toggle_switch/toggle_switch.dart';

class AddOrUpdateCostItem extends StatelessWidget {
  AddOrUpdateCostItem({Key? key, required this.newItem,this.costItems}) : super(key: key);
  final bool newItem;
  CostItems? costItems;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Spinner(
        child: Scaffold(
          backgroundColor: AppColor.white,
          body: Padding(
            padding: const EdgeInsets.all(0),
            child: GetBuilder(
              init: CostItemsController(),
              builder: (_) => NestedScrollView(
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return <Widget>[
                    SliverOverlapAbsorber(
                        handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                            context),
                        sliver: SliverAppBarLogoWithBackButton(
                          title: newItem ? 'Add Cost Item' : 'Update Cost Item',
                        ))
                  ];
                },
                body: Padding(
                  padding:
                  const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                  child: Form(
                    key: costItemsController.addCostItemKey,
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView(
                            children: [
                              Obx(
                                    () => ToggleSwitch(
                                  minWidth: ScreenSize.width(context) * 0.9,
                                  initialLabelIndex: costItemsController.costItemType.value,
                                  cornerRadius: 10.0,
                                  activeFgColor: AppColor.white,
                                  inactiveBgColor:
                                  AppColor.grey.withOpacity(0.5),
                                  inactiveFgColor: AppColor.white,
                                  totalSwitches: 3,
                                  isVertical: false,
                                  labels: const ['COIN', 'STAMP', 'AUCTION'],
                                  icons: const [
                                    Icons.monetization_on_outlined,
                                    Icons.local_post_office_outlined,
                                    Icons.account_balance,
                                  ],
                                  activeBgColor: const [AppColor.primaryColor],
                                  onToggle: (index) {
                                      costItemsController.costItemType.value = index!;
                                  },
                                ),
                              ),

                              const SizedBox(
                                height: 10,
                              ),

                              TitleTextField(
                                title: 'HEADLINE',
                                controller: costItemsController.headlineController,
                                showTitle: true,
                                validator: (val) =>
                                val!.isEmpty ? 'Enter Headline' : null,
                                node: costItemsController.headlineNode,
                                onSubmit: (val) => costItemsController.descriptionNode.requestFocus(),
                              ),


                              TitleTextField(
                                title: 'DESCRIPTION',
                                controller: costItemsController.descriptionController,
                                showTitle: true,
                                validator: (val) =>
                                val!.isEmpty ? 'Enter Description' : null,
                                node: costItemsController.descriptionNode,
                                onSubmit: (val) => costItemsController.priceNode.requestFocus(),
                              ),



                              TitleTextField(
                                title: 'PRICE',
                                controller: costItemsController.priceController,
                                showTitle: true,
                                validator: (val) =>
                                val!.isEmpty ? 'Enter Price' : null,
                                node: costItemsController.priceNode,
                                keyboardType: TextInputType.number,
                                onSubmit: (val) => costItemsController.priceNode.unfocus(),
                              ),


                              newItem ? SelectImageButton(
                                title: 'COST ITEM PHOTO',
                                image: costItemsController.image,
                                onTap: costItemsController.selectImage,
                              ) : Container(),



                              const SizedBox(height: 20),
                            ],
                          ),
                        ),


                        CostButton(
                          buttonText:
                          newItem ? 'Add Item' : 'Update Item',
                          onTap: () => newItem ? costItemsController.addOrUpdateCostItem(newItem: newItem) : costItemsController.addOrUpdateCostItem(newItem: newItem,costItem: costItems),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
