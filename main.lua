-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- This function gets called when the user opens a notification or one is received when the app is open and active.
-- Change the code below to fit your app's needs.
function DidReceiveRemoteNotification(message, additionalData, isActive)
    if (additionalData) then
        if (additionalData.discount) then
            native.showAlert( "Discount!", message, { "OK" } )
            -- Take user to your app store
        elseif (additionalData.actionSelected) then -- Interactive notification button pressed
            native.showAlert("Button Pressed!", "ButtonID:" .. additionalData.actionSelected, { "OK"} )
        elseif (additionalData.shop) then
            store.purchase("remove_ads")
        elseif (additionalData.like) then
            if(not system.openURL("fb://page/1083605381668906")) then
                system.openURL("http://www.facebook.com/opressoroculos")
            end
        elseif (additionalData.update) then   
            system.openURL("https://play.google.com/store/apps/details?id=com.athgames.Impeachometro")
        elseif(additionalData.oculos) then
            system.openURL("https://play.google.com/store/apps/details?id=com.athgames.oculosopressor")
        elseif(additionalData.minigame) then
            system.openURL("https://play.google.com/store/apps/details?id=com.athgames.minigameracer")
        elseif(additionalData.todos) then
            system.openURL("https://play.google.com/store/apps/details?id=com.athgames.minigameracer")
        end
    else
        native.showAlert("OneSignal Message", message, { "OK" } )
    end
end

local OneSignal = require("plugin.OneSignal")
OneSignal.Init("241065a8-da68-4c69-af71-988c0c080ef3", "186553540640", DidReceiveRemoteNotification)

local globals = require( "globals" )
local Hud = require( "objetos.Hud" )

function IdsAvailable(userId, pushToken)
    print("userId:" .. userId)
    globals.player.pushId = userId
    if (pushToken) then -- nil if there was a connection issue or on iOS notification permissions were not accepted.
        print("pushToken:" .. pushToken)
        globals.player.pushToken = pushToken 
    end  
end
OneSignal.IdsAvailableCallback(IdsAvailable)




local composer = require( "composer" )
local Database = require ("utils.Database")
local Google = require( "utils.Google" )
local Admob = require( "utils.Admob" )

propaganda = true

init()

gameNetworkSetup()

Hud.new()

--Carregando Audios
for i=1,#globals.loadAudio do
    globals.audios[i] = audio.loadSound(globals.loadAudio[i])
end
globals.point = audio.loadSound( globals.loadPoint )
globals.beep = audio.loadSound( globals.loadBeep )
globals.erro = audio.loadSound( globals.loadErro )
globals.success = audio.loadSound( globals.loadSuccess )
audio.setVolume( 1, { channel=1 } )
audio.setVolume( 1, { channel=2 } )
for i=3,32 do
    audio.setVolume( 0.1, { channel=i } )    
end
audio.reserveChannels( 2 )

timer.performWithDelay( 1000, function (  )
    audio.play( globals.audios[6] ,{channel = 1} )
end , 1 )




composer.gotoScene( "cenas.mainmenu", "crossFade", 500 )  

display.setDefault( "background", 0.8,0.8,0.8 )








