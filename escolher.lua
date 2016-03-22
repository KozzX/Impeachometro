---------------------------------------------------------------------------------
--
-- login.lua
--
---------------------------------------------------------------------------------

local sceneName = ...

local composer = require( "composer" )
local Botao = require( "Botao" )


-- Load scene with same root filename as this file
local scene = composer.newScene(  )

local btnPlay
local ficaDilma
local foraDilma
local txtFica
local txtFora
local txtPergunta

local function jogar( event )
	btnPlay:removeEventListener( "tap", jogar )
	composer.gotoScene( "game", "fade", 500 )  
end


---------------------------------------------------------------------------------

function scene:create( event )
    local sceneGroup = self.view

 
end

function scene:show( event )
    local sceneGroup = self.view
    local phase = event.phase

    if phase == "will" then
    	btnPlay = Botao.new("Play", 80)

    	txtFica = display.newText( "De que lado você está?", display.contentCenterX, display.contentHeight/100*20, native.systemFontBold, 40)


    	ficaDilma = display.newImage( "dilma.png" )
        ficaDilma:scale( 0.16, 0.16)
        ficaDilma.x = display.contentCenterX + display.contentCenterX/2
        ficaDilma.y = display.contentCenterY/1.1

        txtFica = display.newText( "#Fica", ficaDilma.x, ficaDilma.y + 150, native.systemFontBold, 40)
        txtFica:setFillColor( 0,0,0 )

        foraDilma = display.newImage( "foradilma.png" )
        foraDilma:scale( 0.8, 0.8)
        foraDilma.x = display.contentCenterX/2
        foraDilma.y = display.contentCenterY/1.1

        txtFora = display.newText( "#Fora", foraDilma.x, foraDilma.y + 150, native.systemFontBold, 40)
        txtFora:setFillColor( 0,0,0 )
       
        

    elseif phase == "did" then
        local prevScene = composer.getSceneName( "previous" )
        if (prevScene) then
            composer.removeScene( prevScene )
        end
        btnPlay:addEventListener( "tap", jogar )
        sceneGroup:insert( btnPlay )
        sceneGroup:insert( ficaDilma )
        sceneGroup:insert( txtFica )
        sceneGroup:insert( foraDilma )
        sceneGroup:insert( txtFora )

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