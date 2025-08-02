namespace app.signcloud;

using {
  app.signcloud as signcloud
} from '../db/model';

annotate signcloud.Users with @odata.draft.enabled : true;
annotate signcloud.Documents with @odata.draft.enabled : true;


service SignService {

  // Expose main entities as OData entity sets
  entity Users as projection on signcloud.Users;
  entity Documents as projection on signcloud.Documents;
  entity Signers as projection on signcloud.Signers;
  entity AuditLogs as projection on signcloud.AuditLogs;
  entity Tenants as projection on signcloud.Tenants;
  entity DocumentCategories as projection on signcloud.DocumentCategories;
  entity DocumentStatuses as projection on signcloud.DocumentStatuses;

  /**
   * Custom action: Send a document for signature.
   * E.g., changes document status to 'pending', triggers emails.
   */
  action SendForSignature(documentID: UUID) returns String;

  /**
   * Custom action: Sign a document as a specific signer.
   * Could include signature type and data (drawn, typed, etc.).
   */
  action SignDocument(
    signerID    : UUID,
    signatureType: String,
    signatureData: LargeBinary
  ) returns String;

  /**
   * Function: Get audit trail entries for a document.
   */
  function GetAuditTrail(documentID: UUID) returns array of AuditLogs;

  /**
   * Action: Cancel a document before signing is complete.
   */
  action CancelDocument(documentID: UUID, reason: String) returns String;

  action AddSignature();
}
