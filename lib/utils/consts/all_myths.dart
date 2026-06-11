import 'package:artriapp/models/index.dart';
import 'package:artriapp/utils/enums/index.dart';

class AllMyths {
  static List<Myth> get myths => [
        Myth(
          question: 'Não há tratamento para a artrite reumatoide',
          description:
              'Existem diversos tratamentos eficazes, como os medicamentos modificadores da doença, e não farmacológicos, como o tratamento fisioterapêutico, mudança de hábitos de vida.',
          answerType: AnswerType.myth,
        ),
        Myth(
          question: 'A artrite reumatoide só afeta pessoas mais velhas',
          description:
              'A doença pode afetar pessoas de diferentes idades, incluindo crianças.',
          answerType: AnswerType.myth,
        ),
        Myth(
          question: 'A artrite reumatoide afeta só os ossos',
          description:
              'A artrite pode afetar outras partes do corpo além das articulações, como pulmões, coração, rins.',
          answerType: AnswerType.myth,
        ),
        Myth(
          question: 'A alimentação pode influenciar nos sintomas',
          description:
              'Dietas equilibradas, ricas em nutrientes anti-inflamatórios, contribuem para aliviar os sintomas e melhorar a qualidade de vida do paciente.',
          answerType: AnswerType.truth,
        ),
        Myth(
          question: 'O estresse pode agravar a artrite reumatoide',
          description:
              'O estresse  pode desencadear ou piorar crises inflamatórias.',
          answerType: AnswerType.truth,
        ),
        Myth(
          question: 'A doença só afeta as mãos',
          description:
              'Apesar de ser comum nas mãos, a artrite reumatoide pode atingir punhos, joelhos, ombros, tornozelos e até órgãos internos.',
          answerType: AnswerType.myth,
        ),
        Myth(
          question:
              'A má qualidade do sono piora os sintomas da artrite reumatoide',
          description:
              'O sono ruim pode aumentar a percepção da dor, a fadiga e a inflamação, dificultando o controle da doença.',
          answerType: AnswerType.truth,
        ),
        Myth(
          question: 'Dormir bem ajuda no controle da inflamação',
          description:
              'Durante o sono, o corpo regula o sistema imune e reduz marcadores inflamatórios. Um sono reparador contribui para a eficácia do tratamento.',
          answerType: AnswerType.truth,
        ),
        Myth(
          question:
              'Exercício regular ajuda a manter a mobilidade e reduzir a rigidez',
          description:
              'Movimentar o corpo com segurança melhora a função articular e reduz a inflamação.',
          answerType: AnswerType.truth,
        ),
        Myth(
          question:
              'Atividades físicas leves a moderadas são seguras e recomendadas',
          description:
              'Caminhadas, hidroginástica, yoga e pilates adaptado são excelentes opções.',
          answerType: AnswerType.truth,
        ),
        Myth(
          question: 'Atividade física piora a artrite reumatoide',
          description:
              'O repouso excessivo piora a rigidez e a fraqueza muscular. Exercícios adequados, supervisionados, ajudam na recuperação funcional.',
          answerType: AnswerType.myth,
        ),
        Myth(
          question: 'Fazer exercício irá piorar a minha dor',
          description:
              'Movimentar o corpo com segurança melhora a função articular, reduz a inflamação e pode ajudar a melhorar a dor. ',
          answerType: AnswerType.myth,
        ),
        Myth(
          question:
              'A dor da artrite reumatoide é constante e igual para todo mundo',
          description:
              'A intensidade e o padrão da dor variam muito entre os pacientes, e podem mudar ao longo do tempo.',
          answerType: AnswerType.myth,
        ),
        Myth(
          question: 'Práticas de relaxamento ajudam no controle da dor',
          description:
              'Técnicas como respiração profunda, meditação e mindfulness ajudam a reduzir a tensão muscular, o estresse e a percepção da dor.',
          answerType: AnswerType.truth,
        ),
        Myth(
          question:
              'Técnicas de relaxamento não são eficazes  para quem tem doença crônica',
          description:
              'O relaxamento ajuda a regular o sistema nervoso autônomo, reduz o cortisol (hormônio do estresse) e melhora o sono e o humor.',
          answerType: AnswerType.myth,
        ),
      ];
}
