Class {
	#name : #ConfluenceCredentials,
	#superclass : #Object,
	#instVars : [
		'url',
		'username',
		'password'
	],
	#category : #'GToolkit4Confluence-API'
}

{ #category : #accessing }
ConfluenceCredentials >> password [
	^ password
]

{ #category : #accessing }
ConfluenceCredentials >> password: anObject [
	password := anObject
]

{ #category : #initialization }
ConfluenceCredentials >> takePasswordFromClipboard [
	self password: Clipboard clipboardText asString
]

{ #category : #accessing }
ConfluenceCredentials >> url [
	^ url
]

{ #category : #accessing }
ConfluenceCredentials >> url: anObject [
	url := anObject
]

{ #category : #accessing }
ConfluenceCredentials >> username [
	^ username
]

{ #category : #accessing }
ConfluenceCredentials >> username: anObject [
	username := anObject
]
