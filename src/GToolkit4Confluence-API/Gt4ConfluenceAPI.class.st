Class {
	#name : #Gt4ConfluenceAPI,
	#superclass : #Object,
	#instVars : [
		'credentials'
	],
	#category : #'GToolkit4Confluence-API'
}

{ #category : #creating }
Gt4ConfluenceAPI >> createPageWithTitle: aTitle withBody: aBody inSpaceWithKey: aSpaceKey [
	"creates a Confluence page with specified content"

	^ ZnClient new
		url: (credentials url asZnUrl addPathSegments: #(rest api content) yourself);
		username: credentials username password: credentials password;
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

{ #category : #accessing }
Gt4ConfluenceAPI >> credentials [
	^ credentials
]

{ #category : #accessing }
Gt4ConfluenceAPI >> credentials: anObject [
	credentials := anObject
]

{ #category : #find }
Gt4ConfluenceAPI >> findPageWithTitle: title inSpaceWithContentID: contentID [
	| pathSegments response results |

	pathSegments := {
	'rest'.
	'api'.
	'content'}.

	response :=  ZnClient new
		url: (
			credentials url asZnUrl 
			addPathSegments: pathSegments; 
			queryAt: 'title' put: title;
			queryAt: 'spaceKey' put: contentID;
			queryAt: 'expand' put: 'body.storage';
			yourself);
		username: credentials username password: credentials password;
		headerAt: 'X-Atlassian-Token' put: 'nocheck';
		get;
		response.
		
	response isSuccess ifFalse: [ ^ nil ].
	
	results := ((STONJSON fromString: response contents) at: #results).
	
	results isEmpty ifTrue: [ ^ nil ].
		
	^ (((results at: 1) at: #body) at: #storage) at: #value.
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
		url: (credentials url asZnUrl addPathSegments: pathSegments yourself);
		username: credentials username password: credentials password;
		headerAt: 'X-Atlassian-Token' put: 'nocheck';
		addPart: (ZnMimePart fieldName: #file fileNamed: filePath);
		post;
		response
]
