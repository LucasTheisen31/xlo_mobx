import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:xlo_mobx/components/custom_drawer/custom_drawer.dart';
import 'package:xlo_mobx/stores/edit_account_store.dart';
import 'package:xlo_mobx/stores/page_store.dart';

class EditAccountScreen extends StatelessWidget {
  EditAccountScreen({Key? key}) : super(key: key);

  final EditAccountStore editAccountStore = EditAccountStore();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Conta'),
        centerTitle: true,
      ),
      //drawer: CustomDrawer(),
      body: Center(
        child: SingleChildScrollView(
          child: Card(
            margin: EdgeInsets.symmetric(horizontal: 32),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  //LayoutBuilder Constrói uma árvore de widgets que pode depender do tamanho do widget pai. (Para especificarmos o tamanho do ToggleSwitch)
                  Observer(
                    builder: (context) => IgnorePointer(
                      //ignora o toque na area abaixo quando estiver carregando
                      ignoring: editAccountStore.loading,
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          return ToggleSwitch(
                            //package toggle_switch
                            initialLabelIndex: editAccountStore.userType!.index,
                            totalSwitches: 2,
                            cornerRadius: 20,
                            minWidth: constraints.biggest.width / 2.01,
                            activeBgColor: [
                              Theme.of(context).primaryColor
                            ], //cor botao ativado
                            inactiveBgColor: Colors.grey, //cor botao desativado
                            activeFgColor: Colors.white, //cor texto ativado
                            inactiveFgColor: Colors.white, //cor texto desatiado
                            labels: [
                              'Particular',
                              'Profissional',
                            ],
                            onToggle: editAccountStore.setUserType,
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Observer(
                    builder: (context) => TextFormField(
                      onChanged: editAccountStore.setName,
                      initialValue: editAccountStore.name,
                      enabled: !editAccountStore.loading,
                      decoration: InputDecoration(
                        errorText: editAccountStore.nameError,
                        isDense: true,
                        label: Text('Nome *'),
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Observer(
                    builder: (context) => TextFormField(
                      onChanged: editAccountStore.setPhone,
                      initialValue: editAccountStore.phone,
                      enabled: !editAccountStore.loading,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        //package basil_fields
                        TelefoneInputFormatter(),
                      ],
                      decoration: InputDecoration(
                        errorText: editAccountStore.phoneError,
                        isDense: true,
                        label: Text('Telefone *'),
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Observer(
                    builder: (context) => TextFormField(
                      onChanged: editAccountStore.setPass1,
                      enabled: !editAccountStore.loading,
                      obscureText: true,
                      decoration: InputDecoration(
                        errorText: editAccountStore.passError,
                        isDense: true,
                        label: Text('Nova senha'),
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Observer(
                    builder: (context) => TextFormField(
                      onChanged: editAccountStore.setPass2,
                      enabled: !editAccountStore.loading,
                      obscureText: true,
                      decoration: InputDecoration(
                        errorText: editAccountStore.passError,
                        isDense: true,
                        label: Text('Repita nova senha'),
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Observer(
                    builder: (context) => SizedBox(
                      height: 40,
                      child: ElevatedButton(
                        onPressed: editAccountStore.savePressed,
                        child: editAccountStore.loading
                            ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              )
                            : Text('Salvar'),
                        style: ElevatedButton.styleFrom(
                          primary: Theme.of(context).primaryColor,
                          onSurface: Theme.of(context).primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  SizedBox(
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () {
                        editAccountStore.logout();
                        GetIt.I<PageStore>().setPage(0);
                        Navigator.of(context).pop();
                      },
                      child: Text('Sair'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red,
                        onSurface: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
