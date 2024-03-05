import 'package:flutter/material.dart';
import 'package:quiz/resultado.dart';
import 'quiz_dados.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key, this.acertos = 0, this.quiz = const []});

  final List quiz;

  final int acertos; //disponivel no stateless

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  int perguntaNumero = 1;
  int acertos = 0;
  @override
  Widget build(BuildContext context) {
    if (perguntaNumero == 1) {
      for (var elemento in quiz) {
        List opcoes = elemento['opcoes'];
        int resposta = elemento['resposta'];
        String respostaCorreta = opcoes[resposta - 1];

        opcoes.shuffle();
        for (var opcao in opcoes) {
          if (opcao == respostaCorreta) {
            resposta = opcoes.indexOf(opcao) + 1;
            break;
          }
        }
        elemento['resposta'] = resposta;

        quiz.shuffle();
      }
    }

    void respondeu(int respostaUsuario) {
      setState(() {
        if (quiz[perguntaNumero - 1]['resposta'] == respostaUsuario) {
          acertos++;
        }

        if (perguntaNumero >= 3) {
          Navigator.pushNamed(context, 'Resultado',
              arguments: Argumentos(acertos));
        } else {
          perguntaNumero = perguntaNumero + 1;
        }
      });
    }

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Center(child: Text("Quiz")),
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text('Pergunta $perguntaNumero de 3',
                  style: const TextStyle(fontSize: 20)),
              Text(
                '${quiz[perguntaNumero - 1]['pergunta']}',
                style: const TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    respondeu(1);
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.fromLTRB(100, 20, 100, 20),
                    backgroundColor: Colors.blue,
                  ),
                  child: Text(
                    '${quiz[perguntaNumero - 1]['opcoes'][0]}',
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    respondeu(2);
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.fromLTRB(100, 20, 100, 20),
                    backgroundColor: Colors.blue,
                  ),
                  child: Text(
                    '${quiz[perguntaNumero - 1]['opcoes'][1]}',
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    respondeu(3);
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.fromLTRB(100, 20, 100, 20),
                    backgroundColor: Colors.blue,
                  ),
                  child: Text(
                    '${quiz[perguntaNumero - 1]['opcoes'][2]}',
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
