using app.signcloud.SignService as service from '../../srv/service';

annotate service.Documents with @(
    UI.FieldGroup #GeneratedGroup : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : Name,
            },
            {
                $Type : 'UI.DataField',
                Value : FileName,
            },
            {
                $Type : 'UI.DataField',
                Label : 'FileType',
                Value : FileType,
            },
            {
                $Type : 'UI.DataField',
                Label : 'Status',
                Value : Status,
            },
            {
                $Type : 'UI.DataField',
                Label : 'CreatedAt_code',
                Value : CreatedAt_code,
            },
            {
                $Type : 'UI.DataField',
                Label : 'UpdatedAt_code',
                Value : UpdatedAt_code,
            },
            {
                $Type : 'UI.DataField',
                Label : 'BusinessContext',
                Value : BusinessContext,
            },
        ],
    },
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'GeneratedFacet1',
            Label : 'General Information',
            Target : '@UI.FieldGroup#GeneratedGroup',
        },
    ],
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Value : Name,
        },
        {
            $Type : 'UI.DataField',
            Value : FileName,
        },
        {
            $Type : 'UI.DataField',
            Label : 'FileType',
            Value : FileType,
        },
        {
            $Type : 'UI.DataField',
            Label : 'Status',
            Value : Status,
        },
        {
            $Type : 'UI.DataField',
            Label : 'CreatedAt_code',
            Value : CreatedAt_code,
        },
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

