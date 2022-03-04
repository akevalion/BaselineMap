"
Used to have custom colors and  with theme
"
Class {
	#name : #BMThemedMapBuilder,
	#superclass : #BMMapBuilder,
	#category : #'BaselineMap-UI-Customs'
}

{ #category : #'accessing - defaults' }
BMThemedMapBuilder >> defaultContainer [
	| theme |
	theme := self theme.
	^ RSCanvas new 
		color: theme backgroundColor;
		addInteraction: (RSCanvasController new
			noLegend;
			yourself);
		yourself
]

{ #category : #'accessing - defaults' }
BMThemedMapBuilder >> marker [
	| theme marker |
	theme := self theme.
	marker := RSShapeFactory arrow.
	marker color: theme textColor.
	marker size: 10.
	marker := marker asMarker.
	marker offset: 5.
	^ marker
]

{ #category : #'instance creation' }
BMThemedMapBuilder >> newBorderFor: aModel [
	aModel baselineClass ifNotNil: [ ^ nil ].
	^ RSBorder new 
		color: self theme textColor;
		width: 2;
		dashArray: #(4);
		yourself.
]

{ #category : #'instance creation' }
BMThemedMapBuilder >> newBox [
	^ super newBox
		color: self theme selectionColor;
		yourself
]

{ #category : #'instance creation' }
BMThemedMapBuilder >> newLabelFor: anObject [
	^ (super newLabelFor: anObject)
		color: self theme textColor;
		yourself
]

{ #category : #'instance creation' }
BMThemedMapBuilder >> newLineBuilder [
	^ RSLineBuilder bezier
		markerEnd: self marker;
		withBorderAttachPoint;
		controlPointsController: (RSShortestHorizontalCPController new);
		color: self theme textColor;
		yourself
]

{ #category : #'accessing - defaults' }
BMThemedMapBuilder >> theme [
	^ Smalltalk ui theme
]
