local globals = require( "globals" )
local coronium = require( "mod_coronium" )

coronium:init({ appId = globals.appId, apiKey = globals.apiKey })
coronium.showStatus = true

local textFora
local textFica

local function contaFica( event )
    print( event.result[1]["count(voto)"])
    textFica.text = "#Fica: "..event.result[1]["count(voto)"]
    
end

local function contaFora( event )
    print( event.result[1]["count(voto)"]) 
    textFora.text = "#Fora: "..event.result[1]["count(voto)"]
end

local function new(  )
	textFora = display.newText( "#Fora: 0", 0,100, globals.fonts[2], 30)
	textFora.anchorX = 0
	textFora:setFillColor( 0,0,0 )
	textFica = display.newText( "#Fica: 0", display.contentWidth, 100, globals.fonts[2], 30)
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

