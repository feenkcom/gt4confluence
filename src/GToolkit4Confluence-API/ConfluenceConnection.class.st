Class {
	#name : #ConfluenceConnection,
	#superclass : #Object,
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #'GToolkit4Confluence-API'
}

{ #category : #accessing }
ConfluenceConnection class >> isSetup [
	uniqueInstance isNotNil.
]

{ #category : #accessing }
ConfluenceConnection class >> setup [
	uniqueInstance ifNil: [ uniqueInstance := ConfluenceCredentials new ].
     ^ uniqueInstance
]
