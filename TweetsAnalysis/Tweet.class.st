Class {
	#name : #Tweet,
	#superclass : #Object,
	#instVars : [
		'content',
		'sender',
		'date'
	],
	#category : #TweetsAnalysis
}

{ #category : #'as yet unclassified' }
Tweet class >> createFromExample [
"Method to be defined on the class side"

| url |
url := 'http://agilevisualization.com',
		'/AgileVisualization/tweets.csv'.
^ self createFromURL: url.
]

{ #category : #'as yet unclassified' }
Tweet class >> createFromURL: urlAsString [
	"Method to be defines on the class side"

	| content lines sender date |
	content := (ZnEasy get: urlAsString) contents readStream.
	lines := content contents lines collect: [ :l |
		         | firstCommaIndex secondCommaIndex |
		         firstCommaIndex := l indexOf: $,.
		         secondCommaIndex := l
			                             indexOf: $,
			                             startingAt: firstCommaIndex + 1.

		         sender := l copyFrom: 1 to: firstCommaIndex - 1.
		         date := l
			                 copyFrom: firstCommaIndex + 1
			                 to: secondCommaIndex - 1.
		         content := l copyFrom: secondCommaIndex + 1 to: l size.
		         {
			         sender.
			         date.
			         content } ].
		
^ lines collect: [ :line |
	Tweet new sender: line first; date: line second; content: line third ]
]

{ #category : #accessing }
Tweet >> content [ 
	^ content
]

{ #category : #accessing }
Tweet >> content: aContent [
content := aContent 
]

{ #category : #accessing }
Tweet >> date [
^ date
]

{ #category : #accessing }
Tweet >> date: aDate [
date := aDate
]

{ #category : #example }
Tweet >> example [
	"Run the code below to see an example:
	
	Tweet new example
	"

	| tweets tweetShapes c |
	tweets := Tweet createFromExample.
	tweetShapes := RSCircle models: tweets forEach: [ :aCircle :aTweet |
		               aTweet isPositive ifTrue: [
			               aCircle color: Color green ].
		               aTweet isNegative ifTrue: [ aCircle color: Color red ] ].

	tweetShapes translucent.

	c := RSCanvas new.
	c addAll: tweetShapes.
	RSLineBuilder line
		shapes: c nodes;
		color: Color gray translucent;
		withBorderAttachPoint;
		moveBehind;
		noBidirectional;
		connectToAll: [ :tweet |
			tweets select: [ :t | t isSimilarTo: tweet ] ].

	c nodes @ RSPopup @ RSDraggable.

	RSNormalizer size
		shapes: c nodes;
		from: 5;
		to: 15;
		normalize: [ :tweet | tweet content size ].

	RSConditionalLayout new
		ifNotConnectedThen: RSGridLayout new;
		else: RSForceBasedLayout new;
		on: c nodes.

	c @ RSCanvasController.
	c open
]

{ #category : #accessing }
Tweet >> isNegative [

	^ #( 'bad' , 'worse' , 'down' , 'no')
		  includesAny: self words
]

{ #category : #accessing }
Tweet >> isPositive [
^	 #( 'great'
	 	, 'cool'
		, 'super'
		, 'fantastic'
		, 'good'
		, 'yes'
		, 'ok'
		) includesAny: self words.
]

{ #category : #accessing }
Tweet >> isSimilarTo: aTweet [
^ (self words intersection: aTweet words) size >= 4.
]

{ #category : #accessing }
Tweet >> printOn: str [

	| whatToPrint |
	whatToPrint := self content
									ifNil: [ 'Empty' ]
									ifNotNil: [ self content ].
	str nextPutAll: whatToPrint 
]

{ #category : #accessing }
Tweet >> sender [ 
^ sender
]

{ #category : #accessing }
Tweet >> sender: aSender [

sender := aSender 
]

{ #category : #accessing }
Tweet >> words [
"Return the list of strings contained in a tweet"
^ self content substrings
]
