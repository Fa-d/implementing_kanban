import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:implementing_kanban/card_item_models/attatchment_model.dart';
import 'package:implementing_kanban/providers_packs/all_providers.dart';
import 'package:url_launcher/url_launcher.dart';

class AttatchmentWidget extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final attatchmentListsProv = useProvider(attatchmentLists.state);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height / 3,
          width: MediaQuery.of(context).size.width / 2,
          child: Column(
            children: [
              ...attatchmentListsProv
                  .map((e) => _attachmentLists(e.link, e.name))
                  .toList(),
              FlatButton(
                onPressed: () {},
                child: AtatchmentModel(
                  buttonName: "Attatchment",
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  _attachmentLists(String link, String name) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: ListTile(
        hoverColor: Colors.grey[300],
        leading: FlatButton(
          onPressed: () => _launchURL(link),
          child: Text("Link"),
        ),
        title: Text('$name'),
        subtitle: Text('$link'),
      ),
    );
  }

  _launchURL(String link) async {
    if (await canLaunch(link)) {
      await launch(link);
    } else {
      throw 'Could not launch $link';
    }
  }
}
