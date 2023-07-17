Class {
	#name : #MyFocusOnCanvas,
	#superclass : #RSAbstractControlCanvasInteraction,
	#category : #MyControllerExtension
}

{ #category : #hooks }
MyFocusOnCanvas >> askAndFocusOn: aCanvas [
	"Ask for a shape to search"

	| modelToSearchAsString shapeToFocusOn |
	modelToSearchAsString := 
		UIManager default 
			request: 'Enter an object textual description'
		  initialAnswer: 'E.g., 42'.

	"Exit if nothing was entered"
	(modelToSearchAsString isNil or: [ modelToSearchAsString isEmpty ])
		ifTrue: [ ^ self ].

	shapeToFocusOn := aCanvas shapes
		                  detect: [ :s |
		                  s model asString = modelToSearchAsString ]
		                  ifNone: [ ^ self ].

	shapeToFocusOn @ RSBlink.
	aCanvas camera translateTo: shapeToFocusOn position.
	aCanvas signalUpdate
]

{ #category : #hooks }
MyFocusOnCanvas >> example [
"MyFocusOnCanvas new example "
	| canvas random size shape |
	canvas := RSCanvas new.
	random := Random new.

	100 timesRepeat: [
		size := random nextInteger: 50.
		shape := RSEllipse new
			         size: size;
			         model: size.
		shape translateTo:
			(random nextInteger: 500) @ (random nextInteger: 500).
		shape color: Color random translucent.
		canvas add: shape ].

	canvas shapes @ RSPopup.
	RSFlowLayout on: canvas shapes.
	canvas
	@ (RSCanvasController new addInteractionClass: MyFocusOnCanvas).
	canvas open
]

{ #category : #hooks }
MyFocusOnCanvas >> onShape: aCanvas [

	aCanvas
		when: RSKeyUp
		do: [ :evt |
		evt keyName = 'F' ifTrue: [ self askAndFocusOn: evt canvas ] ]
		for: self
]

{ #category : #rendering }
MyFocusOnCanvas >> renderLegendOn: anRSLegend [
	"put a nice description in this legend builder"

	anRSLegend text: 'F' description: 'Focus on a element by moving the camera'.
]
