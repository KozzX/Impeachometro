local gameNetwork = require( "gameNetwork" )

IDLEADERBOARDS = {
	fases="CgkIoMDU-7YFEAIQAQ",
  	pontos="CgkIoMDU-7YFEAIQAA",
}

function loginGooglePlayCallback( event )
	if event.isError then 
		native.showAlert( "Error", "Unable to connect to Google Play Services. Please check you internet connection and try again.", { 'Ok' } )		
	end
end

function loginGooglePlay(event)
    gameNetwork.request( "login", { userInitiated=true , listener=loginGooglePlayCallback } )
end

function gameNetworkSetup()
   if ( system.getInfo("platformName") == "Android" ) then
      gameNetwork.init( "google", loginGooglePlay )
   else
      gameNetwork.init( "gamecenter", gameNetworkLoginCallback )
   end
end


function logoutGooglePlay()
   print( "logoutGooglePlay" )
   if (gameNetwork.request("isConnected")) then
      gameNetwork.request("logout")
   end
end

function submitScore( leaderboard, pontos )	
	gameNetwork.request( "setHighScore",{localPlayerScore = { category=leaderboard, value=pontos }})
end

function showLeaderboards()
	gameNetwork.show("leaderboards") -- Shows all the leaderboards.
end

function showAchievements()
	gameNetwork.show("achievements") -- Shows the locked and unlocked achievements.
end


