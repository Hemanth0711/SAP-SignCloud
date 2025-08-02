using app.signcloud.SignService as service from '../../srv/service';

annotate service.Documents with {
    Signee @Common.ValueList : {
        $Type : 'Common.ValueListType',
        CollectionPath : 'Users',
        Parameters : [
            {
                $Type: 'Common.ValueListParameterInOut',
                LocalDataProperty: Signee,
                ValueListProperty: 'Email'
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'Name'
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'UserId'
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'Role'
            },
        ]
    };
};


annotate service.Documents with {

    Category @Common.ValueList: {
        $Type: 'Common.ValueListType',
        CollectionPath: 'DocumentCategories',
        Parameters: [
            {
                $Type: 'Common.ValueListParameterInOut',
                LocalDataProperty: Category,
                ValueListProperty: 'Code'
            },
            {
                $Type: 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'Name'
            }
        ]
    };

    Status @Common.ValueList: {
        $Type: 'Common.ValueListType',
        CollectionPath: 'DocumentStatuses',
        Parameters: [
            {
                $Type: 'Common.ValueListParameterInOut',
                LocalDataProperty: Status,
                ValueListProperty: 'Code'
            },
            {
                $Type: 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'Name'
            }
        ]
    };
};


annotate service.Documents with @(
    UI.FieldGroup #AddSignatureGroup : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataFieldForAction',
                Label : 'Add Signature',
                Action : 'app.signcloud.SignService.EntityContainer/AddSignature'
            }
        ]
    },
    UI.FieldGroup #GeneratedGroup : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Label: 'Title',
                Value : Name,
            },
            {
                $Type : 'UI.DataField',
                Label : 'Description',
                Value : Description,
            },
            {
                $Type : 'UI.DataField',
                Label : 'Category',
                Value : Category,
            },
            {
                $Type : 'UI.DataField',
                Label : 'Status',
                Value : Status,
            },
            {
                $Type : 'UI.DataField',
                Label : 'CreatedBy',
                Value : createdBy,
            },
            {
                $Type : 'UI.DataField',
                Label : 'Updated At',
                Value : UpdatedAt,
            },
            {
                $Type : 'UI.DataField',
                Label : 'Business Context',
                Value : BusinessContext,
            },
            {
                $Type : 'UI.DataField',
                Label : 'Signee',
                Value : Signee,
            }

            
        ],
    },
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'GeneratedFacet1',
            Label : 'General Information',
            Target : '@UI.FieldGroup#GeneratedGroup',
        },
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'AddSignatureAction',
            Label : 'Add Signature',
            Target : '@UI.FieldGroup#AddSignatureGroup'
        }
    ],
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Label: 'Title',
            Value : Name,
        },
        {
            $Type : 'UI.DataField',
            Value : Description,
        },
        {
            $Type : 'UI.DataField',
            Label : 'Expiry Date',
            Value : ExpiryDate,
        },
        {
            $Type : 'UI.DataField',
            Label : 'Status',
            Value : Status,
        },
        {
            $Type : 'UI.DataField',
            Label : 'Updated At',
            Value : UpdatedAt,
        }
    ],
);

annotate service.Documents with {
    CreatedBy @Common.ValueList : {
        $Type : 'Common.ValueListType',
        CollectionPath : 'Users',
        Parameters : [
            {
                $Type : 'Common.ValueListParameterInOut',
                LocalDataProperty : CreatedBy_ID,
                ValueListProperty : 'ID',
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'UserId',
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'Email',
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'Name',
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'Role',
            },
        ],
    }
};

annotate service.Signers with @(
    UI.LineItem : [
    { $Type : 'UI.DataField', Value : Name, Label : 'Name' },
    { $Type : 'UI.DataField', Value : Email, Label : 'Email' },
    { $Type : 'UI.DataField', Value : Sequence, Label : 'Order' },
    { $Type : 'UI.DataField', Value : Status, Label : 'Status' }
  ]
);





