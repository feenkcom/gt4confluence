Extension { #name : #Class }

{ #category : #'*GToolkit4Confluence-API' }
Class >> gtExportToConfluenceFor: anAction [
	<gtAction>
	^(self hasClassVarNamed: #confluenceSpaceName) ifTrue: [  
		anAction dropdown 
			icon: BrGlamorousIcons tocloud asElement;
			label: nil;
			content: [ :b | ConfluenceCredentialsForm new buildForClass: self ];
			forViewDefinedIn: #gtDocumentFor:] 
		ifFalse: [ anAction ]
]
