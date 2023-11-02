import 'package:flutter/material.dart';
import 'package:morrf/utils/constants/special_color.dart';
import 'package:morrf/utils/enums/font_size.dart';
import 'package:morrf/widgets/morff_text.dart';
import 'package:morrf/widgets/morrf_scaffold.dart';

class ClientPolicy extends StatefulWidget {
  const ClientPolicy({super.key});

  @override
  State<ClientPolicy> createState() => _ClientPolicyState();
}

class _ClientPolicyState extends State<ClientPolicy> {
  @override
  Widget build(BuildContext context) {
    return MorrfScaffold(
      title: "Privacy Policy",
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 15.0),
              MorrfText(
                text: 'Disclosures of Your Information',
                size: FontSize.h5,
                style: TextStyle(
                    color: Theme.of(context).colorScheme.primaryColor),
              ),
              const SizedBox(height: 10.0),
              const MorrfText(
                text:
                    'Food First envisions a world in which all people have access to healthy, ecologically produced, and culturally appropriate food. After 40 years of analysis of the global food system, we know that making this vision a reality involves more than tech nical solutions—it requires political tran sformation. That’s why Food First supports activists, social movements, alliances, and coalitions working for systemic change. Our work—including action-oriented rese arch, publications, and projects—gives you the tools to understand the global food system, build your local food movement, and engage with the global movement for food sovereignty.',
                size: FontSize.p,
              ),
              const SizedBox(height: 20.0),
              MorrfText(
                text: 'Legal Disclaimer',
                size: FontSize.h5,
                style: TextStyle(
                    color: Theme.of(context).colorScheme.primaryColor),
              ),
              const SizedBox(height: 10.0),
              const MorrfText(
                text:
                    'We reserve the right to disclose your persona lly identifiable information as required by law and when believe it is necessary to share infor mation in order to investigate, prevent, or take action regarding illegal activities, suspected fraud, situations involving',
                size: FontSize.p,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
