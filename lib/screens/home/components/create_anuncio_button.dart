import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get_it/get_it.dart';

import '../../../stores/page_store.dart';

class CreateAnuncioButton extends StatefulWidget {
  const CreateAnuncioButton({Key? key, required this.scrollController})
      : super(key: key);

  final ScrollController scrollController;

  @override
  State<CreateAnuncioButton> createState() => _CreateAnuncioButtonState();
}

class _CreateAnuncioButtonState extends State<CreateAnuncioButton>
    with SingleTickerProviderStateMixin {
  //SingleTickerProviderStateMixin é para o vsync do AnimationController funcioar

  AnimationController? controller;
  Animation<double>? buttonAnimation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    buttonAnimation = Tween<double>(begin: 0, end: 70).animate(
      CurvedAnimation(
        parent: controller!,
        curve: Interval(0.4, 0.6),
      ),
    );

    //adiciona um listner para observar o scrollController passado para esse widget, e quando o listner perceber uma alteração no scrollController vai chamar a funcao scrollChanged
    widget.scrollController.addListener(scrollChanged);
  }

  void scrollChanged() {
    final s = widget.scrollController.position;
    if (s.userScrollDirection == ScrollDirection.forward) {
      //se estiver rolando a tela para baixo, executa a animação
      controller!.forward();
    } else {
      //se estiver rolando a tela para cima, executa a animação ao contrario
      controller!.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: buttonAnimation as Animation<double>,
      builder: (_, __) {
        return FractionallySizedBox(
          //60% da largura da tela
          widthFactor: 0.60,
          child: Container(
            height: 50,
            margin: EdgeInsets.only(
              bottom: buttonAnimation!.value,
            ),
            child: RaisedButton(
              onPressed: () {
                GetIt.I<PageStore>().setPage(1);
              },
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              color: Colors.blueGrey,
              child: Row(
                children: [
                  Icon(
                    Icons.camera_alt,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: Text(
                      'Anunciar agora',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
