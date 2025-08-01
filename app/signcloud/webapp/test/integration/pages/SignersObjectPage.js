sap.ui.define(['sap/fe/test/ObjectPage'], function(ObjectPage) {
    'use strict';

    var CustomPageDefinitions = {
        actions: {},
        assertions: {}
    };

    return new ObjectPage(
        {
            appId: 'com.sap.apps.signcloud',
            componentId: 'SignersObjectPage',
            contextPath: '/Documents/Signers'
        },
        CustomPageDefinitions
    );
});