namespace app.signcloud;

using {
    Timezone,
    cuid,
    managed,
} from '@sap/cds/common';


 using { Attachments } from '@cap-js/attachments';

// Users of the system
entity Users: cuid, managed {
    key ID        : UUID         @title: 'User ID';
    UserId        : String(100);           // e.g., SSO ID / external IdP
    Email         : String(255);
    Name          : String(100);
    Role          : String(50);            // admin, signer, viewer etc.
    Active        : Boolean default true;
    Tenant        : Association to Tenants; // optional, for multi-tenant SaaS
}

entity DocumentSignees: cuid, managed {
    key ID        : UUID @title: 'DocumentSignee ID';
    document      : Association to Documents;
    signee        : Association to Users;
}

// Main document entity
entity Documents: cuid, managed {
    key ID            : UUID         @title: 'Document ID';
    Name              : String(255)  @title: 'Document Name';
    Description       : String(500);
    Category          : String;
    FileName          : String(255)  @title: 'Stored File Name';
    FileType          : String(20);        // PDF, DOCX, etc.
    Status            : String(20);        // draft, pending, signed, declined
    CreatedBy         : Association to Users;

    UpdatedAt         : Timestamp;
    BusinessContext   : String(100);       // e.g., "PurchaseOrder", "Contract"
    Signers           : Composition of many Signers on Signers.document = $self;
    AuditLogs         : Composition of many AuditLogs on AuditLogs.document = $self;
    Attachments       : Composition of many Attachments;
    Version           : Integer64; 
    ExpiryDate        : DateTime;
    Tags              : array of String;  
    Signees           : Composition of many DocumentSignees on Signees.document = $self;

}


// Signers assigned to a document
entity Signers: cuid, managed {
    key ID            : UUID         @title: 'Signer ID';
    document          : Association to Documents;
    Sequence          : Integer;           // order of signing
    Name              : String(100);
    Email             : String(255);
    Status            : String(20);        // pending, signed, declined
    SignedAt          : Timestamp;
    SignatureType     : String(20);        // drawn, typed, uploaded
    SignatureData     : LargeBinary;       // optional signature image / data
}

// Immutable audit log entries
entity AuditLogs: cuid, managed {
    key ID            : UUID         @title: 'Audit Log Entry ID';
    document          : Association to Documents;
    Action            : String(50);        // created, sent, signed, declined
    Actor             : String(100);       // name or email
    Timestamp         : Timestamp;
    Details           : String(500);       // text or JSON details
    Hash              : String(128);       // SHA256 hash of document state
}

// For multi-tenant SaaS (optional)
entity Tenants: cuid, managed {
    key ID            : UUID;
    Name              : String(100);
    SubscriptionDate  : Timestamp;
    Active            : Boolean default true;
    Users             : Composition of many Users on Users.Tenant = $self;
}

entity DocumentCategories {
  key Code : String(20);
      Name : String(50);
}

entity DocumentStatuses {
  key Code : String(20);
      Name : String(50);
}
