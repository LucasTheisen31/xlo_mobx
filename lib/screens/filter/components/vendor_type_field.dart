import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
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
        Observer(
            builder: (context) => Wrap(
                  //Wrap tenta colocar os widgets um ao lado do outro como uma Column, mas se a tela for pequena joga para baixo
                  runSpacing: 4,
                  children: [
                    GestureDetector(
                      onTap: () {
                        //se particular ja estiver habilitado
                        if (filterStore.isTypeParticular) {
                          //se professional tambem estiver habilitado
                          if (filterStore.isTypeProfessional) {
                            //permite desativar o particular
                            filterStore.resetVendorType(VENDOR_TYPE_PARTICULAR);
                          } else {
                            filterStore
                                .selectVendorType(VENDOR_TYPE_PROFESSIONAL);
                          }
                        } else {
                          //se nao estiver selecionado
                          filterStore.setVendorType(VENDOR_TYPE_PARTICULAR);
                        }
                      },
                      child: Container(
                        height: 50,
                        width: 120,
                        padding: EdgeInsets.symmetric(horizontal: 24),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: filterStore.isTypeParticular
                              ? Theme.of(context).primaryColor
                              : Colors.transparent,
                          border: Border.all(
                            color: filterStore.isTypeParticular
                                ? Theme.of(context).primaryColor
                                : Colors.black,
                          ),
                        ),
                        //alinha o filho no centro o container
                        alignment: Alignment.center,
                        child: Text(
                          'Particular',
                          style: TextStyle(
                            color: filterStore.isTypeParticular
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    GestureDetector(
                      onTap: () {
                        //se professional ja estiver habilitado
                        if (filterStore.isTypeProfessional) {
                          //se particular tambem estiver habilitado
                          if (filterStore.isTypeParticular) {
                            //permite desativar o professional
                            filterStore
                                .resetVendorType(VENDOR_TYPE_PROFESSIONAL);
                          } else {
                            filterStore
                                .selectVendorType(VENDOR_TYPE_PARTICULAR);
                          }
                        } else {
                          //se nao estiver selecionado
                          filterStore.setVendorType(VENDOR_TYPE_PROFESSIONAL);
                        }
                      },
                      child: Container(
                        height: 50,
                        width: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: filterStore.isTypeProfessional
                              ? Theme.of(context).primaryColor
                              : Colors.transparent,
                          border: Border.all(
                            color: filterStore.isTypeProfessional
                                ? Theme.of(context).primaryColor
                                : Colors.black,
                          ),
                        ),
                        //alinha o filho no centro o container
                        alignment: Alignment.center,
                        child: Text(
                          'Profissional',
                          style: TextStyle(
                            color: filterStore.isTypeProfessional
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ))
      ],
    );
  }
}
