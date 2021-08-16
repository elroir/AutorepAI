import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:ingemec/controllers/cotizacion_controller.dart';
import 'package:ingemec/controllers/works_controller.dart';

import 'package:ingemec/screens/works/widgets/works_list.dart';
import 'package:ingemec/screens/works/widgets/quotes_card.dart';
import 'package:ingemec/screens/works/works_form.dart';
import 'package:ingemec/screens/works/works_history.dart';
import 'package:ingemec/styles.dart';
import 'package:ingemec/widgets/card_button.dart';

class WorksScreen extends StatefulWidget {

  @override
  _WorksScreenState createState() => _WorksScreenState();
}

class _WorksScreenState extends State<WorksScreen> {
  
  @override
  void initState() {
    final work = Get.put(WorksController());
    work.loadWorks();
    work.loadHistory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final quote = Get.put(QuotesController());
    final works = Get.put(WorksController());
    
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal:10.0,vertical: 5.0),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              TitleWithRefreshButton(title: 'Ordenes activas',onPressed: () => works.loadWorks()),
              SizedBox(height: 10,),
              WorksList(),
              SizedBox(height: 8,),
              TitleWithRefreshButton(title: 'Cotizaciones',
                onPressed: () => quote.getActiveQuotesWithVehicle(),
              ),
              GetBuilder<QuotesController>(
                init: QuotesController(),
                id: 'activeQuotes',
                builder: (controller) {
                  if (!controller.loading) {
                    return Center(
                      child: Column(
                        children: controller.activeQuotes.map((quote) =>
                            FadeIn(child: Container(
                              width: Get.width*0.9,
                                child: QuotesCard(quote: quote,onPressed: () => Get.to(() => WorksForm(quote: quote)),))
                            ),
                        ).toList()

                      ),
                    );
                  }else
                    return Center(
                      child: CircularProgressIndicator.adaptive(),
                    );
                }
              ),
              SizedBox(height: 25,),
              Center(
                child: CardButton(
                  width: Get.width*0.9,
                  icon: FeatherIcons.bookOpen,
                  text: 'Historial de ordenes',
                  onPressed: () => Get.to(()=> WorksHistory()),
                ),
              ),
              SizedBox(height: 25,)

            ],
          ),
        ),
      ),
    );
  }
}

class TitleWithRefreshButton extends StatelessWidget {

  final VoidCallback onPressed;
  final String title;


  const TitleWithRefreshButton({
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