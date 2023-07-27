"
Class:
	I am the reinforcement learning algorithm for Q-Learning 
	
Responsibility:
	Implement the algorithmic parts of the Reinforcement Learning 
	
Collaborators: 
	My main collaborators are the RLGrid class and RLState class
	
Internal Representation and Key Implementation Points:
		• startState - defines the starting state of the algorithm. Each episode
							(unit of exploration in RL) starts from this state			
		• r - Random Number Generator
		• numberOfEpisodes - number of episodes the algorithms has to run for
		• maxEpisodeSteps - number of steps the knight has to make during each episode
		• minAlpha - minimum value of the decreasing learning ramp
		• gamma - discount of the reward
		• epsilon - probability of shoosing a random action when acting
		• qTable - dictionary that models the QTable and contains state as keys and 
						rewards as values (each action is associates with a reward)
		• rewards - list the accumulated rewards obtained during the episodes
		• path - the path of the knight to exit the grid
		• stateConnections - all the transitions between the states
		 
"
Class {
	#name : #RL,
	#superclass : #Object,
	#instVars : [
		'startState',
		'r',
		'numberOfEpisodes',
		'maxEpisodeSteps',
		'minAlpha',
		'gamma',
		'epsilon',
		'qTable',
		'rewards',
		'path',
		'stateConnections'
	],
	#category : #ReinforcementLearning
}

{ #category : #initialization }
RL >> act: aState action: action [
    "Produce a new tuple { stable . reward . isDone } "

    | reward newGrid p gridItem isDone newState |
    p := self moveKnight: aState action: action.
    gridItem := aState grid atPosition: p.
    newGrid := aState grid copy.
    gridItem = $m ifTrue: [
        reward := -100.
        isDone := true  ].
    gridItem = $e ifTrue: [
        reward := 1000.
        isDone := true  ].

    (  'me' includes: gridItem  ) ifFalse: [
        reward := -1.
        isDone := false  ].

    newState := RLState new
                    grid: newGrid;
                    position: p.
    stateConnections add: aState -> newState.
    ^ {
          newState.
          reward.
          isDone  }
]

{ #category : #initialization }
RL >> actions [
	"Return the considered actions"
	
	^ #(1 2 3 4)
]

{ #category : #initialization }
RL >> chooseAction: state [
    "Choose an action for a given state"

    ^ r next < epsilon
          ifTrue: [  self actions atRandom: r  ]
          ifFalse: [  "Return the best action"
          (  self qState: state  ) argmax  ]
]

{ #category : #initialization }
RL >> epsilon: aFloat [
"Set the probability to explore the world. The argument is between 0.0 and 1.0.
A value close to 0.0 favors choosing an action that we know is a good one (thus 
reducing the exploration of the grid). A value close to to 1.0 favors the world 
exploration instead."

	epsilon := aFloat.
]

{ #category : #initialization }
RL >> example [
    "Run the example to see the results:

	RL new example inspect
	
	"

    | rl |
    rl := RL new.
    rl setInitialGrid: RLGrid new.
    rl run.
    ^ rl
]

{ #category : #initialization }
RL >> exampleEpsilon [
    "Run the example to see the results:

	RL new exampleEpsilon inspect
	
	"

    | rl |
    rl := RL new.
    rl setInitialGrid: (  RLGrid new
               setSize: 5;
               setMonsters: 2  ).
    rl epsilon: 0.01.
rl numberOfEpisodes: 7.
    rl run.
    ^ rl
]

{ #category : #initialization }
RL >> exampleLarge [
    "Run the example to see the results:

	RL new exampleLarge inspect
	
	"

    | rl |
    rl := RL new.
    rl setInitialGrid: (RLGrid new setSize: 5; setMonsters: 2).
    rl run.
    ^ rl
]

{ #category : #initialization }
RL >> initialize [ 
	super initialize.
	r := Random seed: 42.
	numberOfEpisodes := 20.
	maxEpisodeSteps := 100.
	minAlpha := 0.02.
	gamma := 1.0.
	epsilon := 0.2.
	qTable := Dictionary new.
	rewards := OrderedCollection new.
	path := OrderedCollection new.
	stateConnections := OrderedCollection new.
	
]

{ #category : #initialization }
RL >> inspectorGraph [ 
<inspectorPresentationOrder: 90 title: 'State graph' >
^ SpRoassal3InspectorPresenter new
	canvas: self visualizeGraph
	yourself.
]

{ #category : #initialization }
RL >> inspectorGraphContext: aContext [

	aContext withoutEvaluator 
]

{ #category : #initialization }
RL >> inspectorQTable [
<inspectorPresentationOrder: 90 title: 'QTable'>

^ SpRoassal3InspectorPresenter new
	canvas: self visualizeQTable ;
	yourself.
]

{ #category : #initialization }
RL >> inspectorQTableContext: aContext [

   aContext withoutEvaluator 
]

{ #category : #initialization }
RL >> inspectorResult [
<inspectorPresentationOrder: 90 title: 'Result'>

	^ SpRoassal3InspectorPresenter new
		canvas: self visualizeResult ;
		yourself.
]

{ #category : #initialization }
RL >> inspectorResultContext: aContext [
	aContext withoutEvaluator 
]

{ #category : #initialization }
RL >> inspectorReward [
<inspectorPresentationOrder: 90 title: 'Reward'>
^ SpRoassal3InspectorPresenter new
	canvas: self visualizeReward ;
	yourself
]

{ #category : #initialization }
RL >> inspectorRewardContext: aContext [
	aContext withoutEvaluator 
]

{ #category : #initialization }
RL >> inspectorWeightedGraph [
<inspectorPresentationOrder: 90 title: 'Wieghted state graph' >

^ SpRoassal3InspectorPresenter new
	canvas: self visualizeWeightedGraph;
	yourself
]

{ #category : #initialization }
RL >> inspectorWeightedGraphContext: aContext [

	aContext withoutEvaluator 
]

{ #category : #initialization }
RL >> maxEpisodesStep: anInteger [
"Indicate how long an exploration can be"

	maxEpisodeSteps := anInteger
]

{ #category : #initialization }
RL >> moveKnight: state action: action [
    "Return new position as a point. The action is a number from 1 to 4. Return a new position"

	| delta |
	delta := { 0 @ -1 . 0 @ 1 . -1 @ 0 . 1 @ 0 }
		at: action ifAbsent: [ self error: 'Unkown action' ].
	^ ( (state position + delta) min: state grid extent ) max: 1 @ 1.

    
]

{ #category : #initialization }
RL >> numberOfEpisodes: aNumber [
"Set the number of explorations we ned to perform"

 numberOfEpisodes := aNumber
]

{ #category : #initialization }
RL >> play [
	"Return the position of the car"
	| currentState isDone actions tuple maxNumberOfSteps numberOfSteps |
	currentState := startState.
	isDone := false.
	path := OrderedCollection new.
	path add: currentState position.
	maxNumberOfSteps := 100.
	numberOfSteps := 0.
	[ isDone not and: [ numberOfSteps < maxNumberOfSteps ] ]
		whileTrue: [ 
			actions := self qState: currentState .
			tuple := self act: currentState action: actions argmax.
			currentState := tuple first.
			path add: currentState position.
			isDone := tuple third.
			numberOfSteps := numberOfSteps + 1 
			].
		
	^ path asArray 
]

{ #category : #initialization }
RL >> qState: aState [
    "Return the rewards associated to a state. If the state is not in the qTable, we create it"

    qTable at: aState ifAbsentPut: [ Array new: self actions size withAll: 0 ].
	^ qTable at: aState
]

{ #category : #initialization }
RL >> qState: aState action: action [
    "For a particular state, return the reward of an action. 
	If the state is not in the qTable, we create it"

    qTable
        at: aState
        ifAbsentPut: [ (1 to: self actions 	size) collect: [ :nU | 0 ] ].
    ^ (qTable at: aState) at: action
]

{ #category : #initialization }
RL >> run [
    "This method is the core of the Q-Learning algorithm"
	| alphas currentState totalReward alpha isDone currentAction tuple nextState currentReward |
	alphas := (minAlpha to: 1.0 count: numberOfEpisodes) reversed.
	rewards := OrderedCollection new.
	1 to: numberOfEpisodes do: [ :e |
		currentState := startState.
		totalReward := 0.
		alpha := alphas at: e.
		isDone := false.
		maxEpisodeSteps timesRepeat: [ 
			isDone ifFalse: [ 
				currentAction := self chooseAction: currentState.
				tuple := self act: currentState action: currentAction.
				nextState := tuple first.
				currentReward := tuple second.
				isDone := tuple third.
				totalReward := totalReward + currentReward.
				
				"The Bellman equation"
				(self qState: currentState) at: currentAction put: (
					(self qState: currentState action: currentAction) 
					+ 
					(alpha * (currentReward + (gamma * (self qState: nextState) max) 
					- 
					(self qState: currentState action: currentAction)))).
				currentState := nextState
			]
		].
		rewards add: totalReward.
	].
	rewards := rewards asArray.
	^ rewards
]

{ #category : #initialization }
RL >> setInitialGrid: aGrid [
"Set the grid used in the initial state"
	startState := RLState new grid: aGrid.
]

{ #category : #initialization }
RL >> visualizeGraph [

    | associations allStates dict mondrian |
    associations := stateConnections asSet asArray.
    dict := Dictionary new.
    associations do: [  :assoc |
        (  dict at: assoc key ifAbsentPut: [  OrderedCollection new  ]  )
            add: assoc value  ].
    allStates := qTable keys.
    mondrian := RSMondrian new.
    mondrian shape circle.
    mondrian nodes: allStates.
    mondrian line connectToAll: [  :aState |			"Return the list of connected states"
        dict at: aState ifAbsent: [  #(    )  ]  ].
    mondrian layout force.
    mondrian build.
    ^ mondrian canvas
]

{ #category : #initialization }
RL >> visualizeQTable [

	| c state values allBoxes sortedAssociations |
	c := RSCanvas new.
	
	c add: (RSLabel text: 'State').
	c add: (RSLabel text: '^').
	c add: (RSLabel text: 'V').
	c add: (RSLabel text: '<').
	c add: (RSLabel text: '>').
	
	sortedAssociations := qTable associations reverseSortedAs: [ :assoc |
		assoc value average. ].
	sortedAssociations do: [ :assoc |
		state := RSLabel model: assoc key.
		values := RSBox models: (assoc value collect: [ :v | v round: 2 ])
					 forEach: [ :s :m | s extent: 40 @ 20 ].
		c add: state.
		c addAll: values.
	].

	RSCellLayout new lineItemsCount: 5; gapSize: 1; on: c shapes.
	allBoxes := c shapes select: [ :s | s class == RSBox ].
	RSNormalizer color 
		shapes: allBoxes;
		from: Color red darker darker; 
		to: Color green darker darker;
		normalize.
	allBoxes @ RSLabeled middle.
	^ c @ RSCanvasController 
]

{ #category : #initialization }
RL >> visualizeResult [
    "Assume that the method play was previously invoked"

    | c s |
    self play.
    c := startState visualize.
    path do: [  :p |
        s := RSCircle new
                 size: 5;
                 color: Color blue lighter.
        c add: s.
        s translateTo: p - (  0.5 @ 0.5  ) * 20  ].

    ^ c @ RSCanvasController
]

{ #category : #initialization }
RL >> visualizeReward [
	| c plot |
	c := RSCompositeChart new.
	plot := RSLinePlot new.
	plot y: rewards.
	
	c add: plot.
	c addDecoration: (RSChartTitleDecoration new title: 'Reward evolution'; fontSize: 20).
	c xlabel: 'Episode' offset: 0 @ 10.
	c ylabel: 'Reward' offset: -20 @ 0.
	c addDecoration: (RSHorizontalTick new).
	c addDecoration: (RSVerticalTick new).
	c build.
	^ c canvas
]

{ #category : #initialization }
RL >> visualizeWeightedGraph [
    "Complementary visualization to associate some metrics with each state"

	| associations allStates dict mondrian |
	associations := stateConnections asSet asArray.
	dict := Dictionary new.
	associations do: [ :assoc |
		(dict at: assoc key ifAbsentPut: [ OrderedCollection new ] ) add: assoc value ].
	allStates := qTable keys.
	
	mondrian := RSMondrian new.
	mondrian shape circle.
	mondrian nodes: allStates .
	mondrian line connectToAll: [ :aState | dict at: aState ifAbsent: [ #() ] ].
	
	mondrian normalizeSize: [ :aState | (qTable at: aState) average ] from: 5 to: 30.
	mondrian normalizeColor: [ :aState | (qTable at: aState) max ] from: Color gray to: Color green.
	
	mondrian layout force.
	mondrian build.
	^ mondrian canvas
	    
]
