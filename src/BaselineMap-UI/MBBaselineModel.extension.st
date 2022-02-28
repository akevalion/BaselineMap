Extension { #name : #MBBaselineModel }

{ #category : #'*BaselineMap-UI' }
MBBaselineModel >> inspectionBaselineMap: builder [
	<inspectorPresentationOrder: 10 title: 'Dependencies Map'>
	| canvas |
	canvas := BMMapBuilder new
		in: [ :map |
			self baselineClass 
				ifNotNil: [ map baseline: self baselineClass ] ];
		build;
		canvas.
	^ SpRoassal3InspectorPresenter new
		canvas: canvas;
		yourself
]
