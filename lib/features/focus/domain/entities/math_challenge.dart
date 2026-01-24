import 'dart:math';

/// 수학 연산 유형
enum MathOperation {
  add,
  subtract,
  multiply,
}

/// 수학 문제 엔티티
///
/// 집중 모드 종료 시 풀어야 하는 수학 문제
class MathChallenge {
  final int operand1;
  final int operand2;
  final MathOperation operation;
  final int answer;

  const MathChallenge({
    required this.operand1,
    required this.operand2,
    required this.operation,
    required this.answer,
  });

  /// 랜덤 수학 문제 생성
  factory MathChallenge.generate() {
    final random = Random();
    final operation = MathOperation.values[random.nextInt(3)];

    int op1, op2, answer;

    switch (operation) {
      case MathOperation.add:
        // 덧셈: 10~99 + 10~99
        op1 = random.nextInt(90) + 10;
        op2 = random.nextInt(90) + 10;
        answer = op1 + op2;
        break;

      case MathOperation.subtract:
        // 뺄셈: 큰 수 - 작은 수 (음수 방지)
        op1 = random.nextInt(90) + 10;
        op2 = random.nextInt(90) + 10;
        if (op1 < op2) {
          final temp = op1;
          op1 = op2;
          op2 = temp;
        }
        answer = op1 - op2;
        break;

      case MathOperation.multiply:
        // 곱셈: 2~12 × 2~12
        op1 = random.nextInt(11) + 2;
        op2 = random.nextInt(11) + 2;
        answer = op1 * op2;
        break;
    }

    return MathChallenge(
      operand1: op1,
      operand2: op2,
      operation: operation,
      answer: answer,
    );
  }

  /// 연산자 기호 반환
  String get operatorSymbol {
    return switch (operation) {
      MathOperation.add => '+',
      MathOperation.subtract => '-',
      MathOperation.multiply => '×',
    };
  }

  /// 문제 표현식 반환
  String get expression => '$operand1 $operatorSymbol $operand2 = ?';

  /// 정답 확인
  bool checkAnswer(int userAnswer) {
    return userAnswer == answer;
  }
}
