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
        "audio/cachorro.wav",
        "audio/coff.wav",
        "audio/conta.wav",
        "audio/engasguei.wav",
        "audio/ganhar.wav",
        "audio/golpe.wav",
        "audio/mandioca.wav",
        "audio/meta.wav",
        "audio/mosquito.wav",
        "audio/neymar.wav",
        "audio/porta.wav",
        "audio/quatro.wav",
        "audio/sapiens.wav",
    },
    audios = {},
    loadPoint = "audio/Point.wav",
    point = {},
    loadBeep = "audio/beep.wav",
    beep = {},
    loadErro = "audio/error.wav",
    erro = {},
    loadSuccess = "audio/success.mp3",
    success = {},
    inGame = false,
    c={
        conquistaPrimeiraFase="CgkIoMDU-7YFEAIQCA",
        conquistaSegundaFase="CgkIoMDU-7YFEAIQCQ",
        conquistaTerceiraFase="CgkIoMDU-7YFEAIQCg",
        conquistaQuartaFase="CgkIoMDU-7YFEAIQDQ",
        conquistaQuintaFase="CgkIoMDU-7YFEAIQDg",
        conquistaSextaFase="CgkIoMDU-7YFEAIQDw",
        conquistaSetimaFase="CgkIoMDU-7YFEAIQEA",
        conquistaOitavaFase="CgkIoMDU-7YFEAIQEQ",
        conquistaNonaFase="CgkIoMDU-7YFEAIQEg",
        conquistaDecimaFase="CgkIoMDU-7YFEAIQEw",
        conquistaDecimaPrimeiraFase="CgkIoMDU-7YFEAIQFA",
        conquistaDecimaSegundaFase="CgkIoMDU-7YFEAIQFQ",
        conquistaDecimaTerceiraFase="CgkIoMDU-7YFEAIQFg",
        conquistaDecimaQuartaFase="CgkIoMDU-7YFEAIQFw",
        conquistaDecimaQuintaFase="CgkIoMDU-7YFEAIQGA",
        conquistaDecimaSextaFase="CgkIoMDU-7YFEAIQGQ",
        conquistaDecimaSetimaFase="CgkIoMDU-7YFEAIQGg",
        conquistaDecimaOitavaFase="CgkIoMDU-7YFEAIQGw",
        conquistaDecimaNonaFase="CgkIoMDU-7YFEAIQHA",
        conquistaVigesimaFase="CgkIoMDU-7YFEAIQHQ",
        conquistaVigesimaPrimeiraFase="CgkIoMDU-7YFEAIQHg",
        conquistaVigesimaSegundaFase="CgkIoMDU-7YFEAIQHw",
        conquistaVigesimaTerceiraFase="CgkIoMDU-7YFEAIQIA",
        conquistaVigesimaQuartaFase="CgkIoMDU-7YFEAIQIQ",
        conquistaVigesimaQuintaFase="CgkIoMDU-7YFEAIQIg",
        conquistaFora="CgkIoMDU-7YFEAIQCw",
        conquistaFica="CgkIoMDU-7YFEAIQDA",
        conquista10Em1="CgkIoMDU-7YFEAIQIw",
        conquista50Em1="CgkIoMDU-7YFEAIQJA",
        conquista75Em1="CgkIoMDU-7YFEAIQJQ",
        conquista100Em1="CgkIoMDU-7YFEAIQJg",
        conquista150Em1="CgkIoMDU-7YFEAIQJw",
        conquista200Em1="CgkIoMDU-7YFEAIQAw",
        conquista500Em1="CgkIoMDU-7YFEAIQBA",
        conquista1000Totais="CgkIoMDU-7YFEAIQKA",
        conquista3000Totais="CgkIoMDU-7YFEAIQKQ",
        conquista5000Totais="CgkIoMDU-7YFEAIQKg",
        conquista10000Totais="CgkIoMDU-7YFEAIQBg",
        conquista50000Totais="CgkIoMDU-7YFEAIQBw",
        conquista100000Totais="CgkIoMDU-7YFEAIQBQ",
    },

	
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