Class {
	#name : #Gt4ConfluenceAPI,
	#superclass : #Object,
	#instVars : [
		'url',
		'username',
		'password'
	],
	#category : #'GToolkit4Confluence-API'
}

{ #category : #creating }
Gt4ConfluenceAPI >> createPageWithTitle: aTitle withBody: aBody inSpaceWithKey: aSpaceKey [
	"creates a Confluence page with specified content"

	^ ZnClient new
		url: (url asZnUrl addPathSegments: #(rest api content) yourself);
		username: username password: password;
		accept: ZnMimeType applicationJson;
		entity:
			(ZnEntity
				with:
					(STONJSON
						toString:
							{('type' -> 'page').
							('title' -> aTitle).
							('space' -> {('key' -> aSpaceKey)} asDictionary).
							('body'
								->
									{('storage'
										->
											{('value' -> aBody).
											('representation' -> 'storage')} asDictionary)} asDictionary)} asDictionary)
				type: ZnMimeType applicationJson);
		post;
			response
]

{ #category : #find }
Gt4ConfluenceAPI >> findDocumentationForClass: aClass inSpaceWithContentID: contentID [
	| pathSegments |

	pathSegments := {
	'rest'.
	'api'.
	'content'}.

	^ ZnClient new
		url: (
			url asZnUrl 
			addPathSegments: pathSegments; 
			queryAt: 'title' put: aClass name;
			queryAt: 'spaceKey' put: contentID;
			queryAt: 'expand' put: 'body.storage';
			yourself);
		username: username password: password;
		headerAt: 'X-Atlassian-Token' put: 'nocheck';
		get;
		response.
]

{ #category : #accessing }
Gt4ConfluenceAPI >> password [
	^ password
]

{ #category : #accessing }
Gt4ConfluenceAPI >> password: anObject [
	password := anObject
]

{ #category : #creating }
Gt4ConfluenceAPI >> uploadFileFrom: filePath inSpaceWithContentID: contentID [
	| pathSegments |

	pathSegments := {
	'rest'.
	'api'.
	'content'.
	contentID.
	'child'.
	'attachment'}.

	^ ZnClient new
		url: (url asZnUrl addPathSegments: pathSegments yourself);
		username: username password: password;
		headerAt: 'X-Atlassian-Token' put: 'nocheck';
		addPart: (ZnMimePart fieldName: #file fileNamed: filePath);
		post;
		response
]

{ #category : #accessing }
Gt4ConfluenceAPI >> url [
	^ url
]

{ #category : #accessing }
Gt4ConfluenceAPI >> url: anObject [
	url := anObject
]

{ #category : #accessing }
Gt4ConfluenceAPI >> username [
	^ username
]

{ #category : #accessing }
Gt4ConfluenceAPI >> username: anObject [
	username := anObject
]
