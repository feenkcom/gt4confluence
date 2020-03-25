Extension { #name : #GtDocument }

{ #category : #'*GToolkit4Confluence-API' }
GtDocument >> exportToConfluencePage: pageName inSpace: spaceName [
	| fileName credentials confluence pageId anXdFile aDocument attachments confluenceFile result attachmentsForDocument  attachmentsDir |
	credentials := ConfluenceConnection setup.
	confluence := Gt4ConfluenceAPI  new 
		credentials: credentials.
	pageId := confluence findIdOfPageWithTitle: pageName inSpaceWithKey: spaceName.
	pageId ifNil: [ pageId := confluence createPageWithTitle: pageName withBody: '<p></p>' inSpaceWithKey: spaceName. ].
	
	fileName := FileSystem memory workingDirectory / pageName, 'xdoc'.
	
	self flag: 'XDoc API proposeal [feenkcom/gtoolkit#888]'.
	"anXdFile := XdFile writer
		onFileReference: fileName;
		document: self;
		documentConfluence: self;
		write.
		
	aContent := anXdFile navigator
		documentOfType: XdConfluenceType;
		mainAttachment;
		string.
	result := confluence updatePageWithId: pageId withContent: confluenceFile contents.

	theAttachmentAccessors := anXdFile navigator
		documentOfType: XdConfluenceType;
		attachments;
		eachAsDataAccessor;
		eachAs: [ :eachAttachment | anXdFile navigator startAt: eachAttachment ];
		find.
	
	confluence deleteAttachmentsForPageWithId: pageId.
	theAttachmentAccessors do: [ :eachDataAccessor |
		confluence 
			uploadStream: eachDataAccessor fileName 
			mimeType: eachDataAccessor mimeType
			length: eachDataAccessor fileSize
			forPageWithId: pageId
		 ].
	"

	anXdFile := XdWriter new
		streamingStrategy: (XdStreamingStrategy file: fileName);
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
	
	confluence uploadFileFrom: fileName withLabel: 'xdoc' forPageWithId: pageId.
	
	result ifNil: [ self inform: 'Error exporting page' ] ifNotNil: [ self inform: 'Successfully exported page' ].
	
]
