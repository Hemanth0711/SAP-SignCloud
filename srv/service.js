const cds = require('@sap/cds');

module.exports = async (srv) => {

  /**
   * Action: SendForSignature
   * Set document status to 'pending', add audit log, and (optionally) notify signers.
   */

  srv.on('SendForSignature', async (req) => {
    const { documentID } = req.data;

    // Update document status
    await UPDATE('app.signcloud.Documents')
      .set({ Status: 'pending' })
      .where({ ID: documentID });

    // Add audit log entry
    await INSERT.into('app.signcloud.AuditLogs').entries({
      document_ID: documentID,
      Action: 'sent',
      Actor: req.user.id || 'system',
      Timestamp: new Date().toISOString(),
      Details: 'Document sent for signature'
    });

    // TODO: Send notification to signers if needed

    return 'Document sent for signature successfully';
  });


  /**
   * Action: SignDocument
   * Mark signer as signed, store signature info, add audit log.
   */
  srv.on('SignDocument', async (req) => {
    const { signerID, signatureType, signatureData } = req.data;

    // Update signer status
    await UPDATE('app.signcloud.Signers')
      .set({
        Status: 'signed',
        SignedAt: new Date().toISOString(),
        SignatureType: signatureType,
        SignatureData: signatureData
      })
      .where({ ID: signerID });

    // Get related document ID
    const { document_ID } = await SELECT.one`document_ID`.from`app.signcloud.Signers`.where`ID = ${signerID}`;

    // Add audit log
    await INSERT.into('app.signcloud.AuditLogs').entries({
      document_ID,
      Action: 'signed',
      Actor: req.user.id || 'system',
      Timestamp: new Date().toISOString(),
      Details: `Signer ${signerID} signed the document`
    });

    // TODO: Optionally check if all signers signed, then mark document as 'signed'

    return 'Document signed successfully';
  });


  /**
   * Function: GetAuditTrail
   * Return ordered list of audit logs for a document.
   */
  srv.on('GetAuditTrail', async (req) => {
    const { documentID } = req.data;

    const logs = await SELECT
      .from('app.signcloud.AuditLogs')
      .where({ document_ID: documentID })
      .orderBy('Timestamp desc');

    return logs;
  });


  /**
   * Action: CancelDocument
   * Mark document as 'cancelled' and add audit log.
   */
  srv.on('CancelDocument', async (req) => {
    const { documentID, reason } = req.data;

    await UPDATE('app.signcloud.Documents')
      .set({ Status: 'cancelled' })
      .where({ ID: documentID });

    await INSERT.into('app.signcloud.AuditLogs').entries({
      document_ID: documentID,
      Action: 'cancelled',
      Actor: req.user.id || 'system',
      Timestamp: new Date().toISOString(),
      Details: reason || 'Cancelled by user'
    });

    return 'Document cancelled successfully';
  });

};
