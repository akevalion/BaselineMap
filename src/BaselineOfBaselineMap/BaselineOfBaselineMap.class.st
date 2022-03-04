"
Baseline of this visual map project 
"
Class {
	#name : #BaselineOfBaselineMap,
	#superclass : #BaselineOf,
	#category : #BaselineOfBaselineMap
}

{ #category : #baselines }
BaselineOfBaselineMap >> baseline: spec [
	<baseline>
	spec for: #common do: [ 
		self roassal3: spec.
		spec
			package: 'BaselineMap-Model';
			package: 'BaselineMap-UI' with: [ spec requires: 'Roassal3' ];
			package: 'BaselineMap-Tests';
			package: 'BaselineMap-UI-Customs'.
	]
]

{ #category : #utilities }
BaselineOfBaselineMap >> roassal3: spec [
	spec 
		baseline: 'Roassal3' 
		with: [ spec
			repository: 'github://ObjectProfile/Roassal3/src'; 
			loads: #('Core') ]
]
