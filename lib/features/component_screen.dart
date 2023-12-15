import "package:flutter/material.dart";
import "package:morrf/core/common/widgets/morrf_dropdown.dart";
import "package:morrf/core/enums/font_size.dart";
import "package:morrf/core/enums/severity.dart";
import "package:morrf/core/widgets/morff_text.dart";
import "package:morrf/core/widgets/morrf_button.dart";
import "package:morrf/core/widgets/morrf_input_field.dart";
import "package:morrf/core/widgets/morrf_scaffold.dart";

class ComponentScreen extends StatefulWidget {
  const ComponentScreen({super.key});

  @override
  State<ComponentScreen> createState() => _ComponentScreenState();
}

class _ComponentScreenState extends State<ComponentScreen> {
  List<String> dropdownList = ["One", "Two", "Three"];
  late String dropdownSelected = dropdownList[0];

  @override
  Widget build(BuildContext context) {
    return MorrfScaffold(
      title: 'Title',
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const MorrfText(
                  text: "This is an H1",
                  size: FontSize.h1,
                ),
                SizedBox(height: 16),
                const MorrfText(
                  text: "This is an H2",
                  size: FontSize.h2,
                ),
                SizedBox(height: 16),
                const MorrfText(
                  text: "This is an H3",
                  size: FontSize.h3,
                ),
                SizedBox(height: 16),
                const MorrfText(
                  text: "This is an H4",
                  size: FontSize.h4,
                ),
                SizedBox(height: 16),
                const MorrfText(
                  text: "This is an H5",
                  size: FontSize.h5,
                ),
                SizedBox(height: 16),
                const MorrfText(
                  text: "This is an H6",
                  size: FontSize.h6,
                ),
                SizedBox(height: 16),
                const MorrfText(
                  text: "This is oversized Text",
                  size: FontSize.lp,
                ),
                SizedBox(height: 16),
                const MorrfText(
                  text: "This is Some Text",
                  size: FontSize.p,
                ),
                SizedBox(height: 16),
                const MorrfText(
                    text: "This is a Link", size: FontSize.p, isLink: true),
                SizedBox(height: 16),
                MorrfButton(text: "Submit", onPressed: () => print("Testing")),
                SizedBox(height: 16),
                MorrfButton(
                    text: "Default",
                    onPressed: () => print("Testing"),
                    fullWidth: true),
                SizedBox(height: 16),
                MorrfButton(
                    text: "Danger",
                    severity: Severity.danger,
                    onPressed: () => print("Testing"),
                    fullWidth: true),
                SizedBox(height: 16),
                MorrfButton(
                    text: "Warn",
                    severity: Severity.warn,
                    onPressed: () => print("Testing"),
                    fullWidth: true),
                SizedBox(height: 16),
                MorrfInputField(
                  placeholder: "Input Field",
                ),
                SizedBox(height: 16),
                MorrfInputField(
                  placeholder: "Input Field",
                  initialValue: "Initial Value",
                ),
                SizedBox(height: 16),
                MorrfInputField(
                  placeholder: "Password",
                  isSecure: true,
                ),
                SizedBox(height: 16),
                MorrfDrowpdown(
                    selected: dropdownSelected,
                    label: "label",
                    list: dropdownList,
                    onChange: (String value) {
                      setState(() {
                        dropdownSelected = value;
                      });
                    }),
                SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
