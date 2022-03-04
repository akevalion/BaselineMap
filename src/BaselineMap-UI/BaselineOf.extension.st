Extension { #name : #BaselineOf }

{ #category : #'*BaselineMap-UI' }
BaselineOf >> inspectionBaselineMap [
	<inspectorPresentationOrder: 10 title: 'Dependencies Map'>
	| canvas |
	canvas := BMSettings classMapBuilder new
		baseline: self class;
		build;
		canvas.
	
	^ SpRoassal3InspectorPresenter new
		canvas: canvas;
		yourself
]
