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
coronium.showStatus = false


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
local btnRank
local btnConq
local btnShare
local btnRecomecar
local btnMenu
local lado
local timerConquista
local intervaloAds = 5

local listener




-- Load scene with same root filename as this file
local scene = composer.newScene(  )

local function verificarLado(  )
    --Chamar apenas quando entrar na cena
    print( "verificarLado" )
    if (lado=="fora") then
        submitConquista(globals.c.conquistaFora)
    end
    if (lado=="fica") then
        submitConquista(globals.c.conquistaFica) 
    end    
end

local function verificarPontosEm1(  )
    print( "verificarPontosEm1" )
    --Chamar cada 3 segundos
    if (tonumber(pontos.text)>=10 and tonumber(pontos.text)<50) then
        submitConquista(globals.c.conquista10Em1)  
    end
    if (tonumber(pontos.text)>=50 and tonumber(pontos.text)<75) then
        submitConquista(globals.c.conquista50Em1)  
    end
    if (tonumber(pontos.text)>=75 and tonumber(pontos.text)<100) then
        submitConquista(globals.c.conquista75Em1)  
    end
    if (tonumber(pontos.text)>=100 and tonumber(pontos.text)<150) then
        submitConquista(globals.c.conquista100Em1)  
    end
    if (tonumber(pontos.text)>=150 and tonumber(pontos.text)<200) then
        submitConquista(globals.c.conquista150Em1)  
    end
    if (tonumber(pontos.text)>=200 and tonumber(pontos.text)<500) then
        submitConquista(globals.c.conquista200Em1)  
    end
    if (tonumber(pontos.text)>=500) then
        submitConquista(globals.c.conquista500Em1)  
    end
end

local function verificarPontosTotais(  )
    print( "verificarPontosTotais" )
    --Chamar quando passar de fase e quando perder
    if (buscarPontos("PONTOS").totalScore >= 1000) then
        submitConquista(globals.c.conquista1000Totais)
    end
    if (buscarPontos("PONTOS").totalScore >= 3000) then
        submitConquista(globals.c.conquista3000Totais)
    end
    if (buscarPontos("PONTOS").totalScore >= 5000) then
        submitConquista(globals.c.conquista5000Totais)
    end
    if (buscarPontos("PONTOS").totalScore >= 10000) then
        submitConquista(globals.c.conquista10000Totais)
    end
    if (buscarPontos("PONTOS").totalScore >= 50000) then
        submitConquista(globals.c.conquista50000Totais)
    end
    if (buscarPontos("PONTOS").totalScore >= 100000) then
        submitConquista(globals.c.conquista100000Totais)
    end    
end

local function verificarFases(  )
    --Chamar somente quando passar de fase
    print( "verificarFases" )
    if (numFase==2) then
        submitConquista(globals.c.conquistaPrimeiraFase)  
    end
    if (numFase==3) then
        submitConquista(globals.c.conquistaSegundaFase)  
    end
    if (numFase==4) then
        submitConquista(globals.c.conquistaTerceiraFase)  
    end
    if (numFase==5) then
        submitConquista(globals.c.conquistaQuartaFase)  
    end
    if (numFase==6) then
        submitConquista(globals.c.conquistaQuintaFase)  
    end
    if (numFase==7) then
        submitConquista(globals.c.conquistaSextaFase)  
    end
    if (numFase==8) then
        submitConquista(globals.c.conquistaSetimaFase)  
    end
    if (numFase==9) then
        submitConquista(globals.c.conquistaOitavaFase)  
    end
    if (numFase==10) then
        submitConquista(globals.c.conquistaNonaFase)  
    end
    if (numFase==11) then
        submitConquista(globals.c.conquistaDecimaFase)  
    end
    if (numFase==12) then
        submitConquista(globals.c.conquistaDecimaPrimeiraFase)  
    end
    if (numFase==13) then
        submitConquista(globals.c.conquistaDecimaSegundaFase)  
    end
    if (numFase==14) then
        submitConquista(globals.c.conquistaDecimaTerceiraFase)  
    end
    if (numFase==15) then
        submitConquista(globals.c.conquistaDecimaQuartaFase)  
    end
    if (numFase==16) then
        submitConquista(globals.c.conquistaDecimaQuintaFase)  
    end
    if (numFase==17) then
        submitConquista(globals.c.conquistaDecimaSextaFase)  
    end
    if (numFase==18) then
        submitConquista(globals.c.conquistaDecimaSetimaFase)  
    end
    if (numFase==19) then
        submitConquista(globals.c.conquistaDecimaOitavaFase)  
    end
    if (numFase==20) then
        submitConquista(globals.c.conquistaDecimaNonaFase)  
    end
    if (numFase==21) then
        submitConquista(globals.c.conquistaVigesimaFase)  
    end
    if (numFase==22) then
        submitConquista(globals.c.conquistaVigesimaPrimeiraFase)  
    end
    if (numFase==23) then
        submitConquista(globals.c.conquistaVigesimaSegundaFase)  
    end
    if (numFase==24) then
        submitConquista(globals.c.conquistaVigesimaTerceiraFase)  
    end
    if (numFase==25) then
        submitConquista(globals.c.conquistaVigesimaQuartaFase)  
    end
    if (numFase==26) then
        submitConquista(globals.c.conquistaVigesimaQuintaFase)  
    end
end


local function menu( event )
    audio.play( globals.beep  ) 
    btnMenu:removeEventListener( "tap", menu )
    if (buscarPontos("FASE").timesPlayed%3 == 0) then
    	showInter()
    	loadInter()
    end
    --btnRecomecar:removeEventListener( "tap", recomecar )
    display.remove(btnRecomecar)
    btnRecomecar = nil
    display.remove( btnMenu )
    btnMenu = nil
    display.remove( btnRank )
    btnRank = nil
    display.remove( btnConq )
    btnConq = nil
    display.remove( btnShare )
    btnShare = nil
    Resultado.remover()
    composer.gotoScene( "cenas.mainmenu", "fade", 500 )  
    
end


local function proximo( event )
    hideBanner()
    audio.play( globals.beep  ) 
	btnProx:removeEventListener( "tap", proximo )
	display.remove( btnProx )
    btnProx = nil
    display.remove( btnRank )
    btnRank = nil
    display.remove( btnConq )
    btnConq = nil
    display.remove( btnShare )
    btnShare = nil
	transition.to( ponteiro, {rotation=0, time=200} )
	Resultado.remover()
    globals.changeBackground(0)
    fase.text = "Fase " .. numFase
    metaSpeed = metaSpeed - 0.5

	timer.performWithDelay( 1500, function (  )
        globals.inGame = true		
		ativo = true
		Runtime:addEventListener( "enterFrame", listener )
	end , 1 )
end


local function vitoria(  )
    showBanner()
    audio.play( globals.success, { channel = 2 } ) 
    if (buscarPontos("FASE").timesPlayed%intervaloAds == 0) then
        timer.performWithDelay( 850, function (  )
            showInter()
            loadInter()            
        end ,1 )
    end
	print( "vitoria" )
    submitScore(IDLEADERBOARDS.fases,numFase)  
    submitScore(IDLEADERBOARDS.pontos,tonumber(pontos.text))
    submeterPontos("FASE",numFase)
    --submeterPontos("PONTOS",tonumber(pontos.text))
    if (lado == "fica") then
        audio.stop( 1 )
        audio.play( globals.audios[7] ,{channel = 1} )        
    end

	numFase = numFase + 1
    verificarFases()
    verificarPontosTotais()
	Resultado.new({0,0.7,0.7},"VENCEU", "Resultados:", "Fase " .. numFase-1 .. " Completa", "Pontos: "..pontos.text )
	timer.performWithDelay( 1000, function (  )
		btnProx = Botao.new("Ir para Fase "..numFase, 73.5)
        btnRank = Botao.new("Ranking", 60.5)
        btnConq = Botao.new("Conquistas", 67)
        btnShare = Botao.new("Compartilhar", 54)
		btnProx:addEventListener( "tap", proximo )	
        btnShare:addEventListener( "tap", function (  )
            audio.play( globals.beep  ) 
            local capture = display.captureScreen()
            capture.anchorX = 0
            capture.anchorY = 0
            display.save( capture, "share.jpg", system.TemporaryDirectory )
            display.remove( capture )
            native.showPopup( "social", { url = "https://play.google.com/store/apps/details?id=com.athgames.Impeachometro",
                                image = {{ filename = "share.jpg", baseDir = system.TemporaryDirectory }}} )
        end )
        btnRank:addEventListener( "tap", function (  )
            audio.play( globals.beep  ) 
            showLeaderboards()
        end )
        btnConq:addEventListener( "tap", function (  )
            audio.play( globals.beep  ) 
            showAchievements()
        end )	
	end , 1 )
end

local function recomecar( event )
    hideBanner()
    audio.play( globals.beep  ) 
    print( "RECOMECAR" )
    btnRecomecar:removeEventListener( "tap", recomecar ) 
    btnMenu:removeEventListener( "tap", menu ) 
    display.remove(btnMenu)
    btnMenu = nil
    display.remove( btnRecomecar )
    btnRecomecar = nil
    display.remove( btnRank )
    btnRank = nil
    display.remove( btnConq )
    btnConq = nil
    display.remove( btnShare )
    btnShare = nil
    metaSpeed = -0.5
    transition.to( ponteiro, {rotation=0, time=200} )
    globals.changeBackground(0)
    numFase = 1
    pontos.text = 0
    fase.text = "Fase "..numFase
    Resultado.remover()
    timer.performWithDelay( 1500, function (  )
        ativo = true
        globals.inGame = true
        Runtime:addEventListener( "enterFrame", listener )
    end , 1 )
    
end

local function derrota(  )
    showBanner()
    audio.play( globals.erro, { channel = 2 } ) 
    if (buscarPontos("FASE").timesPlayed%intervaloAds == 0) then
        timer.performWithDelay( 850, function (  )
            showInter()
            loadInter()            
        end ,1 )
    end
	print( "derrota" )
    submitScore(IDLEADERBOARDS.fases,numFase)  
    submitScore(IDLEADERBOARDS.pontos,tonumber(pontos.text))
    submeterPontos("FASE",numFase)
    submeterPontos("PONTOS",tonumber(pontos.text))
    verificarPontosTotais()
    
    if (lado == "fora") then
        audio.stop( 1 )
        audio.play( globals.audios[7] ,{channel = 1} )
    end
    Resultado.new({1,0.7,1},"FIM DE JOGO", "Resultados:","Pontos: "..pontos.text, "Melhor: " .. buscarPontos("PONTOS").highScore , "Total Pontos: ".. buscarPontos("PONTOS").totalScore,"Fase: " .. numFase," Melhor Fase: " .. buscarPontos("FASE").highScore)
    timer.performWithDelay( 1000, function (  )
        btnRecomecar = Botao.new("Recomeçar", 54)
        btnShare = Botao.new("Compartilhar", 60.5)
        btnRank = Botao.new("Ranking", 67)
        btnConq = Botao.new("Conquistas", 73.5)
        btnMenu = Botao.new("Menu", 80)
        btnShare:addEventListener( "tap", function (  )
            audio.play( globals.beep  ) 
            local capture = display.captureScreen()
            capture.anchorX = 0
            capture.anchorY = 0
            display.save( capture, "share.jpg", system.TemporaryDirectory )
            display.remove( capture )
            native.showPopup( "social", { url = "https://play.google.com/store/apps/details?id=com.athgames.Impeachometro",
                                image = {{ filename = "share.jpg", baseDir = system.TemporaryDirectory }}} )
        end )

        btnRank:addEventListener( "tap", function (  )
            audio.play( globals.beep  ) 
            showLeaderboards()
        end )
        btnConq:addEventListener( "tap", function (  )
            audio.play( globals.beep  ) 
            showAchievements()
        end )

        
        btnMenu:addEventListener( "tap", menu )
        btnRecomecar:addEventListener( "tap", recomecar )      
    end , 1 )
	
end


function listener( event )
    ponteiro:rotate( actSpeed )
    globals.changeBackground(ponteiro.rotation)

    if (ponteiro.rotation <= minRot) then
        actSpeed = 0
        ativo = false
        globals.inGame = false
        Runtime:removeEventListener( "enterFrame", listener )
        derrota()
    elseif (ponteiro.rotation >= maxRot) then
        actSpeed = 0
        ativo = false
        globals.inGame = false
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
    audio.play( globals.beep  ) 
	display.remove(btnOk)
	btnOk:removeEventListener( "tap", comecar )
	Mensagem.remover()
    globals.inGame = true
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
        hideBanner()
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
            print( "removeu" )
            composer.removeScene( prevScene )
        end
        dilma = Objetos.newDilma()
        roda = Objetos.newDash()
        ponteiro = Objetos.newPonteiro()
        msg = Mensagem.new(extras.lado)
        btnOk = Botao.new("Começar", 60)

        btnOk:addEventListener( "tap", comecar )
        verificarLado()
        timerConquista = timer.performWithDelay( 3000, verificarPontosEm1 , -1 )



        sceneGroup:insert( dilma )
        sceneGroup:insert( roda )
        sceneGroup:insert( ponteiro )
        sceneGroup:insert( title )
        sceneGroup:insert( fase )
        sceneGroup:insert( title )
        sceneGroup:insert( pontos )


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
        timer.cancel( timerConquista )

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