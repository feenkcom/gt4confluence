Extension { #name : #Class }

{ #category : #'*GToolkit4Confluence-API' }
Class >> gtExportToConfluenceFor: anAction [
	<gtAction>
	(self allClassVarNames includes: #confluencePageName) ifFalse: [ ^ anAction noAction ].
	^ anAction dropdown 
		icon: BrGlamorousIcons tocloud asElement;
		label: nil;
		content: [ :b | ConfluenceCredentialsForm new buildForClass: self ];
		forViewDefinedIn: #gtDocumentFor:
]
