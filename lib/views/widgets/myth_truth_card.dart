import 'package:artriapp/models/myth.dart';
import 'package:artriapp/routes/info.routes.dart';
import 'package:flutter/material.dart';
import 'package:artriapp/utils/enums/index.dart';
import 'package:artriapp/models/index.dart';
import 'package:go_router/go_router.dart';

class MythTruthCard extends StatelessWidget {
  final Myth myth;
  final IconData leadingIcon;

  const MythTruthCard({
    super.key,
    required this.myth,
    this.leadingIcon = Icons.help_outline, // Default leading icon
  });

  // popup com o resultado da resposta e um botão para saber mais, que leva para a página de mitos e verdades, destacando o mito respondido
  void _showResultDialog(
    BuildContext context,
    AnswerType userAnswer,
  ) {
    final bool acertou = userAnswer == myth.answerType;

    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  acertou ? Icons.check_circle : Icons.cancel,
                  size: 72,
                  color: acertou ? Colors.green : Colors.red,
                ),
                const SizedBox(height: 16),
                Text(
                  acertou ? 'Você acertou!' : 'Você errou!',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: myth.answerType == AnswerType.truth
                        ? Colors.green.shade100
                        : Colors.red.shade100,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    myth.answerType == AnswerType.truth ? 'VERDADE' : 'MITO',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: myth.answerType == AnswerType.truth
                          ? Colors.green.shade800
                          : Colors.red.shade800,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  myth.question,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  myth.description,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey.shade700,
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              30,
                            ),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'Fechar',
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(
                            0xFF026873,
                          ),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              30,
                            ),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                          context.push(
                            InfoRoutes.mythsTruthsInfoPage,
                            extra: myth,
                          );
                        },
                        child: const Text(
                          'Saber mais',
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          color: Colors.black.withValues(alpha: 0.5),
          width: 2,
        ),
      ),
      elevation: 4,
      color: Colors.white, // Background color
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(20),
        child: Container(
          constraints: const BoxConstraints(
            minHeight: 100,
            maxWidth: 400, // Adjust based on your needs
          ),
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Leading icon
              Icon(
                leadingIcon,
                size: 32,
                color: Colors.blueGrey[700],
              ),
              const SizedBox(width: 16),

              // Question and Answer
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      myth.question,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueGrey[900],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.check_circle,
                            color: Colors.green[700],
                            size: 28,
                          ),
                          onPressed: () {
                            _showResultDialog(
                              context,
                              AnswerType.truth,
                            );
                          },
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.cancel,
                            color: Colors.red[700],
                            size: 28,
                          ),
                          onPressed: () {
                            _showResultDialog(
                              context,
                              AnswerType.myth,
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
