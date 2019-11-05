Class {
	#name : #BaselineOfGToolkit4Confluence,
	#superclass : #BaselineOf,
	#category : #BaselineOfGToolkit4Confluence
}

{ #category : #baseline }
BaselineOfGToolkit4Confluence >> baseline: spec [
	<baseline>
	spec for: #'common' do: [
		spec baseline: 'GToolkit' with: [
				spec repository: 'github://feenkcom/gtoolkit:v0.7.306/src' ].
		spec package: 'GToolkit4Confluence-API'. ].

]
