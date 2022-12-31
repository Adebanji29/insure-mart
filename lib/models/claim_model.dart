class Claim {
  final String id;
  final String status;
  final String assets;
  final String dateOfIncident;
  final String description;
  final String? policy;
  final String? repairAmount;
  final String? claimedAmount;
  final String? offerDetail;

  Claim({
    required this.id,
    required this.status,
    required this.assets,
    required this.dateOfIncident,
    required this.description,
    this.policy,
    this.repairAmount,
    this.claimedAmount,
    this.offerDetail,
  });
}
