# Background
backgroundColor = new BackgroundLayer
	parent: MainScreen
	backgroundColor: "rgba(255,223,189,1)"
	
# Create new Layer for text title
title = new Layer
	parent: MainScreen
	html: "<p>CLICK THE RED DOT</p>"
	x: Align.center
	y: 15
	backgroundColor: null
	style:
		fontSize: "18px"
		fontWeight: "300"
		color: "black"
		fontFamily: "Roboto"
		textAlign: "center"
		
# Create new Layer for text subtitle
subtitle = new Layer
	parent: MainScreen
	html: "<p>and see what book am I reading</p>"
	x: Align.center
	y: 40
	backgroundColor: null
	style:
		fontSize: "12px"
		color: "black"
		fontWeight: "200"
		fontFamily: "Roboto"
		textAlign: "center"
		
# Create new Layer for text swipe instruction
swipeText = new Layer
	parent: MainScreen
	html: "<p>swipe to see another books</p>"
	x: Align.center
	y: 610
	backgroundColor: null
	style:
		fontSize: "12px"
		color: "black"
		fontWeight: "200"
		fontFamily: "Roboto"
		textAlign: "center"
	
# Class
# Create a class called Card
class Card extends Layer
	# Class constructor, creating properties of the class
	# {} means the properties are default values if no argument is passed
	constructor: (options={}) ->
		# Set default values of Card
		options.width = 300
		options.height = 500
		options.backgroundColor = "rgba(255, 255, 255, 1)"
		options.borderRadius = 10
		options.clip = true
		
		# Super is used to call the function in parent class
		super options
		
		# Set p5.js Canvas
		# Creating new layer called p5Canvas		
		p5Canvas = new Layer
			parent: @
			html: "<iframe width='300' height='500' src='http://alpha.editor.p5js.org/embed/HJ4671mpZ'></iframe>" # Embed p5.js file
			width: 300
			height: 500
			delay: 1
			backgroundColor: "rgba(230,230,230,1)"
		
		# Fade out p5Canvas when the button is clicked
		p5Canvas.states.add
			hide:
				opacity: 0
				
		# Set an image canvas default properties
		# Create a canvas for image
		canvas = new Layer
			parent: @
			x: 0
			y: 305
			width: @.width
			image: options.photo
			backgroundColor: "rgba(220,245,255,1)"
			scale: 1
					
		# Scale up the canvas when the button is clicked
		# It will be moved to the next state
		canvas.states.add
			fullScreen:
				width: @.width
				height: @.height
				x: 0
				y: 0
				scale: 1
		
		# Set button default properties
		# Create new layer for button
		button = new Layer
			parent: @
			width: 70
			height: 70
			backgroundColor: "rgba(255,104,105,1)"
			borderRadius: 100
			x: Align.center()
			y: 270
			
		# Fade out button when it is clicked
		# It will be moved to the next state
		button.states.add
			hide:
				opacity: 0.5
				y: 20
		
		# A function that will be called when the button is tapped
		button.onTap ->
			button.states.next("hide", "default")
			canvas.states.next("fullScreen", "default")
			p5Canvas.states.next("hide", "default")

# Arrays
# Create arrays to fill in the Cards
canvases = ["http://www.cristinburton.com/uploads/7/1/3/3/71331791/1968615_orig.jpg", "https://i.pinimg.com/originals/6f/f1/ba/6ff1baee2f59d2fa015b0c2aa57da4c3.jpg", "https://craigmod.com/images/journal/coccyx/aba-04.png", "https://i.pinimg.com/originals/48/d9/6c/48d96c502714e63cd2dcffb4b8fc0406.jpg"]

# Components
# Pages
page = new PageComponent
	parent: MainScreen
	y: 0
	width: 375
	height: 677
	scrollVertical: false

# Generating the Cards
for i in [0..3]
	drawing = new Layer
		parent: page.content
		width: Screen.width
		height: Screen.height
		backgroundColor: null
		x: page.width * i
		
	# Create Card class
	card = new Card
		parent: drawing
		photo: canvases[i]
		y: Align.center()
		x: Align.center()