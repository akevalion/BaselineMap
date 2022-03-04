Extension { #name : #BMBaselineModel }

{ #category : #'*BaselineMap-UI' }
BMBaselineModel >> inspectionBaselineMap: builder [
	<inspectorPresentationOrder: 10 title: 'Dependencies Map'>
	| canvas |
	canvas := BMSettings classMapBuilder new
		in: [ :map |
			self baselineClass 
				ifNotNil: [ map baseline: self baselineClass ] ];
		build;
		canvas.
	^ SpRoassal3InspectorPresenter new
		canvas: canvas;
		yourself
]
