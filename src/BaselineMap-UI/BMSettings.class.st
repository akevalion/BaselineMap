"
Settings for this project
"
Class {
	#name : #BMSettings,
	#superclass : #Object,
	#classInstVars : [
		'classMapBuilder',
		'baselineMap'
	],
	#category : #'BaselineMap-UI-BaselineMap-UI'
}

{ #category : #accessing }
BMSettings class >> classMapBuilder [
	^ classMapBuilder ifNil: [ self defaultClassMapBuilder ]
]

{ #category : #accessing }
BMSettings class >> classMapBuilder: aClass [
	classMapBuilder := aClass
]

{ #category : #accessing }
BMSettings class >> defaultClassMapBuilder [
	^ BMMapBuilder
]

{ #category : #settings }
BMSettings class >> settingsClassOn: aBuilder [
	<systemsettings>
	(aBuilder pickOne: #classMapBuilder)
		parent: #baselineMap;
		label: 'Baseline Map';
		description: 'Choose a class to be default in the inspector and baseline';
		target: self;
		domainValues: BMMapBuilder withAllSubclasses;
		default: BMMapBuilder
]

{ #category : #settings }
BMSettings class >> settingsGroupOn: aBuilder [
	<systemsettings>
	(aBuilder group: #baselineMap)
		label: #pharoSystem;
		label: 'Baseline Map';
		description: 'Used to generate a visual map'
]
