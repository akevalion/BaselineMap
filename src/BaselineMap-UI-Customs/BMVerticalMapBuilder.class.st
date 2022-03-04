"
Similar to last one
"
Class {
	#name : #BMVerticalMapBuilder,
	#superclass : #BMThemedMapBuilder,
	#category : #'BaselineMap-UI-Customs'
}

{ #category : #hooks }
BMVerticalMapBuilder >> adjustWidth: aMaxNumber [
]

{ #category : #'accessing - defaults' }
BMVerticalMapBuilder >> cornerRadius [
	^ 1
]

{ #category : #'accessing - defaults' }
BMVerticalMapBuilder >> defaultContainer [
	^ RSCanvas new @ RSCanvasController simple
]

{ #category : #'instance creation' }
BMVerticalMapBuilder >> layoutOn: aCanvas [
	^ RSTreeLayout new
		horizontalGap: 5;
		verticalGap: 5;
		on: aCanvas nodes;
		yourself.
]

{ #category : #'instance creation' }
BMVerticalMapBuilder >> newLabelFor: aModel [
	^ (super newLabelFor: aModel)
		text: (aModel name copyFrom: 'BaselineOfx' size to: aModel name size);
		yourself
]

{ #category : #'instance creation' }
BMVerticalMapBuilder >> newLineBuilder [
	| theme |
	theme := Smalltalk ui theme.
	^ RSLineBuilder line
		color: Color transparent;
		yourself
]

{ #category : #hooks }
BMVerticalMapBuilder >> renderIn: aCanvas [
	super renderIn: aCanvas.
	self updateWithPreOrder: aCanvas.
]

{ #category : #hooks }
BMVerticalMapBuilder >> updateWidth: groupOfShapes layout: layout [
	groupOfShapes do: [ :shape | 
		| children |
		children := layout childrenFor: shape.
		children ifNotEmpty: [ 
			| width |
			self updateWidth: children layout: layout.
			width := children asGroup width.
			shape children first width: width.
			shape width: width ].
		 ]
]

{ #category : #hooks }
BMVerticalMapBuilder >> updateWithPreOrder: aCanvas [
	| layout |
	layout := self layoutOn: aCanvas nodes.
	self updateWidth: (layout rootNodesFor: aCanvas nodes) layout: layout.
]
