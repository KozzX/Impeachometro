local globals = require( "globals" )

local grupo = display.newGroup( )
local janela
local txt1
local txt2
local txt3
local txt4
local txt5


local function new( cor,texto1, texto2, texto3, texto4, texto5 )
	if (texto1==nil) then
		texto1 = ""
	end
	if (texto2==nil) then
		texto2 = ""
	end
	if (texto3==nil) then
		texto3 = ""
	end
	if (texto4==nil) then
		texto4 = ""
	end
	if (texto5==nil) then
		texto5 = ""
	end
	
	janela = display.newRoundedRect( display.contentCenterX, display.contentCenterY, display.contentCenterY, display.contentCenterY/1.2, 10 )
	janela.stroke = {0,0,0}
	janela.strokeWidth = 4
	txt1 = display.newText( texto1, display.contentCenterX, janela.y-(janela.width/3.7), globals.fonts[2], 40)
	txt2 = display.newText( texto2, display.contentCenterX, janela.y-(janela.width/3.7)+40, globals.fonts[2], 30)
	txt3 = display.newText( texto3, display.contentCenterX, janela.y-(janela.width/3.7)+70, globals.fonts[2], 30)
	txt4 = display.newText( texto4, display.contentCenterX, janela.y-(janela.width/3.7)+100, globals.fonts[2], 30)
	txt5 = display.newText( texto5, display.contentCenterX, janela.y-(janela.width/3.7)+130, globals.fonts[2], 30)
	
	txt1:setFillColor( 1,1,0 )
	txt2:setFillColor( 0,0,0 )
	txt3:setFillColor( 0,0,0 )
	txt4:setFillColor( 0,0,0 )
	txt5:setFillColor( 0,0,0 )


	janela:setFillColor( cor[1], cor[2], cor[3] )
	
	grupo:insert( janela )
	grupo:insert( txt1 )
	grupo:insert( txt2 )
	grupo:insert( txt3 )
	grupo:insert( txt4 )
	grupo:insert( txt5 )

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
	display.remove( txt5 )

	transition.to( janela, {xScale=0, yScale=0, time=200, onComplete=function (  )
		display.remove( janela )
	end} )
	
end


return {
	new = new,
	remover = remover,
}