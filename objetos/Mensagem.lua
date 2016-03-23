local globals = require( "globals" )

local grupo = display.newGroup( )
local janela
local txt1
local txt2
local txt3
local txt4

local function new( lado )
	
	janela = display.newRoundedRect( display.contentCenterX, display.contentCenterY, display.contentCenterY, display.contentCenterY/1.5, 10 )
	janela.stroke = {0,0,0}
	janela.strokeWidth = 4
	txt1 = display.newText( "Vote à favor do", display.contentCenterX, janela.y-(janela.width/4), globals.fonts[2], 30)
	txt2 = display.newText( "Impeachment clicando", display.contentCenterX, janela.y-(janela.width/4)+30, globals.fonts[2], 30)
	txt3 = display.newText( "na tela até o ponteiro", display.contentCenterX, janela.y-(janela.width/4)+60, globals.fonts[2], 30)
	txt4 = display.newText( "passar do cubo azul.", display.contentCenterX, janela.y-(janela.width/4)+90, globals.fonts[2], 30)
	txt1:setFillColor( 0,0,0 )
	txt2:setFillColor( 0,0,0 )
	txt3:setFillColor( 0,0,0 )
	txt4:setFillColor( 0,0,0 )


	if (lado == "fica") then
		txt1.text =  "Vote contra o"
	end

	janela:setFillColor( 0.7,0.7,0.7 )
	
	grupo:insert( janela )
	grupo:insert( txt1 )
	grupo:insert( txt2 )
	grupo:insert( txt3 )
	grupo:insert( txt4 )

	grupo.alpha = 0.9
	janela:scale( 0, 0 )
	transition.to( janela, {xScale=1, yScale=1, time=200} )
	return grupo
end

local function remover(  )
	display.remove( txt1 )
	display.remove( txt2 )
	display.remove( txt3 )
	display.remove( txt4 )

	transition.to( janela, {xScale=0, yScale=0, time=200, onComplete=function (  )
		display.remove( janela )
	end} )
	
end

local function newPlusOne( lado )
	local x = math.random( display.contentCenterX/3,display.contentWidth - display.contentCenterX/3 )
	local y = math.random( display.contentCenterY/3,display.contentHeight - display.contentCenterY/3)
	local plus = display.newText( "#Fica", x, y, globals.fonts[2], 50)
	plus:setFillColor( 0,0,1)
	plus.alpha = 0
	if (lado == "fora") then
		plus.text = "#Fora"
	end
	transition.to( plus, {alpha=1, y=plus.y - 30, time=400, onComplete=function (  )
		transition.to( plus, {alpha=0, y=plus.y - 30, time=400, onComplete=function (  )
			display.remove( plus )
			plus = nil
		end} )
	end} )
end

return {
	new = new,
	remover = remover,
	newPlusOne = newPlusOne
}