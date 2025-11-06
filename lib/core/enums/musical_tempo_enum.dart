enum MusicalTempo {
  gravissimo(label: 'Gravissimo'),
  grave(label: 'Grave'),
  larghissimo(label: 'Larghissimo'),
  largo(label: 'Largo'),
  larghetto(label: 'Larghetto'),
  adagio(label: 'Adagio'),
  adagietto(label: 'Adagietto'),
  andantino(label: 'Andantino'),
  marciaModerato(label: 'Marcia Moderato'),
  andante(label: 'Andante'),
  andanteModerato(label: 'Andante Moderato'),
  moderato(label: 'Moderato'),
  allegroModerato(label: 'Allegro Moderato'),
  allegroMaNonTroppo(label: 'Allegro ma non troppo'),
  allegro(label: 'Allegro'),
  vivace(label: 'Vivace'),
  vivacissimo(label: 'Vivacissimo'),
  alegricissimo(label: 'Alegricissimo'),
  presto(label: 'Presto'),
  prestissimo(label: 'Prestissimo');

  final String label;

  const MusicalTempo({required this.label});

  static MusicalTempo fromBpm(double currentBpm) {
    if (currentBpm <= 19) return gravissimo;
    if (currentBpm <= 39) return grave;
    if (currentBpm <= 44) return larghissimo;
    if (currentBpm <= 49) return largo;
    if (currentBpm <= 54) return larghetto;
    if (currentBpm <= 64) return adagio;
    if (currentBpm <= 74) return adagietto;
    if (currentBpm <= 83) return andantino;
    if (currentBpm <= 89) return andante;
    if (currentBpm <= 100) return andanteModerato;
    if (currentBpm <= 107) return moderato;
    if (currentBpm <= 115) return allegroModerato;
    if (currentBpm <= 119) return allegroMaNonTroppo;
    if (currentBpm <= 139) return allegro;
    if (currentBpm <= 159) return vivace;
    if (currentBpm <= 169) return vivacissimo;
    if (currentBpm <= 179) return alegricissimo;
    if (currentBpm <= 199) return presto;
    return prestissimo;
  }
}
