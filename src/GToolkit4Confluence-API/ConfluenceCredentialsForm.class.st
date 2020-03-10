Class {
	#name : #ConfluenceCredentialsForm,
	#superclass : #Object,
	#category : #'GToolkit4Confluence-API'
}

{ #category : #building }
ConfluenceCredentialsForm >> buildForClass: aClass [
	| aDocument confluenceDetails url password username confluenceSpaceName confluencePageName |
	url := self buildInputWithLabel: 'URL:' andInitialValue: ConfluenceConnection setup url.
	username := self buildInputWithLabel: 'Username:' andInitialValue: ConfluenceConnection setup username.
	password := self buildInputWithLabel: 'Password:' andInitialValue: ConfluenceConnection setup password.
	
	confluenceSpaceName := self buildInputWithLabel: 'Space name:' andInitialValue: (aClass classVarNamed: #confluenceSpaceName).
	confluencePageName := self buildInputWithLabel: 'Page name:' andInitialValue: (aClass classVarNamed: #confluencePageName).

	confluenceDetails := BlElement new
		layout: (BlGridLayout horizontal columnCount: 2; cellSpacing: 0);
			constraintsDo: [ :c |
				c horizontal matchParent .
				c vertical fitContent ];
			addChildren: url;
			addChildren: username;
			addChildren: password;
			addChildren: self createHorizontalSeparator;
			addChildren: confluenceSpaceName;
			addChildren: confluencePageName.
			
	^ BlElement new 
		constraintsDo: [:c | 
			c horizontal exact: 300. 
			c vertical fitContent. ];
		layout: BlLinearLayout vertical;
		padding: (BlInsets all: 10);
		addChild: confluenceDetails;
		addChild: (
			BrButton new
				constraintsDo: [ :c |
					c linear horizontal alignRight ];
				margin: (BlInsets top: 10 right: 10 bottom: 0 left: 0);
				look: BrGlamorousButtonWithLabelLook;
				label: 'Export'; 
				action: [
					ConfluenceConnection setup
						url: (self textInInput: url);
						username: (self textInInput: username);
						password: (self textInInput: password).
					self saveConfluenceSpaceName: (self textInInput: confluenceSpaceName) 
						andPageName: (self textInInput: confluencePageName) forClass: aClass.

					aDocument := GtDocument forClass: aClass.
					aDocument exportToConfluencePage: (self textInInput: confluencePageName) inSpace: (self textInInput: confluenceSpaceName).
		]).
]

{ #category : #building }
ConfluenceCredentialsForm >> buildInputWithLabel: aLabel andInitialValue: aTextValue [ 
	^ { 
			BrLabel new look: (BrGlamorousLabelLook new foreground: Color gray);
				padding: (BlInsets top: 0 right: 20 bottom: 10 left: 0);
				text: (aLabel asRopedText glamorousRegularFont readonly).
			BrEditor new 
				look: BrGlamorousRegularEditorLook + BrGlamorousInputFieldSpacingLook;
				constraintsDo: [ :c |
					c horizontal matchParent.
					c vertical fitContent ];
				margin: (BlInsets bottom: 1);
				text: aTextValue asRopedText.
		}.
]

{ #category : #'building widgets' }
ConfluenceCredentialsForm >> createHorizontalSeparator [
	^ { self createHorizontalSeparatorElement. self createHorizontalSeparatorElement }.
]

{ #category : #'building widgets' }
ConfluenceCredentialsForm >> createHorizontalSeparatorElement [
	^ BlElement new
		background: Color gray;
		margin: (BlInsets top: 5 bottom: 5);
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical exact: 1 ]
]

{ #category : #saving }
ConfluenceCredentialsForm >> saveConfluenceSpaceName: aSpaceName andPageName: aPageName forClass: aClass [
	aClass classVarNamed: #confluenceSpaceName put: aSpaceName.
	aClass classVarNamed: #confluencePageName put: aPageName.
]

{ #category : #accesing }
ConfluenceCredentialsForm >> textInInput: anInput [
	^ (anInput at: 2) editor text asString. 
]
