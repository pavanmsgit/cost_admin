import 'package:cost_admin/const/app_colors.dart';
import 'package:cost_admin/const/screen_size.dart';
import 'package:cost_admin/controllers/cost_item_controller.dart';
import 'package:cost_admin/controllers/forum_controller.dart';
import 'package:cost_admin/models/cost_items.dart';
import 'package:cost_admin/models/forum.dart';
import 'package:cost_admin/widgets/app_bar.dart';
import 'package:cost_admin/widgets/app_buttons.dart';
import 'package:cost_admin/widgets/loading_widget.dart';
import 'package:cost_admin/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toggle_switch/toggle_switch.dart';

class AddOrUpdateForum extends StatelessWidget {
  AddOrUpdateForum({Key? key, required this.newItem,this.forumItems,this.docId}) : super(key: key);
  final bool newItem;
  Forum? forumItems;
  String? docId;

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
                          title: newItem ? 'Add Discussion' : 'Update Discussion',
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

                              TitleTextField(
                                title: 'HEADLINE',
                                controller: forumController.headlineController,
                                showTitle: true,
                                validator: (val) =>
                                val!.isEmpty ? 'Enter Headline' : null,
                                node: forumController.headlineNode,
                                onSubmit: (val) => forumController.descriptionNode.requestFocus(),
                              ),


                              TitleTextField(
                                title: 'DESCRIPTION',
                                controller: forumController.descriptionController,
                                showTitle: true,
                                validator: (val) =>
                                val!.isEmpty ? 'Enter Description' : null,
                                customHeight: ScreenSize.height(context) * 0.3,
                                node: forumController.descriptionNode,
                                onSubmit: (val) => forumController.descriptionNode.unfocus(),
                                maxLines: 10,
                              ),
                              const SizedBox(height: 20),
                            ],
                          ),
                        ),


                        CostButton(
                          buttonText:
                          newItem ? 'Add Discussion' : 'Update Discussion',
                          onTap: () => newItem ? forumController.addOrEditForum(newItem: newItem) : forumController.addOrEditForum(newItem: newItem,forumItem: forumItems,docId: docId),
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
