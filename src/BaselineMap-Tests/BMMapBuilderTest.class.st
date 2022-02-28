"
A BMMapBuilderTest is a test class for testing the behavior of BMMapBuilder
"
Class {
	#name : #BMMapBuilderTest,
	#superclass : #TestCase,
	#category : #'BaselineMap-Tests'
}

{ #category : #tests }
BMMapBuilderTest >> testAttributes [
	| map |
	map := BMMapBuilder new.
	map baseline: BaselineOfMorphic.
	self assert: map models isCollection.
	self assert: map models size > 1
	
]

{ #category : #tests }
BMMapBuilderTest >> testBasic [
	BMMapBuilder new
		baseline: BaselineOfMorphic;
		build
]
