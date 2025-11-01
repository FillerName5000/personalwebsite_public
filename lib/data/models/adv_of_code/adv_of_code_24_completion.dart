enum AdvOfCode24CompletionStatus { fullyCompleted, onHold, notCompleted }

class AdvOfCode24Completion {
  AdvOfCode24Completion({
    required this.entryIndex,
    required this.partOneCompletionStatus,
    required this.partTwoCompletionStatus,
    required this.partOneFilename,
    required this.partTwoFilename,
  });

  /// Throws [FormatException] for invalid JSON.
  factory AdvOfCode24Completion.fromJson(Map<String, dynamic> json) {
    final dynamic entryIndexRaw = json['entryIndex'];
    int entryIndex;
    if (entryIndexRaw is int) {
      entryIndex = entryIndexRaw;
    } else if (entryIndexRaw is num && entryIndexRaw == entryIndexRaw.toInt()) {
      entryIndex = entryIndexRaw.toInt();
    } else {
      throw const FormatException('Invalid or missing entryIndex');
    }

    final AdvOfCode24CompletionStatus partOneCompletionStatus = _parseStatus(
      json['partOneCompletionStatus'],
    );
    final AdvOfCode24CompletionStatus partTwoCompletionStatus = _parseStatus(
      json['partTwoCompletionStatus'],
    );
    final dynamic partOneFilename = json['partOneFilename'];
    final dynamic partTwoFilename = json['partTwoFilename'];
    if (partOneFilename is! String) {
      throw const FormatException('Invalid or missing partOneFilename');
    }
    if (partTwoFilename is! String) {
      throw const FormatException('Invalid or missing partTwoFilename');
    }
    return AdvOfCode24Completion(
      entryIndex: entryIndex,
      partOneCompletionStatus: partOneCompletionStatus,
      partTwoCompletionStatus: partTwoCompletionStatus,
      partOneFilename: partOneFilename,
      partTwoFilename: partTwoFilename,
    );
  }

  final int entryIndex;
  final AdvOfCode24CompletionStatus partOneCompletionStatus;
  final AdvOfCode24CompletionStatus partTwoCompletionStatus;
  final String partOneFilename;
  final String partTwoFilename;
}

AdvOfCode24CompletionStatus _parseStatus(dynamic v) {
  if (v is String) {
    switch (v) {
      case 'fullyCompleted':
        return AdvOfCode24CompletionStatus.fullyCompleted;
      case 'onHold':
        return AdvOfCode24CompletionStatus.onHold;
      case 'notCompleted':
        return AdvOfCode24CompletionStatus.notCompleted;
    }
  }
  throw const FormatException('Invalid or missing completion status');
}
