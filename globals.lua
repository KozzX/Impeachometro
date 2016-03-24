local globals = 
{
	appId = "ec2-54-207-21-98.sa-east-1.compute.amazonaws.com",
	apiKey = "694fa5e9-162f-42ef-9e8a-ee59dd5e321a",
	numero = 0,
    aux = 1,
    player = {
        voto="",
        pushId="",
        pushToken="",
    },
	fonts = 
	{
		"royal-serif.ttf",
		"agoestoesan.ttf",
	},
    loadAudio = {
        "audio/ambiente.wav",
        "audio/coff.wav",
        "audio/engasguei.wav",
        "audio/golpe.wav",
        "audio/porta.wav",
        "audio/sapiens.wav",
        "audio/neymar.wav",
        "audio/ganhar.wav",
        "audio/mosquito.wav",
    },
    audios = {},
    loadPoint = "audio/Point.wav",
    point = {},
    loadBeep = "audio/beep.wav",
    beep = {},
    inGame = false

	
}

globals.changeBackground = function ( rot )
	local r = 0 
    local g = 0 
    local b = 0

    if (rot>=(-100)) and (rot <=(18)) then
        r=255
        g= (((-90)-(rot))*(-1)) * (255/108)
        b=0
    elseif (rot>(18)) and (rot <=(54)) then
        r= (54-rot) * (255/36)
        g= 255
        b=0
    elseif (rot>(54)) and (rot <=(200)) then
        r= 0
        g= (90-rot) * (255/36)
        b= (rot-54) * (255/36)
    end
    local cor = {r/255,g/255,b/255}

   display.setDefault( "background", cor[1],cor[2],cor[3] )
end

globals.percorrer = function (  )
    if (globals.numero <= -90) then
        globals.aux=(1)
    elseif (globals.numero >=90) then
        globals.aux=(-1)
    end
    globals.numero = globals.numero + globals.aux
    globals.changeBackground(globals.numero)
end


return globals