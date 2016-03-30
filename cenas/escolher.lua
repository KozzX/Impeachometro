---------------------------------------------------------------------------------
--
-- login.lua
--
---------------------------------------------------------------------------------

local sceneName = ...

local composer = require( "composer" )
local Botao = require( "objetos.Botao" )
local globals = require( "globals" )


-- Load scene with same root filename as this file
local scene = composer.newScene(  )

local btnVoltar
local ficaDilma
local foraDilma
local txtFica
local txtFora
local txtPergunta


local timerPercorre


local function fica( event )
	ficaDilma:removeEventListener( "tap", fica )
    audio.play( globals.beep ,{channel = 3} ) 
	print( "fica" )
	transition.to( foraDilma, {alpha=0, time=200} )
	transition.to( txtFica, {alpha=0, time=200} )
	transition.to( txtFora, {alpha=0, time=200} )
	transition.to( txtPergunta, {alpha=0, time=200} )
	transition.to( ficaDilma, {x=display.contentCenterX, y=display.contentCenterY, xScale=1, yScale=1, alpha=0, time=500,onComplete=function (  )
		composer.gotoScene( "cenas.game", { effect = "fade", time = 500, params={lado="fica" } } )
	end} )

end

local function fora( event )
    foraDilma:removeEventListener( "tap", fora )
    audio.play( globals.beep ,{channel = 3} ) 
	print( "fora" )
	transition.to( ficaDilma, {alpha=0, time=200} )
	transition.to( txtFica, {alpha=0, time=200} )
	transition.to( txtFora, {alpha=0, time=200} )
	transition.to( txtPergunta, {alpha=0, time=200} )
	transition.to( foraDilma, {x=display.contentCenterX, y=display.contentCenterY, xScale=5, yScale=5, alpha=0, time=500,onComplete=function (  )
		composer.gotoScene( "cenas.game", { effect = "fade", time = 500, params={lado="fora" } } )
	end} )
	
end

local function voltar( event )
	audio.play( globals.beep  ) 
    btnVoltar:removeEventListener( "tap", voltar )
    ficaDilma:removeEventListener( "tap", fica )
    foraDilma:removeEventListener( "tap", fora )
    composer.gotoScene( "cenas.mainmenu", "fade", 500 )  
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
    	
    	txtPergunta = display.newText( "Escolha seu lado", display.contentCenterX, display.contentHeight/100*30, globals.fonts[2], 40)
    	txtPergunta:setFillColor( 0,0,0 )


    	ficaDilma = display.newImage( "imagens/dilma.png" )
        ficaDilma:scale( 0.16, 0.16)
        ficaDilma.x = display.contentCenterX + display.contentCenterX/2
        ficaDilma.y = display.contentCenterY/1

        txtFica = display.newText( "#Fica", ficaDilma.x, ficaDilma.y + 180, globals.fonts[2], 40)
        txtFica:setFillColor( 0,0,0 )

        foraDilma = display.newImage( "imagens/foradilma.png" )
        foraDilma:scale( 0.8, 0.8)
        foraDilma.x = display.contentCenterX/2
        foraDilma.y = display.contentCenterY/1

        txtFora = display.newText( "#Fora", foraDilma.x, foraDilma.y + 180, globals.fonts[2], 40)
        txtFora:setFillColor( 0,0,0 )

        

    elseif phase == "did" then
        local prevScene = composer.getSceneName( "previous" )
        if (prevScene) then
            composer.removeScene( prevScene )
        end

        btnVoltar = Botao.new("Voltar", 85)
        
        ficaDilma:addEventListener( "tap", fica )
        foraDilma:addEventListener( "tap", fora )
        btnVoltar:addEventListener( "tap", voltar )
               
        sceneGroup:insert( txtPergunta )
        sceneGroup:insert( ficaDilma )
        sceneGroup:insert( txtFica )
        sceneGroup:insert( foraDilma )
        sceneGroup:insert( txtFora )
        sceneGroup:insert( btnVoltar )

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