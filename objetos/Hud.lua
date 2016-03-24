local globals = require( "globals" )
local coronium = require( "mod_coronium" )

coronium:init({ appId = globals.appId, apiKey = globals.apiKey })
coronium.showStatus = false

local textFora
local textFica
local barraFora
local barraFica
local valorFora = 0
local valorFica = 0
local contFica = 1
local contFora = 1

local function percentual(  )
	transition.to( barraFica, {width=display.contentWidth/100 * (valorFica * 100 / (valorFica + valorFora)), time=300} )
	transition.to( barraFora, {width=display.contentWidth/100 * (valorFora * 100 / (valorFica + valorFora)), time=300} )
end

local function contaFica( event )
    valorFica = event.result[1]["count(voto)"]
    if ((contFica == 1) or (contFica%10 == 0)) and (globals.inGame == false) then
    	submeterPontos("FICA",tonumber(valorFica))	
    end    
    textFica.text = "#Fica: "..valorFica
    percentual()  
    contFica = contFica + 1  
end

local function contaFora( event )
    valorFora = event.result[1]["count(voto)"]
    if ((contFora == 1) or (contFora%10 == 0)) and (globals.inGame == false) then
    	submeterPontos("FORA",tonumber(valorFora))
	end
    textFora.text = "#Fora: "..valorFora
    coronium:run( "contaFica",{},contaFica)
    contFora = contFora + 1
end

local function selecionar(  )
	if (buscarPontos("FICA").lastScore > 0) and (buscarPontos("FORA").lastScore > 0) then
		valorFica = buscarPontos("FICA").lastScore
		valorFora = buscarPontos("FORA").lastScore
		textFica.text = "#Fica: "..valorFica
		textFora.text = "#Fora: "..valorFora
		percentual()
	end
end

local function new(  )

	barraFora = display.newRect( 0, 125, display.contentWidth/2,60 )
	barraFora.anchorX = 0
	barraFora:setFillColor( 0,0.7,0.7 )
	barraFora.stroke = {0,0,0}
	barraFora.strokeWidth = 4

	barraFica = display.newRect( display.contentWidth, 125, display.contentWidth/2,60 )
	barraFica.anchorX = 1
	barraFica:setFillColor( 1,0.5,0 )
	barraFica.stroke = {0,0,0}
	barraFica.strokeWidth = 4

	textFora = display.newText( "#Fora: 0", 0,130, globals.fonts[2], 30)
	textFora.anchorX = 0
	textFora:setFillColor( 0,0,0 )
	textFica = display.newText( "#Fica: 0", display.contentWidth, 130, globals.fonts[2], 30)
	textFica.anchorX = 1
	textFica:setFillColor( 0,0,0 )
	selecionar()
	timer.performWithDelay( 2000, function (  )
		coronium:run( "contaFora",{},contaFora)   			
	end ,-1 )
	
end

return {
	new = new
}

