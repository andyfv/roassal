"
Class: 
	I am modeling the state

Responsibility:
	Hold a grid and a position of the knight
	
Collaborators:
	My main collaborators are the RL class and RLGrid class
	
Public API and Key Messages:
	• grid: aGrid - take a aGrid
	• position: aPoint - take the position of the knight as aPoint

Internal Representation and Key Implementation Points: 
	The hash and comparing method are rewrited because the state needs to 
	compared to other states.

"
Class {
	#name : #RLState,
	#superclass : #Object,
	#instVars : [
		'grid',
		'position'
	],
	#category : #ReinforcementLearning
}

{ #category : #initialization }
RLState >> = anotherState [
    "Two state are identical if (i) they have the same class, (ii) the same grid,
and (iii) the same position of the knight"

	anotherState class == self class ifFalse: [ ^ false. ].
	^ grid = anotherState grid and: [ position = anotherState position ].
]

{ #category : #example }
RLState >> example [
    "Run the example to see the results: 

	RLState new example inspect
	
	"

    ^ RLState new grid: (  RLGrid new
               setSize: 5;
               setMonsters: 5  )
]

{ #category : #initialization }
RLState >> grid [
    "Return the grid associated to the state"

    ^ grid
]

{ #category : #initialization }
RLState >> grid: aGrid [
    "Set the grid associated to the state"

grid := aGrid.
    
]

{ #category : #initialization }
RLState >> hash [
"The hash of a state is a combination of the hash of the grid 
	with the hash of the position "
	
	^ grid hash bitXor: position hash.
]

{ #category : #initialization }
RLState >> initialize [ 

super initialize.
position := 1 @ 1.
]

{ #category : #initialization }
RLState >> inspectorVisualization [ 
"Hook the visualization to the inspector"

<inspectorPresentationOrder: 90 title: 'Visualization'>

	| canvas |
	canvas := self visualize .
	canvas @ RSCanvasController .
	^ SpRoassal3InspectorPresenter new
		canvas: canvas;
		yourself.
		
	
]

{ #category : #initialization }
RLState >> position [
    "Return the knight position"

    ^ position
]

{ #category : #initialization }
RLState >> position: aPoint [
"Set the knight position"
	position := aPoint
]

{ #category : #initialization }
RLState >> printOn: str [
"Give a string representation of a state"

	str nextPutAll: 'S<'.
	str nextPutAll: self hash asString.
	str nextPutAll: '>'.
]

{ #category : #initialization }
RLState >> visualize [
	"Visualize the grid and the position of the knight"
	
	| gridCanvas knightShape |
	
	gridCanvas := grid visualize.
	knightShape := RSCircle new size: 15; color: Color blue lighter.
	gridCanvas add: knightShape.
	knightShape translateTo: self position - ( 0.5 @ 0.5 ) * 20.
	
	^ gridCanvas 
]
