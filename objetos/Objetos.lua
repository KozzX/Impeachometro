local function newDilma(  )
	local dilma = display.newImage( "imagens/dilma.png" )
    dilma:scale( 0.35, 0.35)
    dilma.x = display.contentCenterX
    dilma.y = display.contentCenterY+20
    dilma.alpha = 0
    transition.to( dilma, {alpha=1, time=200} )

	return dilma
end

local function newPonteiro(  )
	ponteiro = display.newRect( display.contentCenterX, display.contentHeight-50, 5 , display.contentWidth/2.5)
    ponteiro:setFillColor( 0,0,0 )
    ponteiro.anchorY = 1
    ponteiro.alpha = 0
    transition.to( ponteiro, {alpha=1, time=200} )
	return ponteiro
end

local function newDash( lado )
	if (lado == "fica") then
		
	end
	dash = display.newImage( "imagens/dashmeterinverse.png" )
    dash.x = display.contentCenterX
    dash.y = display.contentHeight-50
    dash.anchorY = 1
    dash.width = display.contentWidth
    dash.height = display.contentCenterY*0.5
    dash.alpha = 0
    transition.to( dash, {alpha=0.8, time=200} )

	return dash
end

return {
	newDilma = newDilma,
	newPonteiro = newPonteiro,
	newDash = newDash,
}
