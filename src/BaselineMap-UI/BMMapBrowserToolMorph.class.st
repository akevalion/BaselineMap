"
This class creates bridge between my BMMapBuilder and calypso browser
"
Class {
	#name : #BMMapBrowserToolMorph,
	#superclass : #ClyBrowserToolMorph,
	#instVars : [
		'targetClass'
	],
	#category : #'BaselineMap-UI-BaselineMap-UI'
}

{ #category : #baselines }
BMMapBrowserToolMorph class >> baselineClassActivation [
	<classAnnotation>
	^ ClyTabActivationStrategyAnnotation for: ClyClass asCalypsoItemContext
]

{ #category : #testing }
BMMapBrowserToolMorph class >> shouldBeActivatedInContext: aBrowserContext [
	^ aBrowserContext isClassSelected 
		and: [ aBrowserContext lastSelectedClass inheritsFrom: BaselineOf ]
]

{ #category : #accessing }
BMMapBrowserToolMorph >> activationPriority [
	^ -300
]

{ #category : #building }
BMMapBrowserToolMorph >> build [
	| canvas morph |
	canvas := self buildBaselineMap.
	morph := canvas createMorph.
	morph onAnnouncement: MorphDeleted 
		do: [ self containerTab owner ifNotNil: [ self containerTab delete]].
	canvas when: RSMouseEnter do: [ morph takeKeyboardFocus].
	self addMorph: morph fullFrame: LayoutFrame identity
]

{ #category : #building }
BMMapBrowserToolMorph >> buildBaselineMap [
	^ BMMapBuilder new
		baseline: self targetClass;
		build;
		canvas.
]

{ #category : #initialization }
BMMapBrowserToolMorph >> defaultIconName [
	^ #objects
]

{ #category : #initialization }
BMMapBrowserToolMorph >> defaultTitle [
	^ 'Baseline browser'
]

{ #category : #testing }
BMMapBrowserToolMorph >> isSimilarTo: anotherBrowserTool [
	(super isSimilarTo: anotherBrowserTool) ifFalse: [ ^false ].
	^ self targetClass = anotherBrowserTool targetClass
]

{ #category : #initialization }
BMMapBrowserToolMorph >> setUpModelFromContext [
	self targetClass: context lastSelectedClass
]

{ #category : #accessing }
BMMapBrowserToolMorph >> targetClass [

	^ targetClass
]

{ #category : #accessing }
BMMapBrowserToolMorph >> targetClass: anObject [

	targetClass := anObject
]
