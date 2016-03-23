---------------------------------------------------------------------------------
--
-- login.lua
--
---------------------------------------------------------------------------------

local sceneName = ...

local composer = require( "composer" )
local Botao = require( "objetos.Botao" )


-- Load scene with same root filename as this file
local scene = composer.newScene(  )

local btnPlay

local function jogar( event )
	btnPlay:removeEventListener( "tap", jogar )
	composer.gotoScene( "cenas.escolher", "fade", 500 )  
end


---------------------------------------------------------------------------------

function scene:create( event )
    local sceneGroup = self.view

 
end

function scene:show( event )
    local sceneGroup = self.view
    local phase = event.phase

    if phase == "will" then
    	btnPlay = Botao.new("Play", 20)
    	title = display.newText( "IMPEACHOMETRO", display.contentCenterX, display.contentHeight / 25 * 2.5, native.systemFontBold, 40)
    	title:setFillColor( 0,0,0 )
       
        

    elseif phase == "did" then
        local prevScene = composer.getSceneName( "previous" )
        if (prevScene) then
            composer.removeScene( prevScene )
        end
        btnPlay:addEventListener( "tap", jogar )
        sceneGroup:insert( btnPlay )
        sceneGroup:insert( title )

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