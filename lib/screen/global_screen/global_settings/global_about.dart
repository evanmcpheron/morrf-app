import 'package:flutter/material.dart';
import 'package:morrf/utils/constants/special_color.dart';
import 'package:morrf/utils/enums/font_size.dart';
import 'package:morrf/widgets/morff_text.dart';
import 'package:morrf/widgets/morrf_scaffold.dart';

class ClientAbout extends StatefulWidget {
  const ClientAbout({super.key});

  @override
  State<ClientAbout> createState() => _ClientAboutState();
}

class _ClientAboutState extends State<ClientAbout> {
  @override
  Widget build(BuildContext context) {
    return MorrfScaffold(
      title: "About Us",
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 15.0),
            MorrfText(
                text: 'Our History',
                size: FontSize.h5,
                style: TextStyle(
                    color: Theme.of(context).colorScheme.primaryColor)),
            const SizedBox(height: 10.0),
            const MorrfText(
              text:
                  'Food First envisions a world in which all people have access to healthy, ecologically produced, and culturally appropriate food. After 40 years of analysis of the global food system, we know that making this vision a reality involves more than tech nical solutions—it requires political tran sformation. That’s why Food First supports activists, social movements, alliances, and coalitions working for systemic change. Our work—including action-oriented rese arch, publications, and projects—gives you the tools to understand the global food system, build your local food movement, and engage with the global movement for food sovereignty.',
              size: FontSize.p,
            ),
          ],
        ),
      ),
    );
  }
}
