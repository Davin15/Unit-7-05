-----------------------------------------------------------------------------------------
--
-- main.lua
--ByDavin Rousseau
-- created on apr.18th/2019
-- program allows character to move based on touch events and physics without falling off the screen
-----------------------------------------------------------------------------------------
display.setDefault("background", 0, 1, 2)
-- Character move

local dPad = display.newImageRect( "assets/d-pad.png", 100, 80 )
dPad.x = 120
dPad.y = 280
dPad.id = "d-pad"

local upArrow = display.newImageRect( "assets/upArrow.png", 30, 20 )
upArrow.x = 120
upArrow.y = 250
upArrow.id = "up arrow"

local downArrow = display.newImageRect( "assets/downArrow.png", 30, 20 )
downArrow.x = 120
downArrow.y = 310
downArrow.id = "down arrow"

local leftArrow = display.newImageRect( "assets/leftArrow.png", 30, 20 )
leftArrow.x = 92
leftArrow.y = 280
leftArrow.id = "left arrow"

local rightArrow = display.newImageRect( "assets/rightArrow.png", 30, 20 )
rightArrow.x = 152
rightArrow.y = 280
rightArrow.id = "right arrow"

local physics = require( "physics" )
physics.start()
physics.setGravity( 0, 25 ) -- ( x, y )

local leftWall = display.newRect( 0, display.contentHeight, 50, 1000, 1, display.contentHeight )
-- myRectangle.strokeWidth = 10
-- myRectangle:setFillColor( 0.5 )
-- myRectangle:setStrokeColor( 1, 0, 0 )
leftWall.alpha = 1
physics.addBody( leftWall, "static", { 
    friction = 1.5, 
    bounce = 0.
    } )


local theCharacter = display.newImageRect( "assets/character.png", 80, 100 )
theCharacter.x = 150
theCharacter.y = 180
theCharacter.id = "the character"
physics.addBody( theCharacter, "dynamic", { 
    density = 3.0, 
    friction = 0.5, 
    bounce = 0.3 
    } )
theCharacter.isFixedRotation = true

local theGround = display.newImageRect( "assets/land.png", 300, 125 )
theGround.x = display.contentCenterX 
theGround.y = display.contentHeight
theGround.id = "the ground"
physics.addBody( theGround, "static", { 
    friction = 0.5, 
    bounce = 0.3 
    } )

local landSquare = display.newImage( "assets/landSquare.png", 100, 125 )
landSquare.x = 80
landSquare.y = display.contentHeight - 230
landSquare.id = "land Square"
physics.addBody( landSquare, "dynamic", { 
    friction = 0.5, 
    bounce = 0.3 
    } )
 
 local jumpButton = display.newImageRect( "assets/jumpButton.png", 100, 80 )
jumpButton.x = display.contentWidth - 80
jumpButton.y = display.contentHeight - 250
jumpButton.id = "jump button"
jumpButton.alpha = 1

function upArrow:touch( event )
    if ( event.phase == "ended" ) then
        -- move the character up
        transition.moveBy( theCharacter, { 
        	x = 0, -- move 0 in the x direction 
        	y = -50, -- move up 50 pixels
        	time = 100 -- move in a 1/10 of a second
        	} )
    end

    return true
end



function downArrow:touch( event )
    if ( event.phase == "ended" ) then
        -- move the character up
        transition.moveBy( theCharacter, { 
        	x = 0, -- move 0 in the x direction 
        	y = 50, -- move down 50 pixels
        	time = 100 -- move in a 1/10 of a second
        	} )
    end

    return true
end



function leftArrow:touch( event )
    if ( event.phase == "ended" ) then
        -- move the character up
        transition.moveBy( theCharacter, { 
        	x = -50, -- move 50 pixels in the x direction "left" 
        	y = 0, -- move 0 pixels in y direction
        	time = 100 -- move in a 1/10 of a second
        	} )
    end

    return true
end



function rightArrow:touch( event )
    if ( event.phase == "ended" ) then
        -- move the character up
        transition.moveBy( theCharacter, { 
        	x = 50, -- move 50 pixels in the x direction "right" 
        	y = 0, -- move 0 pixels in y direction
        	time = 100 -- move in a 1/10 of a second
        	} )
    end
    

    return true
end

 

function jumpButton:touch( event )
    if ( event.phase == "ended" ) then
        -- make the character jump
        theCharacter:setLinearVelocity( 0, -450 )
    end

    return true
end

local function characterCollision( self, event )
 
    if ( event.phase == "began" ) then
        print( self.id .. ": collision began with " .. event.other.id )
 
    elseif ( event.phase == "ended" ) then
        print( self.id .. ": collision ended with " .. event.other.id )
    end
end

upArrow:addEventListener( "touch", upArrow )
downArrow:addEventListener( "touch", downArrow )
leftArrow:addEventListener( "touch", leftArrow )
jumpButton:addEventListener( "touch", jumpButton )
rightArrow:addEventListener( "touch", rightArrow )

theCharacter.collision = characterCollision
theCharacter:addEventListener( "collision" )