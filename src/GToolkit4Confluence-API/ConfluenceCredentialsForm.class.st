Class {
	#name : #ConfluenceCredentialsForm,
	#superclass : #Object,
	#category : #'GToolkit4Confluence-API'
}

{ #category : #building }
ConfluenceCredentialsForm >> build [
	| confluenceDetails pageDetails url password username confluenceSpaceName confluencePageName |
	url := self buildInputWithLabel: 'URL:'.
	username := self buildInputWithLabel: 'Username:'.
	password := self buildInputWithLabel: 'Password:'.
	
	confluenceSpaceName := self buildInputWithLabel: 'Space name:'.
	confluencePageName := self buildInputWithLabel: 'Page name:'.

	confluenceDetails := BlElement new
		layout: (BlGridLayout horizontal columnCount: 2; cellSpacing: 10);
			constraintsDo: [ :c |
				c horizontal matchParent .
				c vertical fitContent ];
			addChildren: url;
			addChildren: username;
			addChildren: password.
	
	pageDetails := BlElement new
		layout: (BlGridLayout horizontal columnCount: 2; cellSpacing: 10);
			constraintsDo: [ :c |
				c horizontal matchParent .
				c vertical fitContent ];
			addChildren: confluenceSpaceName;
			addChildren: confluencePageName.
			
	^ BlElement new 
		constraintsDo: [:c | 
			c horizontal exact: 300. 
			c vertical fitContent. ];
		layout: BlLinearLayout vertical;
		padding: (BlInsets all: 10);
		addChild: confluenceDetails;
		addChild: self createHorizontalSeparatorElement;
		addChild: pageDetails;
		addChild: (
			BrButton new
				constraintsDo: [ :c |
					c linear horizontal alignRight ];
				margin: (BlInsets top: 10 right: 10 bottom: 0 left: 0);
				look: BrGlamorousButtonWithIconLook; 
				icon: BrGlamorousIcons save asElement;
				label: 'Save'; 
				action: [
					ConfluenceConnection setup
						url: (url at: 2) text asString;
						username: (username at: 2) text asString;
						password: (password at: 2) text asString.
		]).
]

{ #category : #building }
ConfluenceCredentialsForm >> buildInputWithLabel: aLabel [
	^ { 
			BrLabel new look: (BrGlamorousLabelLook new foreground: Color gray);
				padding: (BlInsets top: 0 right: 20 bottom: 2 left: 0);
				text: (aLabel asRopedText glamorousRegularFont readonly).
			BrEditor new 
				look: BrGlamorousInputFieldSpacingLook;
				constraintsDo: [ :c |
					c horizontal matchParent.
					c vertical fitContent ];
				margin: (BlInsets bottom: 1).
		}.
]

{ #category : #'building widgets' }
ConfluenceCredentialsForm >> createHorizontalSeparatorElement [
	^ BlElement new
		background: SoPolypolyColors mediumGray;
		margin: (BlInsets top: 5 bottom: 5);
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical exact: 1 ]
]
