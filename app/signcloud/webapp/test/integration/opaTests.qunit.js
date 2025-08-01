sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'com/sap/apps/signcloud/test/integration/FirstJourney',
		'com/sap/apps/signcloud/test/integration/pages/DocumentsList',
		'com/sap/apps/signcloud/test/integration/pages/DocumentsObjectPage',
		'com/sap/apps/signcloud/test/integration/pages/SignersObjectPage'
    ],
    function(JourneyRunner, opaJourney, DocumentsList, DocumentsObjectPage, SignersObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('com/sap/apps/signcloud') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onTheDocumentsList: DocumentsList,
					onTheDocumentsObjectPage: DocumentsObjectPage,
					onTheSignersObjectPage: SignersObjectPage
                }
            },
            opaJourney.run
        );
    }
);