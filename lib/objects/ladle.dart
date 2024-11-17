class Ladle {
  final String ladleNo;
  final String ladleStatus;
  final String plugType;
  final String standardLife;
  final String cumulativeHolding;
  final String currentLife;
  final String sb;
  final String ladleIn;
  final String sgp;
  final String ppLife;
  final String sgType;
  final String ppCumHolding;

  Ladle({
    required this.ladleNo,
    required this.ladleStatus,
    required this.plugType,
    required this.standardLife,
    required this.cumulativeHolding,
    required this.currentLife,
    required this.sb,
    required this.ladleIn,
    required this.sgp,
    required this.ppLife,
    required this.sgType,
    required this.ppCumHolding,
  });

  // Copy constructor
  Ladle copyWith({
    String? ladleNo,
    String? ladleStatus,
    String? plugType,
    String? standardLife,
    String? cumulativeHolding,
    String? currentLife,
    String? sb,
    String? ladleIn,
    String? sgp,
    String? ppLife,
    String? sgType,
    String? ppCumHolding,
  }) {
    return Ladle(
      ladleNo: ladleNo ?? this.ladleNo,
      ladleStatus: ladleStatus ?? this.ladleStatus,
      plugType: plugType ?? this.plugType,
      standardLife: standardLife ?? this.standardLife,
      cumulativeHolding: cumulativeHolding ?? this.cumulativeHolding,
      currentLife: currentLife ?? this.currentLife,
      sb: sb ?? this.sb,
      ladleIn: ladleIn ?? this.ladleIn,
      sgp: sgp ?? this.sgp,
      ppLife: ppLife ?? this.ppLife,
      sgType: sgType ?? this.sgType,
      ppCumHolding: ppCumHolding ?? this.ppCumHolding,
    );
  }

  // Convert Ladle object to Map
  Map<String, String> toMap() {
    return {
      'ladleNo': ladleNo,
      'ladleStatus': ladleStatus,
      'plugType': plugType,
      'standardLife': standardLife,
      'cumulativeHolding': cumulativeHolding,
      'currentLife': currentLife,
      'sb': sb,
      'ladleIn': ladleIn,
      'sgp': sgp,
      'ppLife': ppLife,
      'sgType': sgType,
      'ppCumHolding': ppCumHolding,
    };
  }

  @override
  String toString() {
    return 'Ladle { '
        'Ladle No: $ladleNo, '
        'Current Life: $currentLife, '
        'Cumulative Holding: $cumulativeHolding, '
        'Ladle Status: $ladleStatus, '
        'Standard Life: $standardLife, '
        'Plug Type: $plugType, '
        'SB: $sb, '
        'Ladle In: $ladleIn, '
        'SGP: $sgp, '
        'PP Life: $ppLife, '
        'SG Type: $sgType '
        '}';
  }
}