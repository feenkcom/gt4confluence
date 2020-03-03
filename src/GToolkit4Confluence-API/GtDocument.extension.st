Extension { #name : #GtDocument }

{ #category : #'*GToolkit4Confluence-API' }
GtDocument >> exportToConfluencePage: pageName inSpace: spaceName [
	| credentials confluence pageId anXdFile aDocument attachments confluenceFile result attachmentsForDocument  attachmentsDir |
	credentials := ConfluenceConnection setup.
	confluence := Gt4ConfluenceAPI  new 
		credentials: credentials.
	pageId := confluence findIdOfPageWithTitle: pageName inSpaceWithKey: spaceName.
	pageId ifNil: [ pageId := confluence createPageWithTitle: pageName withBody: '<p></p>' inSpaceWithKey: spaceName. ].
	
	anXdFile := XdWriter new
		streamingStrategy: XdStreamingStrategy bytes;
		document: self;
		documentConfluence: self;
		write.
		
	aDocument := anXdFile manifest documentOfType: XdConfluenceType.
	attachmentsForDocument := anXdFile manifest attachmentsForDocument: aDocument.
	
	confluenceFile := anXdFile streamingStrategy 
		detectFileReference: [ :eachFileReference | 
			eachFileReference basename = attachmentsForDocument first fileName ]
		ifFound: [ :aFileReference | aFileReference ] 
		ifNone: [ self error: 'File reference must be found' ].
	result := confluence updatePageWithId: pageId withContent: confluenceFile contents.
	
	attachmentsDir := (anXdFile streamingStrategy fileSystem / GtDocumentConstants exportedResultsDirectoryName).
	
	attachmentsDir exists ifTrue: [

		attachments := attachmentsDir children.
		confluence deleteAttachmentsForPageWithId: pageId.
		attachments do: [ :anAttachment |
			confluence uploadFileFrom: anAttachment forPageWithId: pageId
	 	].
	 ].
	
	result ifNil: [ self inform: 'Error exporting page' ] ifNotNil: [ self inform: 'Successfully exported page' ].
	
]
