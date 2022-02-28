Extension { #name : #MBBaselineModel }

{ #category : #'*BaselineMap-UI' }
MBBaselineModel >> inspectionBaselineMap [
	<inspectorPresentationOrder: 10 title: 'Dependencies Map'>
	| canvas |
	canvas := BMMapBuilder new
		baseline: self baselineClass;
		build;
		canvas.
	
	^ SpRoassal3InspectorPresenter new
		canvas: canvas;
		yourself
]
