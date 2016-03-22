---------------------------------------------------------------------------------
--
-- game.lua
--
---------------------------------------------------------------------------------

local sceneName = ...

local composer = require( "composer" )
local Botao = require( "Botao" )


local dilma
local roda
local ponteiro
local btnHit
local angulo = 0
local maxRot = 90
local minRot = -90
local metaSpeed = -0.5
local actSpeed = metaSpeed
local ativo = true


-- Load scene with same root filename as this file
local scene = composer.newScene(  )


local function listener( event )
    ponteiro:rotate( actSpeed )

    if (ponteiro.rotation <= minRot) then
        actSpeed = 0
        ativo = false
        Runtime:removeEventListener( "enterFrame", listener )
    elseif (ponteiro.rotation >= maxRot) then
        actSpeed = 0
        ativo = false
        Runtime:removeEventListener( "enterFrame", listener )
    end
end 


local function infla(  )
    transition.to( dilma, {xScale=0.3,yScale=0.28, time=100, onComplete=function (  )
        transition.to( dilma, {xScale=0.35,yScale=0.35,time=100} )
    end} )
end

local function hit( event )
    actSpeed = (metaSpeed*(-1))+1
    timer.performWithDelay( 50, function (  )
        actSpeed = metaSpeed
        if (ativo == true) then
            infla()  
        end
    end ,1 )
end

-------------------------------------------------------------------------------------------
function scene:create( event )
    local sceneGroup = self.view

 
end

function scene:show( event )
    local sceneGroup = self.view
    local phase = event.phase


    if phase == "will" then
        dilma = display.newImage( "dilma.png" )
        dilma:scale( 0.35, 0.35)
        dilma.x = display.contentCenterX
        dilma.y = display.contentCenterY/1.1

        roda = display.newImage( "dashmeterinverse.png" )
        roda.x = display.contentCenterX
        roda.y = display.contentHeight-100
        roda.anchorY = 1
        roda.width = display.contentWidth
        roda.height = display.contentCenterY*0.5
        roda.alpha = 0.8

        ponteiro = display.newRect( display.contentCenterX, display.contentHeight-100, 5 , display.contentWidth/2.5)
        ponteiro:setFillColor( 0,0,0 )
        ponteiro.anchorY = 1
        ponteiro:rotate( 0 )

        btnHit = Botao.new("Hit", 92)
        

    elseif phase == "did" then
        local prevScene = composer.getSceneName( "previous" )
        if (prevScene) then
            composer.removeScene( prevScene )
        end

        btnHit:addEventListener( "tap", hit )
        Runtime:addEventListener( "enterFrame", listener )

        sceneGroup:insert( dilma )
        sceneGroup:insert( roda )
        sceneGroup:insert( ponteiro )
        sceneGroup:insert( btnHit )

    end 
end

function scene:hide( event )
    local sceneGroup = self.view
    local phase = event.phase

    if event.phase == "will" then
        -- Called when the scene is on screen and is about to move off screen
        --
        -- INSERT code here to pause the scene
        -- e.g. stop timers, stop animation, unload sounds, etc.)
        

    elseif phase == "did" then
        -- Called when the scene is now off screen

    end 
end


function scene:destroy( event )
    local sceneGroup = self.view

    -- Called prior to the removal of scene's "view" (sceneGroup)
    -- 
    -- INSERT code here to cleanup the scene
    -- e.g. remove display objects, remove touch listeners, save state, etc
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

---------------------------------------------------------------------------------

return scene