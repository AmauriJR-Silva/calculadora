import 'package:flutter/material.dart';

class Display extends StatefulWidget {
  const Display({super.key});

  @override
  State<Display> createState() => _DisplayState();
}

class _DisplayState extends State<Display> {
  String _texto = "0"; // Texto exibido no display
  String _operador = ""; // Operador selecionado (+, -, *, /)
  double? _valorAnterior; // Armazena o valor antes da operação

  // Atualiza o texto do display
  void atualizarDisplay(String novoTexto) {
    setState(() {
      _texto = novoTexto;
    });
  }

  // Lógica para quando um botão numérico é pressionado
  void _onPressed(String texto) {
    if (_texto == "0" && texto != ".") {
      // Se o valor atual for 0 e o botão pressionado não for ".", substitui o 0
      atualizarDisplay(texto);
    } else {
      // Caso contrário, concatena o número pressionado ao texto atual
      atualizarDisplay(_texto + texto);
    }
  }

  // Lógica para quando um operador (+, -, *, /) é pressionado
  void _operacao(String operador) {
    _valorAnterior = double.tryParse(_texto); // Armazena o valor atual
    _operador = operador; // Armazena o operador
    atualizarDisplay(_texto + " " + operador + " "); // Exibe o operador no display
  }

  // Lógica para calcular o resultado quando "=" é pressionado
  void _calcularResultado() {
    // Extrai o valor atual do display (depois do operador)
    double? valorAtual = double.tryParse(_texto.split(' ').last);

    // Verifica se há um valor anterior e atual para realizar o cálculo
    if (_valorAnterior != null && valorAtual != null) {
      double resultado = 0;

      // Realiza a operação de acordo com o operador
      if (_operador == '+') {
        resultado = _valorAnterior! + valorAtual;
      } else if (_operador == '-') {
        resultado = _valorAnterior! - valorAtual;
      } else if (_operador == '*') {
        resultado = _valorAnterior! * valorAtual;
      } else if (_operador == '/') {
        if (valorAtual != 0) {
          resultado = _valorAnterior! / valorAtual;
        } else {
          atualizarDisplay("Erro"); // Exibe erro se dividir por 0
          return;
        }
      }

      // Exibe o resultado sem casas decimais se for inteiro
      atualizarDisplay((resultado % 1 == 0) ? resultado.toInt().toString() : resultado.toString());

      _valorAnterior = null; // Limpa o valor anterior
      _operador = ""; // Limpa o operador
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Área onde o valor e o resultado são exibidos
        Container(
          padding: const EdgeInsets.all(16.0),
          alignment: Alignment.centerRight,
          color: Colors.black,
          child: Text(
            _texto, // Exibe o valor atual do display
            style: const TextStyle(
              fontSize: 48.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        // Botões da calculadora
        Expanded(
          child: Column(
            children: [
              // Linha com os botões 7, 8, 9, e /
              Row(
                children: [
                  _buildButton('7'),
                  _buildButton('8'),
                  _buildButton('9'),
                  _buildButton('/', onPress: () {
                    _operacao('/');
                  }),
                ],
              ),
              // Linha com os botões 4, 5, 6, e *
              Row(
                children: [
                  _buildButton('4'),
                  _buildButton('5'),
                  _buildButton('6'),
                  _buildButton('*', onPress: () {
                    _operacao('*');
                  }),
                ],
              ),
              // Linha com os botões 1, 2, 3, e -
              Row(
                children: [
                  _buildButton('1'),
                  _buildButton('2'),
                  _buildButton('3'),
                  _buildButton('-', onPress: () {
                    _operacao('-');
                  }),
                ],
              ),
              // Linha com os botões 0, ., C, e +
              Row(
                children: [
                  _buildButton('0'),
                  _buildButton('.'),
                  _buildButton('C', onPress: () {
                    atualizarDisplay("0"); // Limpa o display
                    _valorAnterior = null; // Reseta o valor anterior
                    _operador = ""; // Reseta o operador
                  }),
                  _buildButton('+', onPress: () {
                    _operacao('+');
                  }),
                ],
              ),
              // Linha com o botão "="
              Row(
                children: [
                  _buildButton('=', onPress: () {
                    _calcularResultado(); // Calcula o resultado
                  }),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Método que constrói os botões da calculadora
  Widget _buildButton(String texto, {VoidCallback? onPress}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: onPress ?? () => _onPressed(texto), // Função chamada ao pressionar o botão
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(20.0),
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
          ),
          child: Text(
            texto, // Exibe o texto do botão
            style: const TextStyle(
              fontSize: 24.0,
            ),
          ),
        ),
      ),
    );
  }
}
