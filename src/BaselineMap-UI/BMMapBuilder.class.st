"
I am a builder that can be used to generate dependencies between baselines
"
Class {
	#name : #BMMapBuilder,
	#superclass : #RSAbstractContainerBuilder,
	#instVars : [
		'models',
		'baseline'
	],
	#category : #'BaselineMap-UI-BaselineMap-UI'
}

{ #category : #hooks }
BMMapBuilder >> adjustWidth: aMaxNumber [
	shapes do: [ :shape | 
		shape children first width: aMaxNumber.
		shape adjustToChildren ].
]

{ #category : #accessing }
BMMapBuilder >> baseline [
	^ baseline
]

{ #category : #accessing }
BMMapBuilder >> baseline: aBaselineClass [
	baseline := aBaselineClass.
	self computeModels.
]

{ #category : #'hooks - model' }
BMMapBuilder >> computeModels [
	| todo rootModel |
	models := OrderedCollection new.
	rootModel := self newModelFor: baseline.
	rootModel level: 1.
	todo := LinkedList with: rootModel.
	self findModels: todo.
	
]

{ #category : #'accessing - defaults' }
BMMapBuilder >> cornerRadius [
	^ 10
]

{ #category : #'accessing - defaults' }
BMMapBuilder >> defaultContainer [
	^ RSCanvas new @ RSCanvasController
]

{ #category : #'hooks - model' }
BMMapBuilder >> dependenciesFrom: aBMBaselineModel [
	^ aBMBaselineModel baselineClass version projects
		collect: #constructClassName
		thenSelect: #notNil
]

{ #category : #'hooks - model' }
BMMapBuilder >> findDependencies: aBMBaselineModel todoList: todoList [
	| dependencies newModels |
	[ 
		dependencies := self dependenciesFrom: aBMBaselineModel.
		newModels := dependencies collect: [ :each | 
			self newModelFromDependency: each level: aBMBaselineModel level ].
		todoList addAll: newModels.
	] onErrorDo: [ :ex | dependencies := #() ].
	^ dependencies
]

{ #category : #'hooks - model' }
BMMapBuilder >> findModels: todoList [
	| model |
	todoList ifEmpty: [ ^ self ].
	model := todoList removeFirst.
	
	(models includes: model) ifFalse: [ 
		models add: model.
		model dependencies: (self findDependencies: model todoList: todoList).
	].
	self findModels: todoList.
	
	
]

{ #category : #accessing }
BMMapBuilder >> groupsOfBaselines [
	^ models groupedBy: [ :model | model level ]
]

{ #category : #hooks }
BMMapBuilder >> layoutOn: aCanvas [
	RSHorizontalTreeLayout new
		horizontalGap: 50;
		verticalGap: 5;
		on: aCanvas nodes.
]

{ #category : #accessing }
BMMapBuilder >> models [
	^ models
]

{ #category : #'instance creation' }
BMMapBuilder >> newBorderFor: anObject [
	^ nil
]

{ #category : #'instance creation' }
BMMapBuilder >> newBox [
	^ RSBox new
		yourself.
]

{ #category : #'instance creation' }
BMMapBuilder >> newLabelFor: model [
	^ RSLabel new
		text: model name;
		color: Color black;
		yourself.
]

{ #category : #'instance creation' }
BMMapBuilder >> newLineBuilder [
	^ RSLineBuilder arrowedLine
		withBorderAttachPoint;
		color: Color black;
		yourself
]

{ #category : #'instance creation' }
BMMapBuilder >> newModel [
	^ BMBaselineModel new
]

{ #category : #'instance creation' }
BMMapBuilder >> newModelFor: anObject [
	^ self newModel
		name: anObject name;
		baselineClass: anObject;
		yourself
]

{ #category : #'hooks - model' }
BMMapBuilder >> newModelFromDependency: aString level: level [
	| class |
	class := Smalltalk globals at: aString asSymbol
		ifPresent: [ :cls | cls ]
		ifAbsent: [ nil ].
	
	^ self newModel
		name: aString;
		baselineClass: class;
		level: level + 1;
		yourself
]

{ #category : #'instance creation' }
BMMapBuilder >> newShapeFor: model [
	| label box |
	label := self newLabelFor: model.
	box := self newBox
		extent: label extent + 10;
		border: (self newBorderFor: model);
		cornerRadius: self cornerRadius;
		yourself.
	^ ({ box. label } asShapeFor: model) 
		draggable;
		yourself.
		
]

{ #category : #hooks }
BMMapBuilder >> renderIn: aCanvas [
	| modelsByGroup |
	models ifNil: [ ^ self ].
	modelsByGroup := self groupsOfBaselines.
	modelsByGroup keysAndValuesDo: [ :level :layerGroup | 
		self renderLayer: layerGroup level: level in: aCanvas ].
	self renderLinesOn: aCanvas.
	self layoutOn: aCanvas
]

{ #category : #hooks }
BMMapBuilder >> renderLayer: layerGroup level: key in: aCanvas [
	| max |
	max := 0.
	shapes := layerGroup collect: [ :model | | shape |
		shape := self newShapeFor: model.
		max := max max: shape width.
		shape ] as: RSGroup.
	self adjustWidth: max.
	aCanvas addAll: shapes.
]

{ #category : #hooks }
BMMapBuilder >> renderLinesOn: aCanvas [
	self newLineBuilder
		canvas: aCanvas;
		connectToAll: [ :model |
			model dependencies collect: [ :depName |
				models detect: [ :each | each name = depName ]
				 ] ].
	aCanvas lines pushBack.
]
