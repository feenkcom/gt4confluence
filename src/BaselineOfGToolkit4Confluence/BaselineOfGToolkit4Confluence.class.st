Class {
	#name : #BaselineOfGToolkit4Confluence,
	#superclass : #BaselineOf,
	#category : #BaselineOfGToolkit4Confluence
}

{ #category : #baselines }
BaselineOfGToolkit4Confluence >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [
			spec baseline: 'BaselineOfGToolkit4Confluence' with: [ spec repository: 'github://feenkcom/gt4confluence/src' ].
			spec package: 'BaselineOfGToolkit4Confluence'. ]
]
