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
local Objetos = require( "objetos.Objetos" )
local Mensagem = require ( "objetos.Mensagem" )
local store = require( "plugin.google.iap.v3" )

coronium:init({ appId = globals.appId, apiKey = globals.apiKey })
coronium.showStatus = true


-- Load scene with same root filename as this file
local scene = composer.newScene(  )

local btnPlay
local btnRank
local btnAchieve
local btnRate
local dilma
local timerInfla
local lado

local timerPercorre

local function loja( event )
    local transaction = event.transaction

    if ( transaction.state == "purchased" ) then
        propaganda = false
        hideBanner()
    elseif ( transaction.state == "cancelled" ) then
        showInter()
        loadInter()
        native.showAlert( "Cancelled", "User cancelled transaction", { "Ok"} )
    elseif ( transaction.state == "failed" ) then
        native.showAlert( "Failed", transaction.errorType .. " " .. transaction.errorString, { "Ok"} )
    else
        print( "Unknown event" )
    end
    store.finishTransaction( transaction )
end
store.init( "google", loja )

store.restore( )


local function rank( event )
    audio.play( globals.beep ) 
    showLeaderboards() 
end

local function achieve( event )
    audio.play( globals.beep  ) 
    showAchievements()
end
local function comprar( event )
    audio.play( globals.beep  ) 
    store.purchase("remover_ads")
end

local function rate( event )
    audio.play( globals.beep  )
    system.openURL("https://play.google.com/store/apps/details?id=com.athgames.Impeachometro")
end

local function jogar( event )
	btnPlay:removeEventListener( "tap", jogar )
    btnRank:removeEventListener( "tap", rank )
    btnAchieve:removeEventListener( "tap", achieve )
    btnBuy:removeEventListener( "tap", comprar )
    audio.play( globals.beep ,{channel = 3} ) 
	composer.gotoScene( "cenas.escolher", "fade", 500 )  
end

local function infla(  )
    if lado == "fora" then
        lado = "fica"
    else
        lado = "fora"
    end

    Mensagem.newPlusOne(lado)

    transition.to( dilma, {xScale=0.2,yScale=0.17, time=100, onComplete=function (  )
        transition.to( dilma, {xScale=0.25,yScale=0.25,time=100} )
    end} )
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
        dilma = Objetos.newDilma()
        dilma:toBack( )
        dilma.y = dilma.y - 80
        dilma:scale( 0.8, 0.8 )
    	btnPlay = Botao.new("Jogar", 60)
        btnRank = Botao.new("Ranking", 67)
        btnAchieve = Botao.new("Conquistas", 74)
        btnBuy = Botao.new("Remover Ads", 81)
        btnRate = Botao.new("Avaliar", 88)
    	title = display.newText( "#IMPEACHOMETRO", display.contentCenterX, display.contentHeight / 100 * 7, globals.fonts[2], 40)
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
        btnBuy:addEventListener( "tap", comprar )
        btnRate:addEventListener( "tap", rate )
        sceneGroup:insert( dilma )
        sceneGroup:insert( btnPlay )
        sceneGroup:insert( btnRank )
        sceneGroup:insert( btnBuy )
        sceneGroup:insert( btnRate )
        sceneGroup:insert( btnAchieve )
        sceneGroup:insert( title )
        timerInfla = timer.performWithDelay( 800, infla ,-1 )

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
        timer.cancel( timerInfla )
        

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