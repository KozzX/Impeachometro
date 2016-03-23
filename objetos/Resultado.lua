local grupo = display.newGroup( )
local janela
local txt1
local txt2
local txt3

local function new( fase )
	
	janela = display.newRoundedRect( display.contentCenterX, display.contentCenterY, display.contentCenterY, display.contentCenterY/1.5, 10 )
	txt1 = display.newText( "Parabéns!", display.contentCenterX, janela.y-(janela.width/4), native.systemFontBold, 30)
	txt2 = display.newText( "Você completou a", display.contentCenterX, janela.y-(janela.width/4)+30, native.systemFontBold, 30)
	txt3 = display.newText( fase .. ". ", display.contentCenterX, janela.y-(janela.width/4)+60, native.systemFontBold, 30)
	txt1:setFillColor( 0,0,0 )
	txt2:setFillColor( 0,0,0 )
	txt3:setFillColor( 0,0,0 )


	janela:setFillColor( 0.7,0.7,0.7 )
	
	grupo:insert( janela )
	grupo:insert( txt1 )
	grupo:insert( txt2 )
	grupo:insert( txt3 )

	grupo.alpha = 0.9
	janela:scale( 0, 0 )
	transition.to( janela, {xScale=1, yScale=1, time=200} )
	return grupo
end

local function remover(  )
	display.remove( txt1 )
	display.remove( txt2 )
	display.remove( txt3 )

	transition.to( janela, {xScale=0, yScale=0, time=200, onComplete=function (  )
		display.remove( janela )
	end} )
	
end


return {
	new = new,
	remover = remover,
}