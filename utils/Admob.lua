local ads = require( "ads" )
local interId = "ca-app-pub-5977631144089571/4268001243"
local bannerId = "ca-app-pub-5977631144089571/2791268040"

function init(  )
	if(propaganda==true) then
		ads.init( "admob", interId)
	end
end

function loadInter( )
	if(propaganda==true) then
		print( "loadInter" )
		ads.load("interstitial", { appId = interId})
	end
end

function showInter()
	if(propaganda==true) then
		print( "showInter" )
		ads.show( "interstitial", { appId=interId } )	
	end
end

function showBanner( )
	if(propaganda==true) then
		print( "showBanner" )
		ads.show( "banner", {x=0, y=100000, appId=bannerId} )
	end
end

function hideBanner( )
	print( "hideBanner" )
	ads.hide()
end