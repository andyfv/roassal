Class {
	#name : #RSIntro,
	#superclass : #Object,
	#category : #AgileVisualization
}

{ #category : #'chapter-5 (Architecture Overview)' }
RSIntro >> animations [
	"Make animation"
	"Run the example to see the results: 
		
		RSIntro new animations
		
		"

	| c r p shape |
	c := RSCanvas new.
	r := Random seed: 42.

	100 timesRepeat: [
		p := (r nextInteger: 500) - 250 @ ((r nextInteger: 500) - 250).
		shape := RSCircle new color: Color random translucent.
		shape translateTo: p.

		c add: shape.

		c newAnimation
			easing: RSEasingInterpolator bounce;
			from: p;
			duration: ((r nextInteger: 5) / 2) second;
			to: p + (0 @ 100);
			on: shape set: #position:;
			when: RSAnimationEndEvent do: [ :evt | shape remove ] for: c ].

	c open
]

{ #category : #'chapter-7 (Shapes)' }
RSIntro >> arrowedLin [
	"Run the example to see the results:
	
	RSIntro new arrowedLine
	
	"

	| c line labelStart labelEnd |
	c := RSCanvas new.

	labelStart := RSLabel text: 'start'.
	labelEnd := RSLabel text: 'end'.
	labelStart @ RSDraggable.
	labelEnd @ RSDraggable.
	c add: labelStart.
	c add: labelEnd.

	labelEnd translateBy: 80 @ 60.
	line := RSArrowedLine new.
	line from: labelStart.
	line to: labelEnd.
	line withBorderAttachPoint.

	c add: line.
	c zoomToFit.
	c open
]

{ #category : #'chapter-7 (Shapes)' }
RSIntro >> arrowedLine [
	"Run the example to see the results:
	
	RSIntro new arrowedLine
	
	"

	| c line labelStart labelEnd |
	c := RSCanvas new.

	labelStart := RSLabel text: 'start'.
	labelEnd := RSLabel text: 'end'.
	labelStart @ RSDraggable.
	labelEnd @ RSDraggable.
	c add: labelStart.
	c add: labelEnd.

	labelEnd translateBy: 80 @ 60.
	line := RSArrowedLine new.
	line from: labelStart.
	line to: labelEnd.
	line withBorderAttachPoint.

	c add: line.
	c zoomToFit.
	c open
]

{ #category : #'chapter-8 (Line Builder)' }
RSIntro >> associations [
	"Run the example to see the results: 
	
	RSIntro new associations
	
	"

	| c |
	c := RSCanvas new.
	c addAll: (RSCircle models: (1 to: 4)).
	c shapes @ RSDraggable @ RSPopup.

	RSLineBuilder line
		color: Color red translucent;
		canvas: c;
		withBorderAttachPoint;
		useAssociations: {
				(1 -> 2).
				(2 -> 3).
				(4 -> 1).
				(3 -> 4) }.

	RSGridLayout new
		gapSize: 30;
		on: c nodes.

	c @ RSCanvasController.
	c open
]

{ #category : #'chapter-7 (Shapes)' }
RSIntro >> border [
"Run the example to see the result:
	
	RSIntro new border
	
	"
	
| c r box |
c := RSCanvas new.
r := Random seed: 42.

40 timesRepeat: [ 
	box := RSBox new
					width: (r nextInteger: 80);
					height: (r nextInteger: 80);
					color: Color gray;	
					cornerRadius: 10.
	box borderColor: #black.
	box color: Color random translucent.
	box translateTo: (r nextInteger: 200) @ (r nextInteger: 200).
	c add: box.
	].

c @ RSCanvasController .
c open.
]

{ #category : #'chapter-7 (Shapes)' }
RSIntro >> borderDashed [
	"Run the example to see the result:
	
	RSIntro new borderDashed
	
	"

	| c b box ellipse |
	c := RSCanvas new.
	b := RSBorder new color: Color red.
	b dashArray: #( 5 1 5 ).

	(30 to: 60 by: 5) do: [ :nb |
		box := RSBox new
			       size: nb;
			       cornerRadius: 10.
		ellipse := RSEllipse new
			           width: nb;
			           height: nb + 10.
		box border: b.
		ellipse border: b.
		c
			add: box;
			add: ellipse
		].

	RSFlowLayout on: c shapes.
	c @ RSCanvasController.

	c newAnimation
		from: 0;
		to: 40;
		on: b set: #dashOffset:. 
	c open
]

{ #category : #'chapter-7 (Shapes)' }
RSIntro >> box [
"Run the example to see the results:
	
	RSIntro new box
	
	"

	| c box |
	c := RSCanvas new.
	box := RSBox new.
	c add: box.
	c open
]

{ #category : #'chapter-7 (Shapes)' }
RSIntro >> boxRadius [
	"Run the example to see the results:
	
	RSIntro new boxRadius
	
	"

	| c box r |
	c := RSCanvas new.
	r := Random seed: 42.

	40 timesRepeat: [
		box := RSBox new
			       width: (r nextInteger: 80);
			       height: (r nextInteger: 80);
			       cornerRadius: 10.
		box color: Color random translucent.
		box translateTo: (r nextInteger: 200) @ (r nextInteger: 200).
		c add: box
		].

	c @ RSCanvasController.
	c open
]

{ #category : #'chapter-5 (Architecture Overview)' }
RSIntro >> canvasBackground [
"Execute this method to see the results:

	RSIntro new canvasBackground
	
	"
	| box canvas |
	box := RSBox new
		       size: 80;
		       color: #yellow;
		       border: (RSBorder new
				        color: #blue;
				        width: 10).

	canvas := RSCanvas new.
	canvas color: Color green.
	canvas add: box.
	canvas open
]

{ #category : #'chapter-6 (Canvas)' }
RSIntro >> canvasController [
"The RSCanvasController does the following actions: 
	- moves the canvas
	- perform zooming
	- search for a particular shape"
	
	"Run the example to see the result:
	
		RSIntro new canvasController
		
		"

	| c r size shape |
	c := RSCanvas new.
	r := Random new.
	100 timesRepeat: [
		size := r nextInteger: 50.
		shape := RSEllipse new
			         size: size;
			         model: size.
		shape translateTo: (r nextInteger: 500) @ (r nextInteger: 500).
		shape color: Color random translucent.
		c add: shape
		].
	c shapes @ RSPopup.
	RSFlowLayout on: c shapes.
	c @ RSCanvasController.
	c open
]

{ #category : #'chapter-5 (Architecture Overview)' }
RSIntro >> canvasInteractions [
	"Execute this method to see the results:

	RSIntro new canvasInteractions 
	
	"

	| canvas |
	canvas := RSCanvas new.

	1 to: 1000 do: [ :i | canvas add: (RSBox new size: 10) ].

	RSGridLayout on: canvas shapes.
	
	"The RSCanvasController interaction let you zoom and scroll the canvas"
	canvas @ RSCanvasController.
	
	canvas open
]

{ #category : #'chapter-6 (Canvas)' }
RSIntro >> canvasWindowSize [
	
| c win |
c := RSCanvas new.
c add: (RSBox new color: Color red; size: 200).
win := c open.
win extent: 800 @ 300.
]

{ #category : #'chapter-6 (Canvas)' }
RSIntro >> canvasWindowZoomToFit [
	"Opening a canvas returns an object describing a Pharo window"
	"Run the example to see the results:
	
		RSIntro new canvasWindowZoomToFit 
		
		"

	| c |
	c := RSCanvas new.
	c addAll: (RSLabel models: (1 to: 9)).
	RSGridLayout on: c shapes.
	c zoomToFit.
	c open
]

{ #category : #'chapter-2' }
RSIntro >> chartingData [

"Execute this method to see the results:

	RSIntro new chartingData
	
	"

	| url rawData countries allData color chart b |
	url := 'https://raw.githubusercontent.com/ObjectProfile/'
	       , 'Roassal3Documentation/master/data/'
	       , 'covidDataUntil23-September-2020.txt'.

	rawData := OpalCompiler new
		           source: (ZnClient new get: url) contents;
		           evaluate.
	countries := rawData collect: #first.
	allData := rawData collect: #allButFirst.
	color := NSScale category20.

	chart := RSChart new.
	chart extent: 400 @ 400.
	chart colors: color.
	allData do: [ :data | chart addPlot: (RSLinePlot new y: data) ].
	chart xlabel: 'Days since epoch' offset: 0 @ 20.
	chart ylabel: 'Contaminated' offset: -60 @ 0.
	chart title: 'Coronavirus confirmed cases'.
	chart addDecoration: (RSHorizontalTick new fontSize: 10).
	chart addDecoration: (RSVerticalTick new
			 integerWithCommas;
			 fontSize: 10).
	chart ySqrt.
	chart build.

	b := RSLegend new.
	b container: chart canvas.
	countries
		with: chart plots
		do: [ :c :p | b text: c withBoxColor: (chart colorFor: p) ].

	b layout horizontal gapSize: 30.
	b build.
	b canvas open
]

{ #category : #'chapter-7 (Shapes)' }
RSIntro >> circle [

"Run the example to see the results:

	RSIntro new circle
	
	"
	
| c b |
c := RSCanvas new.
(30 to: 150 by: 10) do: [ :nb |
	b := RSCircle size: nb.	
	c add: b. 
	].

RSFlowLayout on: c nodes.
c @ RSCanvasController .
c open.
]

{ #category : #'chapter-8 (Line Builder)' }
RSIntro >> classDiagram [
"Run the example to see the results:
	
	RSIntro new classDiagram
	
	"

| classes c boxes fromBox toBox line |

classes := Collection withAllSubclasses .

c := RSCanvas new.

"Build nodes"
boxes := RSCircle models: classes.

c addAll: boxes.

RSFlowLayout on: c shapes.

"Connect nodes"
classes do: [ :cls | 
	fromBox := boxes shapeFromModel: cls superclass.
	toBox := boxes shapeFromModel: cls .
	
	fromBox ifNotNil: [ 
		line := RSLine new.
		line from: fromBox.
		line to: toBox.
		c add: line 
		].
	].	
	
	RSTreeLayout on: c nodes.
	c @ RSCanvasController.
	c open.

]

{ #category : #'chapter-8 (Line Builder)' }
RSIntro >> classDiagramImproved [
	"Run the example to see the results:
	
	RSIntro new classDiagramImproved
	
	"

	| classes c boxes lb |
	classes := Collection withAllSubclasses.

	c := RSCanvas new.

	"Build nodes"
	boxes := RSCircle models: classes.

	c addAll: boxes.

	lb := RSLineBuilder line.
	lb shapes: boxes.
	lb connectFrom: #superclass.

	RSTreeLayout on: c nodes.
	c @ RSCanvasController.
	c open
]

{ #category : #'chapter-8 (Line Builder)' }
RSIntro >> classDiagramImprovedV2 [
	"Run the example to see the results:
	
	RSIntro new classDiagramImprovedV2
	
	"

	| classes c boxes lb |
	classes := Collection withAllSubclasses.

	c := RSCanvas new.

	"Build nodes"
	boxes := RSCircle models: classes.

	c addAll: boxes.

	lb := RSLineBuilder orthoVertical.
	lb withVerticalAttachPoint.
	lb capRound.
	lb shapes: boxes.
	lb connectFrom: #superclass.

	RSTreeLayout on: c nodes.
	c @ RSCanvasController.
	c open
]

{ #category : #'chapter-9 (Shape Composition)' }
RSIntro >> compositeShapes [
	"Run the example to see the results:

	RSIntro new compositeShapes
	
	"

	| c g |
	c := RSCanvas new.
	1 to: 10 do: [ :i |
		g := RSGroup new.
		i timesRepeat: [ g add: RSCircle new ].
		RSFlowLayout on: g.
		c add: g asShape
		].
	
	RSGridLayout new gapSize: 50; on: c shapes.
	c shapes @ RSDraggable @ RSHighlightable red.
	c zoomToFit.
	c open.
]

{ #category : #'chapter-9 (Shape Composition)' }
RSIntro >> compositeWithLabels [
	"Run the example to see the results:

	RSIntro new compositeWithLabels
	
	"

	| c g compositeShape title |
	c := RSCanvas new.

	1 to: 10 do: [ :i |
		g := RSGroup new.
		i timesRepeat: [ g add: RSCircle new ].
		RSFlowLayout on: g.

		title := RSLabel text: i 			"Create Label".
		RSVerticalLineLayout new 			"Set the Label to align vertically"
			alignCenter;
			on: {
					title.
					g }.
		g add: title 								"Add the Label to the group".

		compositeShape := g asShape.
		compositeShape borderColor: Color black.
		compositeShape padding: 5.
		c add: compositeShape
		].

	RSGridLayout new
		gapSize: 50;
		on: c shapes.

	c shapes @ RSDraggable @ RSHighlightable red.
	c zoomToFit.
	c open
]

{ #category : #'chapter-9 (Shape Composition)' }
RSIntro >> compositeWithLines [
	"Run the example to see the results:

	RSIntro new compositeWithLines
	
	"

	| c g compositeShape title lb |
	c := RSCanvas new.

	1 to: 100 by: 10 do: [ :i |
		g := RSCircle models: (1 to: i) forEach: [ :s :nb | s color: Color random translucent ].
		
		lb := RSLineBuilder line.
		lb canvas: g.
		lb shapes: g.
		lb connectFrom: [ :nb | nb // 2 ].
		
		RSRadialTreeLayout on: g nodes.
		
		title := RSLabel new fontSize: 20; text: i.
		RSVerticalLineLayout new 			"Set the Label to align vertically"
			alignCenter;
			on: {
					title.
					g }.
		g add: title 								"Add the Label to the group".

		compositeShape := g asShape.
		compositeShape borderColor: Color black.
		compositeShape padding: 5.
		c add: compositeShape
		].

	RSGridLayout new
		gapSize: 50;
		on: c shapes.

	c shapes @ RSDraggable @ RSHighlightable red.
	c @ RSCanvasController .
	c zoomToFit.
	c open
]

{ #category : #'chapter-6 (Canvas)' }
RSIntro >> convertingCanvas [
"Convert canvas to a shape"
"Run this example to see the results:

	RSIntro new convertingCanvas 
	
	"

	| canvas tmpCanvas someShapes |
	canvas := RSCanvas new.
	5 timesRepeat: [
		tmpCanvas := RSCanvas new.
		someShapes := RSCircle models: (1 to: 50).
		tmpCanvas addAll: someShapes.
		RSGridLayout on: tmpCanvas shapes.
		tmpCanvas shapes color: Color random translucent.
		canvas add: tmpCanvas asShape
		].

	RSGridLayout on: canvas shapes.
	canvas @ RSCanvasController.
	canvas open
]

{ #category : #'chapter-6 (Canvas)' }
RSIntro >> convertingCanvasComplex [
	"Convert canvas to a shape"

	"Run this example to see the results:

	RSIntro new convertingCanvasComplex
	
	"

	| g1 p1 g2 p2 c lb |
	
	g1 := RSChart new.
	p1 := RSLinePlot new.
	
	p1 y: #( 5 10 3 -4 -5 15 ).
	g1 addPlot: p1.
	
	g1 addDecoration: (RSXLabelDecoration new
			 title: 'Time';
			 offset: 0 @ 10).
	g1 addDecoration: (RSYLabelDecoration new
			 title: 'Value';
			 offset: -20 @ 0).
	g1 addDecoration: (RSHorizontalTick new).
	g1 addDecoration: (RSVerticalTick new).
	g1 build.


	g2 := RSChart new.
	p2 := RSLinePlot new.
	
	p2 y: #( 2 10 50 -20 40 30 25 12 4 ).
	g2 addPlot: p2.
	
	g2 addDecoration: (RSXLabelDecoration new
			 title: 'Time';
			 offset: 0 @ 10).
	g2 addDecoration: (RSYLabelDecoration new
			 title: 'Value';
			 offset: -20 @ 0).
	g2 addDecoration: (RSHorizontalTick new).
	g2 addDecoration: (RSVerticalTick new).
	g2 build.

	c := RSCanvas new.
	c add: (g1 canvas asShapeModel: 1).
	c add: (g2 canvas asShapeModel: 2).
	RSHorizontalLineLayout on: c shapes.

	"We make the graphs draggable"
	c shapes @ RSDraggable.

	lb := RSLineBuilder arrowedLine.
	lb withBorderAttachPoint.
	lb canvas: c.
	lb useAssociation: 1 -> 2.

	c @ RSCanvasController.
	c open
]

{ #category : #'chapter-6 (Canvas)' }
RSIntro >> events [
	"Canvas events"

	"Run the example to see the results: 
	
		RSIntro new events
		
		"

	| canvas lbl |
	canvas := RSCanvas new.

	lbl := RSLabel new.
	canvas add: lbl.

	canvas
		when: RSEvent
		do: [ :evt |
			lbl text: evt asString.
			canvas signalUpdate
			]
		for: self.

	canvas open
]

{ #category : #'chapter-6 (Canvas)' }
RSIntro >> fixedShape [
	"Run the example to see the results:

	RSIntro new fixedShape
	
	"

	| c fixedLbl lbl1 lbl2 |
	c := RSCanvas new.
	fixedLbl := RSLabel new
		            text: 'Fixed label';
		            fontSize: 20.
	c add: fixedLbl.
	fixedLbl setAsFixed.
	fixedLbl translateTopLeftTo: 10 @ 10.

	lbl1 := RSLabel new
		        text: 'Movable label';
		        fontSize: 20.
	c add: lbl1.

	lbl2 := RSLabel new
		        text: 'Try moving the background';
		        fontSize: 20.
	c add: lbl2.
	lbl2 translateBy: 0 @ -30.

	c @ RSCanvasController.
	c open
]

{ #category : #'chapter-2' }
RSIntro >> graphRendering [

"Execute this method to see the results:

	RSIntro new graphRendering 
	
	"

	| nodesModel edges graph canvas nodes highlightable lb |
	nodesModel := $a to: $s.

	edges := #( #( $a $b 30 ) #( $b $s 1 ) #( $b $p 4 ) #( $b $c 30 )
	            #( $d $e 30 ) #( $d $f 20 ) #( $d $j 10 ) #( $e $a 15 )
	            #( $f $m 8 ) #( $g $h 20 ) #( $g $r 3 ) #( $i $a 14 )
	            #( $i $k 4 ) #( $i $d 3 ) #( $j $q 5 ) #( $k $l 10 )
	            #( $k $g 5 ) #( $m $n 7 ) #( $m $o 6 ) #( $n $c 5 )
	            #( $p $b 5 ) #( $q $i 4 ) ).

	graph := Dictionary new.
	nodesModel do: [ :aNode | graph at: aNode put: Set new ].

	edges do: [ :edge |
		| fromNode toNode |
		fromNode := edge first.
		toNode := edge second.
		(graph at: fromNode) add: toNode ].

	canvas := RSCanvas new.
	nodes := RSCircle models: nodesModel forEach: [ :circle :model |
		         circle
			         size: 20;
			         color: Color veryLightGray ].

	nodes
		@ RSDraggable;
		@ RSPopup.
	canvas addAll: nodes.

	highlightable := RSHighlightable new.
	highlightable highlightColor: Color red.
	highlightable withEdges.
	nodes @ highlightable.

	lb := RSLineBuilder line.
	lb canvas: canvas.
	lb makeBidirectional.
	lb moveBehind.
	lb objects: nodesModel.
	lb connectToAll: [ :aNumber | graph at: aNumber ].
	canvas lines do: [ :line |
		| edge length |
		edge := edges detect: [ :e |
			        e first = line model key and: [
				        e second = line model value ] ].
		length := edge third sqrt * 2.
		line width: length.
		line attachPoint: (RSBorderAttachPoint new endOffset: length).
		line markerEnd: (RSShapeFactory arrow size: length * 2).
		line markerEnd offset: length / -5 ].
	canvas nodes , canvas lines @ (RSLabeled new
		 in: [ :lbl |
			 lbl location middle.
			 lbl shapeBuilder labelShape color: Color black ];
		 yourself).
	RSForceBasedLayout new
		charge: -500;
		doNotUseProgressBar;
		on: nodes.
	canvas @ RSCanvasController.
	canvas open
]

{ #category : #'chapter-8 (Line Builder)' }
RSIntro >> graphVisualization [
	"Run the example to see the results:
	
	RSIntro new graphVisualization 
	
	"

	| numberOfNodes r graph numberOfLines fromNode toNode c nodes lb |
	numberOfNodes := 25.
	numberOfLines := 90.
	r := Random seed: 42.
	graph := Dictionary new.

	1 to: numberOfNodes do: [ :aNode | graph at: aNode put: Set new ].

	numberOfLines timesRepeat: [
		fromNode := r nextInteger: numberOfNodes.
		toNode := r nextInteger: numberOfNodes.
		(graph at: fromNode) add: toNode ].

	c := RSCanvas new.
	nodes := RSLabel models: (1 to: numberOfNodes).
	nodes color: Color red.
	nodes @ RSDraggable @ RSPopup.
	c addAll: nodes.

	lb := RSLineBuilder line.
	lb canvas: c.
	lb withBorderAttachPoint.
	lb makeBidirectional.
	lb moveBehind.
	lb objects: (1 to: numberOfNodes).
	lb connectToAll: [ :aNumber | graph at: aNumber ].

	RSForceBasedLayout new
		charge: -300;
		on: nodes.
	c @ RSCanvasController.
	c open
]

{ #category : #'chapter-5 (Architecture Overview)' }
RSIntro >> interactions [
	"In this example there are three added interactions:
	1) RSDraggable
	2) RSLabeled
	3) RSPopup"

	"Run this example to see the results:
		
		RSIntro new interactions
		
	"

	| canvas someColors shapes |
	canvas := RSCanvas new.

	someColors := {
		              Color red.
		              Color blue.
		              Color green }.
	shapes := RSGroup new.

	someColors do: [ :aColor |
		shapes add: (RSEllipse new
				 size: 30;
				 model: aColor;
				 color: aColor) ].

	canvas addAll: shapes.

	"1) Makes the shape draggable"
	shapes @ RSDraggable.

	"2) Add a label to each shape"
	shapes @ RSLabeled highlightable.

	"3) Add a popup window when hovering over the shape"
	shapes
	@ (RSPopup text: [ :aColor | 'My color is ' , aColor asString ]).

	RSHorizontalLineLayout on: shapes.

	canvas @ RSCanvasController.
	canvas open
]

{ #category : #'chapter-7 (Shapes)' }
RSIntro >> label [
"Run the example to see the results: 
	
	RSIntro new label
	
	"
	
| c |
c := RSCanvas new.
c add: (RSLabel text: 'Hello').
c @ RSCanvasController.
c open.
]

{ #category : #'chapter-7 (Shapes)' }
RSIntro >> labelBaseline [
	"Run the example to see the results: 
	
	RSIntro new labelBaseline
	
	"

	| c words r label |
	words := String loremIpsum substrings.

	c := RSCanvas new.
	r := Random seed: 42.

	words do: [ :w |
		label := RSLabel text: w.
		label fontSize: (r nextInteger: 30).
		label @ RSHighlightable red.
		c add: label
		].


	RSFlowLayout new alignLabel; on: c nodes.
	c @ RSCanvasController.
	c open
]

{ #category : #'chapter-7 (Shapes)' }
RSIntro >> labelComplex [
	"Run the example to see the results: 
	
	RSIntro new labelComplex
	
	"

	| c words r label |
	
	words := String loremIpsum substrings.
	
	c := RSCanvas new.
	r := Random seed: 42.
	
	words do: [ :w | 
		label := RSLabel text: w.
		label fontSize: (r nextInteger: 30).
		label @ RSHighlightable red.
		c add: label. ].
	
	
	RSFlowLayout on: c nodes.
	c @ RSCanvasController.
	c open
]

{ #category : #'chapter-7 (Shapes)' }
RSIntro >> labelFont [
	"Run the example to see the results: 
	
	RSIntro new labelFont
	
	"

	| styles c label |
	styles := #(#italic #bold #normal #struckOut #underline ).
	
	c := RSCanvas new.
	styles do: [ :aStyle |
		label := RSLabel text: aStyle asString.
		label perform: aStyle.
		c add: label 
		].
	
	RSVerticalLineLayout on: c shapes.
	c @ RSCanvasController.
	c open.
]

{ #category : #'chapter-9 (Shape Composition)' }
RSIntro >> labeledCircles [
"Run the example to see the results:
	
	RSIntro new labeledCircles
	
	"
	
	| c labeledCircle lb |
	c := RSCanvas new.
	1 to: 30 do: [ :aNumber |
		labeledCircle := { RSCircle new size: 30 . RSLabel new color: Color black; text: aNumber } asGroup asShapeFor: aNumber. 
		c add: labeledCircle .
		].
	lb := RSLineBuilder line.
	lb withBorderAttachPoint .
	lb shapes: c nodes.
	lb connectFrom: [ :v | v // 2 ].
	
	RSTreeLayout on: c nodes.
	c @ RSCanvasController.
	c open.
]

{ #category : #'chapter-5 (Architecture Overview)' }
RSIntro >> layouts [
	"The layout arranges the shapes in different ways"

	"Run this method to see the results:

	RSIntro new layouts
	
	"

	| values links canvas shapes |
	values := #( 20 10 5 30 24 32 ).
	links := {
		         (20 -> #( 10 )).
		         (5 -> #( 24 #'.' 20 )).
		         (10 -> #( 32 30 )) } asDictionary.

	shapes := RSEllipse models: values.
	shapes @ RSPopup.

	canvas := RSCanvas new.
	canvas addAll: shapes.
	canvas @ RSCanvasController.

	RSNormalizer size
		shapes: shapes;
		normalize.

	"Define lines between shapes"
	RSLineBuilder line
		shapes: shapes;
		connectToAll: [ :nb | links at: nb ifAbsent: [ #(  ) ] ].

	"Arrange the shapes as a tree"
	RSTreeLayout on: shapes.

	canvas open
]

{ #category : #'chapter-7 (Shapes)' }
RSIntro >> line [ 
"Run the example to see the results: 
	
	RSIntro new line
	
	"
	
	| c line |
	c := RSCanvas new.
	line := RSLine new.
	
	line from: 30 @ 40.
	line to: 150 @ 120.
	
	c add: line.
	c open.
]

{ #category : #'chapter-7 (Shapes)' }
RSIntro >> lineAttachPoint [
	"Run the example to see the results:

	RSIntro new lineAttachPoint
	
	"

	| c box circle line |
	c := RSCanvas new.

	box := RSBox new.
	circle := RSCircle new.

	c
		add: box;
		add: circle.

	box @ RSDraggable.
	circle @ RSDraggable.

	"We make the box and circle translucent"
	{
		box.
		circle } asGroup translucent.

	circle translateTo: 50 @ 40.

	line := RSLine new.
	line color: Color red.
	line from: box.
	line to: circle.
	line withBorderAttachPoint .
	c add: line.

	c zoomToFit.
	c open
]

{ #category : #'chapter-7 (Shapes)' }
RSIntro >> lineBetweenShapes [
	"Run the example to see the results: 
	
	RSIntro new lineBetweenShapes
	
	"

	| c line box circle |
	c := RSCanvas new.
	box := RSBox new.
	circle := RSCircle new.

	c
		add: box;
		add: circle.
		
	box @ RSDraggable .
	circle @ RSDraggable .
	
circle translateTo: 50 @ 40.
line := RSLine new.
line from: box.
line to: circle.
c add: line.

c open.
]

{ #category : #'chapter-7 (Shapes)' }
RSIntro >> lineControlPoints [
	"Run the eaxmple to see the results: 
	
		RSIntro new lineControlPoints
		
		"

	| canvas |
	canvas := RSCanvas new.
	canvas add: (RSBezier new
			 color: Color red;
			 controlPoints: {
					 (0 @ 0).
					 (100 @ 100).
					 (200 @ 0).
					 (300 @ 100) }).

	canvas zoomToFit .
	canvas open
]

{ #category : #'chapter-7 (Shapes)' }
RSIntro >> lineControlPointsConroller [
	"Run the eaxmple to see the results: 
	
		RSIntro new lineControlPointsConroller
		
		"

	| canvas box1 box2 bezierLine |
	canvas := RSCanvas new.

	box1 := RSBox new color: Color blue.
	box2 := RSBox new color: Color red.

	box2 translateTo: 100 @ -200.

	box1 @ RSDraggable.
	box2 @ RSDraggable.

	canvas
		add: box1;
		add: box2.

	bezierLine := RSBezier new
		              withVerticalAttachPoint;
		              from: box1;
		              to: box2;
		              controlPointsController: RSVerticalCPAPController new;
		              yourself.

	canvas add: bezierLine.
	canvas zoomToFit.
	canvas open
]

{ #category : #'chapter-7 (Shapes)' }
RSIntro >> lineControlPointsDraggable [
	"Run the eaxmple to see the results: 
	
		RSIntro new lineControlPointsDraggable
		
		"

	| canvas box1 box2 bezierLine |
	canvas := RSCanvas new.
	
	box1 := RSBox new color: Color blue.
	box2 := RSBox new color: Color red.	
	
	box2 translateTo: 100 @ -200.
	
	box1 @ RSDraggable.
	box2 @ RSDraggable .
	
	canvas add: box1; add: box2.
	bezierLine := RSBezier new
		withVerticalAttachPoint;
		from: box1;
		to: box2;
		controlPointsController: (RSBlockCPController new
				block: [ :aLine | 
					| mid |
					mid := (box1 position + box2 position ) / 2.
					{ (box1 position)
					. (box1 position x @ mid y)
					. (box2 position x @ mid y)
					. (box2 position)
					}] ;
				yourself);
				yourself.
	canvas add: bezierLine.
	canvas zoomToFit.
	canvas open.
]

{ #category : #'chapter-7 (Shapes)' }
RSIntro >> lineMarker [
	"Run the example to see the results:
	
	RSIntro new lineMarker
	
	"

	| c box circle line |
	c := RSCanvas new.

	box := RSBox new.
	circle := RSCircle new.

	c
		add: box;
		add: circle.

	box @ RSDraggable .
	circle @ RSDraggable.
	

	circle translateTo: 50 @ 40.
	line := RSLine new.
	line withBorderAttachPoint.
	line marker: (RSCircle new
			 size: 5;
			 color: #red) asMarker.
	line from: box.
	line to: circle.
	c add: line.
	c zoomToFit.
	c open
]

{ #category : #'chapter-7 (Shapes)' }
RSIntro >> lineMarkerLabels [
	"Run the example to see the results:
	
	RSIntro new lineMarkerLabels
	
	"

	| c line markerShape labelStart labelEnd |
	c := RSCanvas new.

	markerShape := RSPolygon new
		               privatePoints: {
				               (-5 @ 9).
				               (0 @ 0).
				               (5 @ 9).
				               (0 @ 0) };
		               border: (RSBorder new width: 1);
		               asMarker.

	labelStart := RSLabel text: 'start'.
	labelEnd := RSLabel text: 'end'.
	labelStart @ RSDraggable.
	labelEnd @ RSDraggable.
	c add: labelStart.
	c add: labelEnd.

	labelEnd translateBy: 80 @ 60.
	line := RSLine new.
	line from: labelStart.
	line to: labelEnd.
	line withBorderAttachPoint.
	line markerEnd: markerShape.

	c add: line.
	c zoomToFit.
	c open
]

{ #category : #'chapter-7 (Shapes)' }
RSIntro >> markerOffset [
	"Set the marker away from the extremity"

	"Run the example to see the results:
	
	RSintro new markerOffset
	
	"

	| c markerShape target starts line |
	c := RSCanvas new.

	markerShape := RSPolygon new
		               privatePoints: {
				               (-3 @ 9).
				               (0 @ 0).
				               (3 @ 9).
				               (0 @ 0) };
		               border: (RSBorder new width: 1);
		               asMarker.
	markerShape offsetRatio: 0.3.

	target := RSLabel text: 'target'.
	c add: target.

	starts := RSCircle models: (1 to: 20).
	starts @ RSDraggable.
	c addAll: starts.

	starts do: [ :startShape |
		line := RSLine new.
		line from: startShape.
		line to: target.
		line withBorderAttachPoint.
		line markerEnd: markerShape.
		c add: line
		].

	RSForceBasedLayout new
		charge: -300;
		on: c nodes.

	c zoomToFit.
	c open
]

{ #category : #'chapter-7 (Shapes)' }
RSIntro >> markreOffset [
	"Set the marker away from the extremity"

	"Run the example to see the results:
	
	RSintro new markerOffset
	
	"

	| c markerShape target starts line |
	c := RSCanvas new.

	markerShape := RSPolygon new
		               privatePoints: {
				               (-3 @ 9).
				               (0 @ 0).
				               (3 @ 9).
				               (0 @ 0) };
		               border: (RSBorder new width: 1);
		               asMarker.
	markerShape offsetRatio: 0.3.

	target := RSLabel text: 'target'.
	c add: target.

	starts := RSCircle models: (1 to: 20).
	starts @ RSDraggable.
	c addAll: starts.
	
	starts do: [ :startShape |
		line := RSLine new.
		line from: startShape.
		line to: target.
		line withBorderAttachPoint .
		line markerEnd: markerShape .
		c add: line. 
		].
	
	RSForceBasedLayout new charge: -300; on: c nodes.
	
	c zoomToFit.
	c open.
	
]

{ #category : #'chapter-6 (Canvas)' }
RSIntro >> menuToolbarWithFixedShapes [
	"Run the example to see the results:
	
		RSIntro new menuToolbarWithFixedShapes 
		
		"
	
	| c addLabel clearLabel changeColorLabel labels shape r |
	c := RSCanvas new.

	addLabel := RSLabel text: 'Add shapes'.
	clearLabel := RSLabel text: 'Clear'.
	changeColorLabel := RSLabel text: 'Change color'.

	c
		add: addLabel;
		add: clearLabel;
		add: changeColorLabel.

	addLabel setAsFixed.
	clearLabel setAsFixed.
	changeColorLabel setAsFixed.

	labels := RSGroup withAll: {
			          addLabel.
			          clearLabel.
			          changeColorLabel }.
	labels @ RSHighlightable red.
	RSHorizontalLineLayout on: labels.

	addLabel
		when: RSMouseClick
		do: [ :evt |
			10 timesRepeat: [
				shape := RSEllipse new size: 30.
				r := Random new.
				shape translateTo: (r nextInteger: 500) @ (r nextInteger: 500).
				c add: shape.
				c zoomToFit.
				c signalUpdate ] ]
		for: addLabel.

	clearLabel
		when: RSMouseClick
		do: [ :evt |
			c shapes do: #remove.
			c signalUpdate ]
		for: clearLabel.

	changeColorLabel
		when: RSMouseClick
		do: [ :evt |
			c shapes do: [ :s | s color: Color random translucent ].
			c signalUpdate ]
		for: changeColorLabel.

	c open
]

{ #category : #'chapter-7 (Shapes)' }
RSIntro >> model [
	"A shape can have a model object that it is intended to represent."

	"Run the examle to see the results:
	
		RSIntro new model
		
		"

	| c numbers circle |
	c := RSCanvas new.
	numbers := 1 to: 9.
	
	numbers do: [ :nb | 
		circle := RSCircle new.
		circle model: nb.
		circle @ RSPopup .
		c add: circle.
		].
	RSGridLayout on: c shapes.
	c zoomToFit .
	c open.
]

{ #category : #'chapter-9 (Shape Composition)' }
RSIntro >> modelLineBuilder [
	"Run the example to see the results:

	RSIntro new modelLineBuilder
	
	"

	| c classes boxes lb |
	classes := ByteArray withAllSubclasses.

	c := RSCanvas new.

	boxes := RSComposite models: classes forEach: [  :composite :cls |
		         composite add: (  RSLabel new text: cls name  ).
		         composite add:
			         (  RSBox new size: cls numberOfLinesOfCode sqrt + 5  ).
		         RSVerticalLineLayout new
			         alignCenter;
			         on: composite children.
		         composite @ RSDraggable
		         ].
	c addAll: boxes.
	
	lb := RSLineBuilder line.
	lb withVerticalAttachPoint .
	lb shapes: boxes .
	lb connectFrom: #superclass.

	RSTreeLayout on: c nodes.
	c @ RSCanvasController .
	c open
]

{ #category : #'chapter-7 (Shapes)' }
RSIntro >> modelNormalizer [
	"A shape can have a model object that it is intended to represent."

	"Run the examle to see the results:
	
		RSIntro new modelNormalizer
		
		"

	| c numbers circle |
	c := RSCanvas new.
	numbers := 1 to: 9.

	numbers do: [ :nb |
		circle := RSCircle new.
		circle model: nb.
		circle @ RSPopup.
		c add: circle
		].

	RSNormalizer size
		shapes: c nodes;
		from: 5;
		to: 20;
		normalize: #yourself.

	RSNormalizer color
		shapes: c nodes;
		from: Color gray;
		to: Color red;
		normalize: [ :aNumber | aNumber raisedTo: 3 ].

	RSGridLayout on: c shapes.
	c zoomToFit.
	c open
]

{ #category : #'chapter-9 (Shape Composition)' }
RSIntro >> modelObject [
"Run the example to see the results:

	RSIntro new modelObject
	
	"
	
	| c compShape |
	c := RSCanvas new.
	
	compShape := RSComposite model: 'Hello' 	forIt: [ :composite :title |
			composite add: (RSLabel text: title).
			composite add: (RSCircle new size: 20).
			RSVerticalLineLayout new alignCenter ; on: composite shapes.
			composite @ RSDraggable .
			].
		c add: compShape.
		c open.
]

{ #category : #'chapter-5 (Architecture Overview)' }
RSIntro >> normalizer [
	"Normalizers map numerical values to visualize attributes"

	"Run this method to see the results:

	RSIntro new normalizer
	
	"

	| values c shapes |
	values := #( 20 30 40 50 10 ).

	c := RSCanvas new.
	shapes := RSEllipse models: values.

	shapes @ RSPopup. "Add popup window to shapes"
	shapes @ RSLabeled. "Add labels to shapes"
	
	c addAll: shapes.

	"Add normalizer based to size value"
	RSNormalizer size
		shapes: shapes;
		from: 20;
		to: 30;
		normalize.

	"Add normalizer based on color value"
	RSNormalizer color
		shapes: shapes;
		normalize.

	"Layout of the shapes"
	RSGridLayout new
		gapSize: 40;
		on: shapes.


	c @ RSCanvasController.
	c open
]

{ #category : #'chapter-7 (Shapes)' }
RSIntro >> polygon [
"Run the example to see the results:

	RSIntro new polygon.
	
	"
	| c polygon polygon2 |
	c := RSCanvas new.
	polygon := RSPolygon new
		           points: {
				           (0 @ -50).
				           (50 @ 0).
				           (-50 @ 0) };
		           color: 'FFAE0B'.

	polygon cornerRadii: 5.
	polygon @ RSDraggable.

	polygon2 := RSPolygon new
		            points: {
				            (0 @ -50).
				            (50 @ 0).
				            (-50 @ 0) };
		            color: Color red translucent.
	polygon2 @ RSDraggable.

	polygon2 rotateByDegrees: 90.
	polygon2 translateBy: 0 @ -50.

	c
		add: polygon;
		add: polygon2.
	c zoomToFit.
	c open
]

{ #category : #'chapter-6 (Canvas)' }
RSIntro >> removeWindow [
	"Removing the window from the Pharo environement"

	"Run the example to see the results:
	
		RSIntro new removeWindow 
		
		"

	| c lbl win |
	c := RSCanvas new.
lbl := RSLabel text: 'Click on me to close the window'.
lbl fontSize: 30.
lbl @ RSHighlightable red.
c add: lbl.
win := c open.
win extent: 600 @ 100.
lbl when: RSMouseClick do: [ :evt | win delete ] for: lbl.

]

{ #category : #'chapter-7 (Shapes)' }
RSIntro >> rotation [
"Run the example to see the results:

	RSIntro new rotation.
	
	"

	| c lbl |
	c := RSCanvas new.
	(0 to: 90 count: 10) do: [ :rotation |
		lbl := RSLabel text: 'Hello there'.
		lbl color: Color gray translucent.
		lbl rotateByDegrees: rotation.
		lbl @ RSHighlightable red.
		lbl translateTopLeftTo: 0 @ 0.
		c add: lbl
		].

	c @ RSCanvasController.
	c open
]

{ #category : #'chapter-9 (Shape Composition)' }
RSIntro >> shapeBorder [
	"Run the example to see the results:

	RSIntro new shapeBorder
	
	"

	| c g compositeShape |
	c := RSCanvas new.
	1 to: 10 do: [ :i |
		g := RSGroup new.
		i timesRepeat: [ g add: RSCircle new ].
		RSFlowLayout on: g.
		compositeShape := g asShape.
		compositeShape borderColor: Color black.
		compositeShape padding: 5.
		c add: compositeShape .
		].

	RSGridLayout new
		gapSize: 50;
		on: c shapes.
	c shapes @ RSDraggable @ RSHighlightable red.
	c zoomToFit.
	c open
]

{ #category : #'chapter-5 (Architecture Overview)' }
RSIntro >> shapes [
"Execute this method to see the results:
	
	RSIntro new shapes
	
	"
	
	| box canvas |
	box := RSBox new
		       size: 80;
		       color: #yellow;
		       border: (RSBorder new
				        color: #blue;
				        width: 10).

	canvas := RSCanvas new.
	canvas add: box.
	canvas open
]

{ #category : #'chapter-5 (Architecture Overview)' }
RSIntro >> shapesWithTitle [
	"Execute this method to see the results:
	
	RSIntro new shapesWithTitle
	
	"

	RSCanvas new 
		add: (RSBox new size: 100; color: #blue);
		openWithTitle: 'This is a blue box'.
]

{ #category : #'chapter-2' }
RSIntro >> sunburst [
	"Execute this method to see the results: 
	
	RSIntro new sunburst
	
	"

	| sb |
	sb := RSSunburstBuilder new.
	sb sliceShape withBorder.
	sb sliceColor: [ :shape |
		shape model subclasses isEmpty
			ifTrue: [ Color purple ]
			ifFalse: [ Color lightGray ] ].
	sb explore: Collection using: #subclasses.
	sb build.
	sb canvas @ RSCanvasController.

	RSLineBuilder sunburstBezier
		width: 2;
		color: Color black;
		markerEnd: (RSEllipse new
				 size: 10;
				 color: Color white;
				 withBorder;
				 yourself);
		canvas: sb canvas;
		connectFrom: #superclass.

	sb canvas open
]

{ #category : #'chapter-7 (Shapes)' }
RSIntro >> svgPath [
	"Run the example to see the results: 
	
	RSIntro new svgPath
	
	"

	| c svgPath svg |
	c := RSCanvas new.

	svgPath := 'M 10 80 C 40 10, 65 10, 95 80 S 150 150, 180 80'.
	svg := RSSVGPath new svgPath: svgPath.
	
	c add: svg.
	c @ RSCanvasController.
	c open.
]

{ #category : #'chapter-6 (Canvas)' }
RSIntro >> virtualSpace [
"Run the example to see the results:
	
	RSIntro new virtualSpace 
	
	"
	| points canvas point win |
	
	points := 
		{ { 'Center' 			. 0 @ 0 }
		. { 'Top' 				. 0 @ -150 }
		. { 'Top Left' 		. -150 @ -150 }
		. { 'Top Right'		. 150 @ -150 }
		. { 'Bottom' 			. 0 @ 150 }
		. { 'Bottom left' 	. -150 @ 150 }
		. { 'Bottom right' . 150 @ 150 }
		}.
	
	canvas := RSCanvas new.
	points do: [ :tupple |
		point := RSCircle new.
		point translateTo: tupple second.
		point @ (RSLabeled text: tupple first , tupple second asString).
		canvas add: point
		].

	canvas add: (RSLine new
			 dashed;
			 color: Color red;
			 from: 0 @ -200;
			 to: 0 @ 200).
	canvas add: (RSLine new
			 dashed;
			 color: Color red;
			 from: -200 @ 0;
			 to: 200 @ 0).

	canvas @ RSCanvasController.
	win := canvas open.
	win extent: 600 @ 600.
]

{ #category : #'chapter-2' }
RSIntro >> visualizeFileExtensions [

| path extensions allFilesUnderPath c |
path := '/home/andy/Downloads'.
extensions := 
	{ 'pdf' -> Color red 
	. 'mov' -> Color blue
	. 'ttf' -> Color green
	} asDictionary.
	
allFilesUnderPath := path asFileReference allChildren.

c := RSCanvas new.

allFilesUnderPath do: [ :aFile |
	| s color |
	s := RSEllipse model: aFile.
	color := extensions at: aFile path extension
													ifAbsent: [ Color gray ].
	s color: color translucent.
	s @ RSPopup @ RSDraggable.
	c add: s. ].	

RSNormalizer size
	shapes: c nodes;
	from: 10; to: 30;
	normalize: [ :aFile | aFile size sqrt ].
	
RSLineBuilder line 
	shapes: c nodes;
	connectFrom: #parent.
	
RSClusterTreeLayout  on: c nodes.

c @ RSCanvasController .
c open
]

{ #category : #'chapter-4' }
RSIntro >> visualizingClasses [
	"Execute this method to see the results: 
	
	RSIntro new visualizingClasses 
	
	"

	| classes c |
	"The variable classes containes the classes we would like to visualize "
	classes := Collection withAllSubclasses.

	"A canvas is a container of graphical shapes"
	c := RSCanvas new.

	"Each class is represented as a box"
	classes do: [ :aClass | c add: (RSBox new model: aClass) ].

	"The width of each class indicates the number of variables defined in the class"
	RSNormalizer width
		shapes: c shapes;
		from: 6;
		to: 20;
		normalize: #numberOfVariables.

	"Height of each class represents the number of methods"
	RSNormalizer height
		shapes: c shapes;
		normalize: #numberOfMethods.

	"A class color goes from grey to red, indicating the number of lines of code"
	RSNormalizer color
		shapes: c shapes;
		from: Color gray;
		to: Color red;
		normalize: #numberOfLinesOfCode.

	"Vertical lines indicate the inheritance relationship"
	RSLineBuilder orthoVertical
		canvas: c;
		withVerticalAttachPoint;
		color: Color lightGray;
		connectFrom: #superclass.

	"Use tree layout to adequately locate the classes"
	RSTreeLayout on: c nodes.

	"We make all the classes draggable and with contectual popup window"
	c nodes @ RSDraggable @ RSPopup.

	"The whole visualization os zoomable, draggable and shapse may be searched in it"
	c @ RSCanvasController.
	c open.
]
