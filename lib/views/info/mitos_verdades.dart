import 'package:artriapp/models/myth.dart';
import 'package:artriapp/utils/consts/all_myths.dart';
import 'package:artriapp/utils/enums/answer_type_enum.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class MitosVerdadesInfoPage extends StatelessWidget {
  final Myth? highlightedMyth;

  const MitosVerdadesInfoPage({
    super.key,
    this.highlightedMyth,
  });

  Widget buildCard({
    required String title,
    required String description,
    required bool isMyth,
    bool isHighlighted = false,
  }) {
    final color = isMyth ? Colors.red : Colors.green;
    final label = isMyth ? 'Mito' : 'Verdade';
    final icon = isMyth ? Icons.close : Icons.check;

    // Se for o mito destacado, usar uma cor de fundo diferente e uma borda mais grossa
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: isHighlighted
            ? Colors.amber.withValues(alpha: 0.10)
            : color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isHighlighted ? Colors.amber.shade700 : color,
          width: isHighlighted ? 5 : 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isHighlighted)
            Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 6,
              ),
              decoration: BoxDecoration(
                color: Colors.amber.shade100,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                '⭐ Mito/Verdade em destaque! ⭐',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          Row(
            children: [
              Icon(icon, color: color),
              const SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const Gap(8),
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const Gap(8),
          Text(
            description,
            style: const TextStyle(height: 1.4),
          ),
        ],
      ),
    );
  }

  // TODO: adicionar um botão "Saber mais" que leva para uma página com informações detalhadas
  // sobre o mito/verdade, usando o mesmo layout de card, mas com mais texto e
  // imagens explicativas. Essa página pode ser acessada tanto pelo card destacado quanto pelos
  // outros cards.
  @override
  Widget build(BuildContext context) {
    final myths = [...AllMyths.myths];

    if (highlightedMyth != null) {
      myths.removeWhere(
        (m) => m.question == highlightedMyth!.question,
      );

      myths.insert(0, highlightedMyth!);
    }
    return Scaffold(
      appBar: AppBar(title: const Text('Mitos e Verdades')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Column(
              children: myths.map((myth) {
                return buildCard(
                  title: myth.question,
                  description: myth.description,
                  isMyth: myth.answerType == AnswerType.myth,
                  isHighlighted: highlightedMyth?.question == myth.question,
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
