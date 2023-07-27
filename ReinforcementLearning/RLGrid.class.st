"
I am grid, or a simple square that contains the exit and some monsters.
The knight moves around the grid trying to find the exit.

Responsibility: 
	I manage the grid and know the contents of my cells
	
Collaborators: 
	My main collaborators are the RL class and the RLState class
	
Public API and Key Messages:
	• setMonsters - after creating a new grid, set the number of monsters
	• setSize     - after creating a new grid, set the size of the grid
	• atPosition: aPoint - Return the character located at a given position
	• atPosition: aPoint put: aCharacter - Set aCharacter at a given position
	
Example: 
	RLGrid new setSize: 5; setMonsters: 5		""Creation of a grid""
			
	(RLGrid new) atPosition: aPoint 				""Return the character at aPoint if there is one""
							
	(RLGrid new) atPosition: aPoint put: aCharacter  ""Put aCharacter at aPoint on the grid""


Internal Representation: 
	The contents of the map use the following encoding:	
		• $e represents the exit. The knight looks for the exit to finish the game.
		• $m represents a monster. The kngith has to learn to avoid monsters
		• $. represents an empty cell. The knight ca freely move on an empty cell
"
Class {
	#name : #RLGrid,
	#superclass : #Object,
	#instVars : [
		'content'
	],
	#category : #ReinforcementLearning
}

{ #category : #initialization }
RLGrid >> = anotherObject [
    "Override the equal method to make structural comparison and not identity comparison
		Two object are equal if their class and content are the same.
		Returns true if anotherObject has the same map as myself"

    anotherObject class == self class ifFalse: [  ^ false  ].

    ^ content = anotherObject content
]

{ #category : #initialization }
RLGrid >> atPosition: aPoint [
"Return the character located at a given position"

^ (content at: aPoint y) at: aPoint x
]

{ #category : #initialization }
RLGrid >> atPosition: aPoint put: aCharacter [
    "Set the aCharacter (value of cell map) at a given position"

    ^ (  content at: aPoint y  ) at: aPoint x put: aCharacter 
]

{ #category : #initialization }
RLGrid >> content [
	"Return the grid content, as an array of characters"

    ^ content
]

{ #category : #examples }
RLGrid >> example [
    "Run the example to see the results:
	
		RLGrid new example inspect
	
	"

    ^ RLGrid new
          setSize: 5;
          setMonsters: 5
]

{ #category : #initialization }
RLGrid >> extent [
    "Return a point that represents the extent of the grid."

    ^ content first size @ content size
]

{ #category : #initialization }
RLGrid >> hash [
"The hash of a grid is the hash of its contens"

	^ content hash
]

{ #category : #initialization }
RLGrid >> initialize [ 

super initialize.

self setSize: 2.
]

{ #category : #initialization }
RLGrid >> inspectorVisualization [ 
<inspectorPresentationOrder: 90 title: 'Visualization'>
| canvas |
canvas := self visualize.
canvas @ RSCanvasController.

^ SpRoassal3InspectorPresenter new
	canvas: canvas;
	yourself.
]

{ #category : #initialization }
RLGrid >> postCopy [
	"A grid must be properly copied"
	
	super postCopy.
	content := content copy.
]

{ #category : #initialization }
RLGrid >> setExitBottomRight [
    "Set the exit position at the bottom right of the grid."

    self atPosition: self extent put: $e.
]

{ #category : #initialization }
RLGrid >> setMonsters: numberOfMonstersToAdd [

    | random leftMonsters s pos nbTries |
    random := Random seed: 42.
    leftMonsters := numberOfMonstersToAdd.
    nbTries := 0.
    s := self extent.
    [  leftMonsters > 0  ] whileTrue: [
        pos := ( random nextInteger: s x )
               @ ( random nextInteger: s y ).
        (  self atPosition: pos  ) = $.
            ifTrue: [
                nbTries := 0.
                self atPosition: pos put: $m.
                leftMonsters := leftMonsters - 1  ]
            ifFalse: [
                nbTries := nbTries + 1.
                nbTries > 5 ifTrue: [  ^ self  ]  ]  ]
]

{ #category : #initialization }
RLGrid >> setSize: anInteger [
		"Set the grid as a square od size anInteger, containing the character $. which 	represents and empty cell"
		
		content := (1 to: anInteger) collect: [ :notUsed | Array new: anInteger withAll: $. ] as: Array.
		self setExitBottomRight.
	
]

{ #category : #initialization }
RLGrid >> visualize [
    "The cells of the map are represented as a square box. 
		The color of the box indicates what the cell actually represents:
	- gray box   : space
	- red box    : monster
	- green box : exit"

    | canvas shapes |
    canvas := RSCanvas new.
    shapes := RSBox
                  models: (  self content flatCollect: #yourself  )
                  forEach: [  :s :o |
                      s size: 20.
                      o = $. ifTrue: [
                          s color: Color veryVeryLightGray  ].
                      o = $m ifTrue: [  s color: Color lightRed  ].
                      o = $e ifTrue: [  s color: Color lightGreen  ]  ].

    canvas addAll: shapes.
    RSGridLayout new
        gapSize: 0;
        lineItemsCount: self extent x;
        on: shapes.

    shapes translateTopLeftTo: 0 @ 0.
    ^ canvas
]
