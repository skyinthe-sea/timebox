import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../config/themes/app_colors.dart';
import '../../../../l10n/app_localizations.dart';
import '../../domain/entities/math_challenge.dart';

/// 수학 문제 해제 다이얼로그
///
/// 집중 모드 종료 시 3개의 수학 문제를 풀어야 해제됨
class MathChallengeDialog extends StatefulWidget {
  final VoidCallback onSuccess;
  final VoidCallback onCancel;
  final int totalQuestions;

  const MathChallengeDialog({
    super.key,
    required this.onSuccess,
    required this.onCancel,
    this.totalQuestions = 3,
  });

  @override
  State<MathChallengeDialog> createState() => _MathChallengeDialogState();
}

class _MathChallengeDialogState extends State<MathChallengeDialog> {
  late MathChallenge _currentChallenge;
  final _answerController = TextEditingController();
  final _focusNode = FocusNode();
  int _currentQuestion = 0;
  bool _showError = false;
  bool _showSuccess = false;

  @override
  void initState() {
    super.initState();
    _generateNewChallenge();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _answerController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _generateNewChallenge() {
    setState(() {
      _currentChallenge = MathChallenge.generate();
      _answerController.clear();
      _showError = false;
      _showSuccess = false;
    });
  }

  void _checkAnswer() {
    final userAnswerText = _answerController.text.trim();
    if (userAnswerText.isEmpty) return;

    final userAnswer = int.tryParse(userAnswerText);
    if (userAnswer == null) {
      setState(() => _showError = true);
      return;
    }

    if (_currentChallenge.checkAnswer(userAnswer)) {
      // 정답
      setState(() {
        _showSuccess = true;
        _showError = false;
      });

      // 다음 문제로 이동
      Future.delayed(const Duration(milliseconds: 500), () {
        if (!mounted) return;

        if (_currentQuestion + 1 >= widget.totalQuestions) {
          // 모든 문제 완료
          widget.onSuccess();
        } else {
          // 다음 문제
          setState(() {
            _currentQuestion++;
            _showSuccess = false;
          });
          _generateNewChallenge();
          _focusNode.requestFocus();
        }
      });
    } else {
      // 오답
      setState(() {
        _showError = true;
        _showSuccess = false;
      });
      _answerController.clear();
      _focusNode.requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final isDark = theme.brightness == Brightness.dark;

    return AlertDialog(
      title: Row(
        children: [
          Icon(
            Icons.calculate,
            color: theme.colorScheme.primary,
          ),
          const SizedBox(width: 8),
          Text(l10n.mathChallenge),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 진행 상황 표시
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(widget.totalQuestions, (index) {
              final isCompleted = index < _currentQuestion;
              final isCurrent = index == _currentQuestion;

              return Container(
                width: 32,
                height: 32,
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isCompleted
                      ? (isDark ? AppColors.successDark : AppColors.successLight)
                      : isCurrent
                          ? theme.colorScheme.primary
                          : theme.colorScheme.surfaceContainerHighest,
                  border: isCurrent
                      ? Border.all(
                          color: theme.colorScheme.primary,
                          width: 2,
                        )
                      : null,
                ),
                child: Center(
                  child: isCompleted
                      ? const Icon(Icons.check, size: 18, color: Colors.white)
                      : Text(
                          '${index + 1}',
                          style: TextStyle(
                            color: isCurrent
                                ? Colors.white
                                : theme.colorScheme.onSurfaceVariant,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              );
            }),
          ),

          const SizedBox(height: 24),

          // 문제 표시
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 16,
            ),
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              _currentChallenge.expression,
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                fontFeatures: const [FontFeature.tabularFigures()],
              ),
            ),
          ),

          const SizedBox(height: 24),

          // 답 입력
          TextField(
            controller: _answerController,
            focusNode: _focusNode,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'[0-9-]')),
            ],
            textAlign: TextAlign.center,
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
            decoration: InputDecoration(
              hintText: l10n.enterAnswer,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              filled: true,
              fillColor: _showError
                  ? (isDark
                      ? AppColors.errorDark.withValues(alpha: 0.1)
                      : AppColors.errorLight.withValues(alpha: 0.1))
                  : _showSuccess
                      ? (isDark
                          ? AppColors.successDark.withValues(alpha: 0.1)
                          : AppColors.successLight.withValues(alpha: 0.1))
                      : null,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: _showError
                      ? (isDark ? AppColors.errorDark : AppColors.errorLight)
                      : _showSuccess
                          ? (isDark
                              ? AppColors.successDark
                              : AppColors.successLight)
                          : theme.colorScheme.outline,
                  width: _showError || _showSuccess ? 2 : 1,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: _showError
                      ? (isDark ? AppColors.errorDark : AppColors.errorLight)
                      : _showSuccess
                          ? (isDark
                              ? AppColors.successDark
                              : AppColors.successLight)
                          : theme.colorScheme.primary,
                  width: 2,
                ),
              ),
              suffixIcon: _showSuccess
                  ? Icon(
                      Icons.check_circle,
                      color:
                          isDark ? AppColors.successDark : AppColors.successLight,
                    )
                  : null,
            ),
            onSubmitted: (_) => _checkAnswer(),
          ),

          // 오류 메시지
          if (_showError)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                l10n.wrongAnswer,
                style: TextStyle(
                  color: isDark ? AppColors.errorDark : AppColors.errorLight,
                  fontSize: 12,
                ),
              ),
            ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: widget.onCancel,
          child: Text(l10n.cancel),
        ),
        FilledButton(
          onPressed: _checkAnswer,
          child: Text(l10n.confirm),
        ),
      ],
    );
  }
}
