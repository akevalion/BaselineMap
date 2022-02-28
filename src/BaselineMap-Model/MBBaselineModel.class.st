"
baseline model for baseline maps
"
Class {
	#name : #MBBaselineModel,
	#superclass : #Object,
	#instVars : [
		'class',
		'name',
		'level',
		'dependencies'
	],
	#category : #'BaselineMap-Model'
}

{ #category : #comparing }
MBBaselineModel >> = another [
	^ name = another name
]

{ #category : #accessing }
MBBaselineModel >> baselineClass [

	^ class
]

{ #category : #accessing }
MBBaselineModel >> baselineClass: aClass [
	class := aClass
]

{ #category : #accessing }
MBBaselineModel >> class1 [

	^ class
]

{ #category : #accessing }
MBBaselineModel >> dependencies [

	^ dependencies
]

{ #category : #accessing }
MBBaselineModel >> dependencies: anObject [

	dependencies := anObject
]

{ #category : #comparing }
MBBaselineModel >> hash [
	^ name hash
]

{ #category : #accessing }
MBBaselineModel >> level [

	^ level
]

{ #category : #accessing }
MBBaselineModel >> level: anObject [

	level := anObject
]

{ #category : #accessing }
MBBaselineModel >> name [

	^ name
]

{ #category : #accessing }
MBBaselineModel >> name: anObject [

	name := anObject
]
