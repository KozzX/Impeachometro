---------------------------------------------------------------------------------
--
-- game.lua
--
---------------------------------------------------------------------------------

local sceneName = ...

local composer = require( "composer" )
local Botao = require( "objetos.Botao" )
local Objetos = require( "objetos.Objetos" )
local Mensagem = require ("objetos.Mensagem")
local Resultado = require ("objetos.Resultado")


local title
local fase
local numFase = 1
local pontos
local dilma
local roda
local ponteiro
local btnOk
local angulo = 0
local maxRot = 90
local minRot = -90
local metaSpeed = -0.5
local actSpeed = metaSpeed
local ativo = true
local btnProx

local hit
local listener




-- Load scene with same root filename as this file
local scene = composer.newScene(  )

local function proximo( event )
	btnProx:removeEventListener( "tap", proximo )
	display.remove( btnProx )
	transition.to( ponteiro, {rotation=0, time=200} )
	Resultado.remover()

	timer.performWithDelay( 1500, function (  )
		fase.text = "Fase" .. numFase
		metaSpeed = metaSpeed - 0.5
		ativo = true
		Runtime:addEventListener( "tap", hit )
		Runtime:addEventListener( "enterFrame", listener )
	end , 1 )
	
end


local function vitoria(  )
	print( "vitoria" )
	numFase = numFase + 1
	Resultado.new(fase.text)
	timer.performWithDelay( 1000, function (  )
		btnProx = Botao.new("Ir para Fase "..numFase, 60)
		btnProx:addEventListener( "tap", proximo )		
	end , 1 )
	
	
end

local function derrota(  )
	print( "derrota" )
	
end


function listener( event )
    ponteiro:rotate( actSpeed )

    if (ponteiro.rotation <= minRot) then
        actSpeed = 0
        ativo = false
        Runtime:removeEventListener( "enterFrame", listener )
        derrota()
    elseif (ponteiro.rotation >= maxRot) then
        actSpeed = 0
        ativo = false
        Runtime:removeEventListener( "enterFrame", listener )
        vitoria()
    end
end 


local function infla(  )
    transition.to( dilma, {xScale=0.3,yScale=0.28, time=100, onComplete=function (  )
        transition.to( dilma, {xScale=0.35,yScale=0.35,time=100} )
    end} )
end

function hit( event )
    actSpeed = (metaSpeed*(-1))+1
    timer.performWithDelay( 50, function (  )
        actSpeed = metaSpeed
        if (ativo == true) then
        	pontos.text = pontos.text + (1)
        	Mensagem.newPlusOne()
            infla()  
        end
    end ,1 )
end

local function comecar( event )
	display.remove(btnOk)
	btnOk:removeEventListener( "tap", comecar )
	Mensagem.remover()
	timer.performWithDelay( 500, function (  )
		Runtime:addEventListener( "tap", hit )
		Runtime:addEventListener( "enterFrame", listener )	
	end ,1 )
	
end

-------------------------------------------------------------------------------------------
function scene:create( event )
    local sceneGroup = self.view

 
end

function scene:show( event )
    local sceneGroup = self.view
    local phase = event.phase
    local extras = event.params


    if phase == "will" then
    	if (extras.lado == "fica") then
    		title = display.newText( "#Fica", display.contentCenterX, display.contentHeight/100*5, native.systemFontBold, 40)
    		
    	elseif (extras.lado == "fora") then
    		title = display.newText( "#Fora", display.contentCenterX, display.contentHeight/100*5, native.systemFontBold, 40)
    	end
    	title:setFillColor( 0,0,0 )
    	fase = display.newText( "Fase "..numFase, display.contentCenterX, display.contentHeight/100*10, native.systemFontBold, 40)
    	fase:setFillColor( 0,0,0 )
    	pontos = display.newText( "0", display.contentCenterX, display.contentHeight/100*15, native.systemFontBold, 40)
    	pontos:setFillColor( 0,0,0 )
    	pontos.text = 0
        

    elseif phase == "did" then
        local prevScene = composer.getSceneName( "previous" )
        if (prevScene) then
            composer.removeScene( prevScene )
        end
        dilma = Objetos.newDilma()
        roda = Objetos.newDash()
        ponteiro = Objetos.newPonteiro()
        msg = Mensagem.new(extras.lado)
        btnOk = Botao.new("Começar", 60)

        btnOk:addEventListener( "tap", comecar )
        

        sceneGroup:insert( dilma )
        sceneGroup:insert( roda )
        sceneGroup:insert( ponteiro )
        sceneGroup:insert( title )
        --sceneGroup:insert( btnHit )

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