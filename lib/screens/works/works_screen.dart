import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:ingemec/controllers/cotizacion_controller.dart';

import 'package:ingemec/screens/works/widgets/Follows_list.dart';
import 'package:ingemec/screens/works/widgets/quotes_card.dart';
import 'package:ingemec/styles.dart';

class WorksScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal:10.0,vertical: 5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            _TitleWithRefreshButton(title: 'Seguimientos activos',onPressed: (){}),
            SizedBox(height: 10,),
            FollowsList(),
            SizedBox(height: 8,),
            _TitleWithRefreshButton(title: 'Cotizaciones',
              onPressed: () => QuotesController().getActiveQuotesWithVehicle(),
            ),
            GetBuilder<QuotesController>(
              init: QuotesController(),
              id: 'activeQuotes',
              builder: (controller) {
                if (!controller.loading) {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: controller.activeQuotes.length ,
                      itemBuilder: (_,i) =>
                        QuotesCard(quote: controller.activeQuotes[i],),
                      physics: BouncingScrollPhysics(),
                    ),
                  );
                }else
                  return Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
              }
            ),

          ],
        ),
      ),
    );
  }
}

class _TitleWithRefreshButton extends StatelessWidget {

  final VoidCallback onPressed;
  final String title;


  const _TitleWithRefreshButton({
    Key key,
    @required this.onPressed,
    this.title = ''
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(this.title,style: Styles.bigTitle,),
        IconButton(icon: Icon(FeatherIcons.refreshCcw), onPressed: this.onPressed)
      ],
    );
  }
}