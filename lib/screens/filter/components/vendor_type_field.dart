import 'package:flutter/material.dart';
import 'package:xlo_mobx/screens/filter/components/section_title.dart';
import 'package:xlo_mobx/stores/filter_store.dart';

class VendorTypeField extends StatelessWidget {
  const VendorTypeField({Key? key, required this.filterStore})
      : super(key: key);

  final FilterStore filterStore;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(title: 'Tipo de Anunciante'),
        Row(
          children: [],
        )
      ],
    );
  }
}
