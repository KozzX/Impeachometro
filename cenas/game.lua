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
local globals = require( "globals" )

local coronium = require( "mod_coronium" )
coronium:init({ appId = globals.appId, apiKey = globals.apiKey })
coronium.showStatus = true


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
local btnRecomecar
local lado

local listener




-- Load scene with same root filename as this file
local scene = composer.newScene(  )

local function menu( event )
    Runtime:removeEventListener("tap", menu)
    Resultado.remover()
    composer.gotoScene( "cenas.mainmenu", "fade", 500 )  
    
end


local function proximo( event )
	btnProx:removeEventListener( "tap", proximo )
	display.remove( btnProx )
	transition.to( ponteiro, {rotation=0, time=200} )
	Resultado.remover()
    globals.changeBackground(0)
    fase.text = "Fase " .. numFase
    metaSpeed = metaSpeed - 0.5

	timer.performWithDelay( 1500, function (  )
		
		ativo = true
		Runtime:addEventListener( "enterFrame", listener )
	end , 1 )
end


local function vitoria(  )
	print( "vitoria" )
    audio.stop( 1 )
    if (lado == "fica") then
        audio.play( globals.audios[4] ,{channel = 1} )        
    else        
        audio.play( globals.audios[math.random(1,#globals.audios)] ,{channel = 1} )
    end
	numFase = numFase + 1
	Resultado.new({0,0.7,0.7},"VENCEU", "Parabéns","Você completou a", fase.text.."." )
	timer.performWithDelay( 1000, function (  )
		btnProx = Botao.new("Ir para Fase "..numFase, 56)
        --btnMenu = Botao.new("Menu", 64)
		btnProx:addEventListener( "tap", proximo )		
	end , 1 )
end

local function recomecar( event )
    btnRecomecar:removeEventListener( "tap", recomecar ) 
    display.remove( btnRecomecar )
    metaSpeed = -0.5
    transition.to( ponteiro, {rotation=0, time=200} )
    globals.changeBackground(0)
    numFase = 1
    pontos.text = 0
    fase.text = "Fase "..numFase
    Resultado.remover()
    timer.performWithDelay( 1500, function (  )
        ativo = true
        Runtime:addEventListener( "enterFrame", listener )
    end , 1 )
    
end

local function derrota(  )
	print( "derrota" )
    audio.stop( 1 )
    if (lado == "fica") then
        audio.play( globals.audios[math.random(1,#globals.audios)] ,{channel = 1} )
    else
        audio.play( globals.audios[4] ,{channel = 1} )
    end
    Resultado.new({1,0.7,1},"PERDEU", "Resultados:","Pontos: "..pontos.text, fase.text )
    timer.performWithDelay( 1000, function (  )
        btnRecomecar = Botao.new("Recomeçar", 56)
        --btnMenu = Botao.new("Menu", 64)
        --btnMenu:addEventListener( "tap", menu )
        btnRecomecar:addEventListener( "tap", recomecar )      
    end , 1 )
	
end


function listener( event )
    ponteiro:rotate( actSpeed )
    globals.changeBackground(ponteiro.rotation)

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

local function hit( event )
    actSpeed = 4--(metaSpeed*(-1))+0.8
    timer.performWithDelay( 50, function (  )
        actSpeed = metaSpeed
        if (ativo == true) then
        	pontos.text = pontos.text + (1)
        	Mensagem.newPlusOne(lado)
            audio.play( globals.audios[math.random(1,#globals.audios)],{channel = 1} )
            audio.play( globals.beep )
            coronium:run( "insereVoto", globals.player )
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
    lado = extras.lado


    if phase == "will" then
        local hudGrupo = display.newGroup( )
    	if (extras.lado == "fica") then
    		title = display.newText( "#Fica", display.contentCenterX, display.contentHeight/100*95, globals.fonts[2], 30)
    		globals.player.voto = "#Fica"
    	elseif (extras.lado == "fora") then
    		title = display.newText( "#Fora", display.contentCenterX, display.contentHeight/100*95, globals.fonts[2], 30)
            globals.player.voto = "#Fora"
    	end

    	title:setFillColor( 0,0,0 )
    	fase = display.newText( "Fase "..numFase, display.contentCenterX, display.contentHeight/100*5, globals.fonts[2], 30)
    	fase:setFillColor( 0,0,0 )
    	pontos = display.newText( "0", display.contentCenterX, display.contentHeight/100*10, globals.fonts[2], 40)
    	pontos:setFillColor( 0,0,0 )
    	pontos.text = 0
        hudGrupo:insert( title )
        hudGrupo:insert( fase )
        hudGrupo:insert( pontos )
        hudGrupo.alpha = 0
        transition.to( hudGrupo, {alpha=1,time=500} )
        

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