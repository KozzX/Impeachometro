local globals = require( "globals" )
local coronium = require( "mod_coronium" )

coronium:init({ appId = globals.appId, apiKey = globals.apiKey })
coronium.showStatus = true

local textFora
local textFica
local barraFora
local barraFica
local valorFora = 0
local valorFica = 0

local function percentual(  )
	print( "percentual" )
	transition.to( barraFica, {width=display.contentWidth/100 * (valorFica * 100 / (valorFica + valorFora)), time=200} )
	transition.to( barraFora, {width=display.contentWidth/100 * (valorFora * 100 / (valorFica + valorFora)), time=200} )
end

local function contaFica( event )
    print( event.result[1]["count(voto)"])
    valorFica = event.result[1]["count(voto)"]
    textFica.text = "#Fica: "..valorFica
    percentual()    
end

local function contaFora( event )
    print( event.result[1]["count(voto)"]) 
    valorFora = event.result[1]["count(voto)"]
    textFora.text = "#Fora: "..valorFora
    percentual()
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

	timer.performWithDelay( 2000, function (  )
		coronium:run( "contaFica",{},contaFica)
    	coronium:run( "contaFora",{},contaFora)		
	end ,-1 )
	
end

return {
	new = new
}

