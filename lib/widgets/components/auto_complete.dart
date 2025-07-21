import 'package:flutter/material.dart';

List<String> Function(TextEditingValue textEditingValue)
autoCompleteOptionsBuilder(List<String> options) {
  return (TextEditingValue textEditingValue) {
    if (textEditingValue.text.isEmpty) {
      return options;
    }

    return options
        .where(
          (option) => option.toLowerCase().contains(
            textEditingValue.text.toLowerCase(),
          ),
        )
        .toList();
  };
}

Widget autoCompleteViewBuilder(
  BuildContext context,
  AutocompleteOnSelected<String> onSelected,
  Iterable<String> options,
) {
  return Align(
    alignment: Alignment.topLeft,
    child: Material(
      elevation: 4.0,
      child: SizedBox(
        width: MediaQuery.of(context).size.width - 16 - 16,
        height: 200.0,
        child: ListView.builder(
          itemCount: options.length,
          itemBuilder: (BuildContext context, int index) {
            final String option = options.elementAt(index);
            return InkWell(
              onTap: () {
                onSelected(option);
              },
              child: ListTile(title: Text(option)),
            );
          },
        ),
      ),
    ),
  );
}
