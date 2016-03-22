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
            system.openURL("https://play.google.com/store/apps/details?id=com.athgames.impeachometro")
        elseif(additionalData.oculos) then
            system.openURL("https://play.google.com/store/apps/details?id=com.athgames.oculosopressor")
        elseif(additionalData.minigame) then
            system.openURL("https://play.google.com/store/apps/details?id=com.athgames.minigameracer")
        end
    else
        native.showAlert("OneSignal Message", message, { "OK" } )
    end
end

local OneSignal = require("plugin.OneSignal")
OneSignal.Init("241065a8-da68-4c69-af71-988c0c080ef3", "186553540640", DidReceiveRemoteNotification)


local composer = require( "composer" )

composer.gotoScene( "mainmenu", "crossFade", 500 )  

display.setDefault( "background", 0.8,0.8,0.8 )






