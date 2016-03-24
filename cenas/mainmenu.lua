---------------------------------------------------------------------------------
--
-- login.lua
--
---------------------------------------------------------------------------------

local sceneName = ...

local composer = require( "composer" )
local Botao = require( "objetos.Botao" )
local globals = require( "globals" )
local coronium = require( "mod_coronium" )
coronium:init({ appId = globals.appId, apiKey = globals.apiKey })
coronium.showStatus = true


-- Load scene with same root filename as this file
local scene = composer.newScene(  )

local btnPlay
local btnRank
local btnAchieve

local timerPercorre

local function rank( event )
    showLeaderboards() 
end

local function achieve( event )
    showAchievements()
end

local function jogar( event )
	btnPlay:removeEventListener( "tap", jogar )
    btnRank:removeEventListener( "tap", rank )
    audio.play( globals.beep ,{channel = 3} ) 
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
        timerPercorre = timer.performWithDelay( 100, globals.percorrer ,-1 )
    	btnPlay = Botao.new("Jogar", 40)
        btnRank = Botao.new("Ranking", 50)
        btnAchieve = Botao.new("Conquistas", 60)
    	title = display.newText( "IMPEACHOMETRO", display.contentCenterX, display.contentHeight / 100 * 30, globals.fonts[2], 40)
    	title:setFillColor( 0,0,0 )
        loadInter()
        showBanner()




        

    elseif phase == "did" then
        local prevScene = composer.getSceneName( "previous" )
        if (prevScene) then
            composer.removeScene( prevScene )
        end
        btnPlay:addEventListener( "tap", jogar )
        btnRank:addEventListener( "tap", rank )
        btnAchieve:addEventListener( "tap", achieve )
        sceneGroup:insert( btnPlay )
        sceneGroup:insert( btnRank )
        sceneGroup:insert( btnAchieve )
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
		timer.cancel( timerPercorre )
        

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