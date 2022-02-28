"
baseline model for baseline maps
"
Class {
	#name : #BMBaselineModel,
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
BMBaselineModel >> = another [
	^ name = another name
]

{ #category : #accessing }
BMBaselineModel >> baselineClass [

	^ class
]

{ #category : #accessing }
BMBaselineModel >> baselineClass: aClass [
	class := aClass
]

{ #category : #accessing }
BMBaselineModel >> class1 [

	^ class
]

{ #category : #accessing }
BMBaselineModel >> dependencies [

	^ dependencies
]

{ #category : #accessing }
BMBaselineModel >> dependencies: anObject [

	dependencies := anObject
]

{ #category : #comparing }
BMBaselineModel >> hash [
	^ name hash
]

{ #category : #accessing }
BMBaselineModel >> level [

	^ level
]

{ #category : #accessing }
BMBaselineModel >> level: anObject [

	level := anObject
]

{ #category : #accessing }
BMBaselineModel >> name [

	^ name
]

{ #category : #accessing }
BMBaselineModel >> name: anObject [

	name := anObject
]

{ #category : #printing }
BMBaselineModel >> printOn: stream [
	stream << name
]
