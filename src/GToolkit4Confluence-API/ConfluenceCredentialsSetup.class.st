Class {
	#name : #ConfluenceCredentialsSetup,
	#superclass : #Object,
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #'GToolkit4Confluence-API'
}

{ #category : #accessing }
ConfluenceCredentialsSetup class >> uniqueInstance [
	uniqueInstance ifNil: [ uniqueInstance := ConfluenceCredentials new ].
     ^ uniqueInstance
]
