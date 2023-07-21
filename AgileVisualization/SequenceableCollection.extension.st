Extension { #name : #SequenceableCollection }

{ #category : #'*AgileVisualization' }
SequenceableCollection >> inspectorVisualization [
<inspectorPresentationOrder: 90 title: 'Visualization'>

^ SpRoassal3InspectorPresenter new
		canvas: self visualizeListOfNumbers;
		yourself.
]

{ #category : #'*AgileVisualization' }
SequenceableCollection >> inspectorVisualizationCollections [
<inspectorPresentationOrder: 90 title: 'Collections'>

^ SpRoassal3InspectorPresenter new
		canvas: self visualizeCollections;
		yourself.
]

{ #category : #'*AgileVisualization' }
SequenceableCollection >> inspectorVisualizationCollectionsContext: aContext [

	aContext withoutEvaluator .
]

{ #category : #'*AgileVisualization' }
SequenceableCollection >> inspectorVisualizationContext: aContext [
	
	aContext withoutEvaluator 
]

{ #category : #'*AgileVisualization' }
SequenceableCollection >> inspectorVisualizationNo0 [
<inspectorPresentationOrder: 90 title: 'VisualizationNo0'>

^ SpRoassal3InspectorPresenter new
		canvas: self visualizeListOfNumbersNo0;
		yourself.
]

{ #category : #'*AgileVisualization' }
SequenceableCollection >> inspectorVisualizationNo0Context: aContext [
	
	aContext withoutEvaluator 
]

{ #category : #'*AgileVisualization' }
SequenceableCollection >> visualizeCollections [
| m |

(self allSatisfy: #isCollection) ifFalse: [ 
	^ RSCanvas new 
			add: (RSLabel text: 'Need to contain collections');
			yourself.
	].

m := RSMondrian new.
m shape circle color: Color gray translucent.
m nodes: self.
m normalizeSize: #size from: 5 to: 10.
m layout force.
m line connectToAll: [ :coll | self select: [ :coll2 | coll size = coll2 size ] ].
m build.
^ m canvas 	
]

{ #category : #'*AgileVisualization' }
SequenceableCollection >> visualizeListOfNumbers [

	| chart plot |
	"Added guard to check if all members of the collection are numbers"
	(self allSatisfy: #isNumber) ifFalse: [
		^ RSCanvas new
			  add: (RSLabel text: 'Need to contain numbers');
			  yourself ].

	chart := RSCompositeChart new.
	plot := RSLinePlot new.

	plot y: self.
	chart add: plot.

	chart title: 'Visualing numbers'.
	chart addDecoration: RSVerticalTick new.
	chart addDecoration: RSHorizontalTick new.
	chart mustInclude0inY.

	chart build.
	^ chart canvas
]

{ #category : #'*AgileVisualization' }
SequenceableCollection >> visualizeListOfNumbersNo0 [

	| chart plot |
	"Added guard to check if all members of the collection are numbers"
	(self allSatisfy: #isNumber) ifFalse: [
		^ RSCanvas new
			  add: (RSLabel text: 'Need to contain numbers');
			  yourself ].

	chart := RSCompositeChart  new.
	plot := RSLinePlot new.

	plot y: self.
	chart add: plot.

	chart title: 'Visualing numbers'.
	chart addDecoration: RSVerticalTick new.
	chart addDecoration: RSHorizontalTick new.

	chart build.
	^ chart canvas
]
