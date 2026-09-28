--[[

Definir uma lista com 5 palavras à sua escolha;
Escolher uma palavra aleatoriamente;

Criar o loop principal contendo:

Exibir a palavra escolhida com asteriscos nas letras que ainda não foram descobertas;

Permitir até 5 tentativas erradas;

O usuário deve escolher uma letra por vez.
]]




math.randomseed(os.time())

local palavras = {
    "coelho",
    "ventilador",
    "onepiece",
    "computador",
    "programa"
}

local jogarNovamente = true

while jogarNovamente do

    local palavraEscolhida = palavras[math.random(#palavras)]

    local letrasDescobertas = {}

    for i = 1, #palavraEscolhida do
        letrasDescobertas[i] = false
    end

    local letrasTentadas = {}

    local errosMaximos = 5
    local errosCometidos = 0

    print("\n================================")
    print("         JOGO DA FORCA")
    print("================================")
    --print("Dica: Todas as palavras estão em minúsculo e sem acentos.")

    while errosCometidos < errosMaximos do

        local exibicao = ""
        local ganhou = true

        for i = 1, #palavraEscolhida do

            local letra = palavraEscolhida:sub(i, i)

            if letrasDescobertas[i] then
                exibicao = exibicao .. letra .. " "
            else
                exibicao = exibicao .. "* "
                ganhou = false
            end

        end

        print("\nPalavra: " .. exibicao)
        print("Tentativas erradas: " .. errosCometidos .. "/" .. errosMaximos)

        if ganhou then
            print("\nParabéns! Você descobriu a palavra: " .. palavraEscolhida)
            break
        end


        io.write("Escolha uma letra: ")
        local palpite = io.read()

        if palpite and #palpite == 1 then

            palpite = palpite:lower()

            if letrasTentadas[palpite] then

                print("Atenção! A letra '" .. palpite .. "' já foi escolhida.")
                print("Escolha uma letra diferente.")

            else

                letrasTentadas[palpite] = true

                local acertou = false

                for i = 1, #palavraEscolhida do

                    if palavraEscolhida:sub(i, i) == palpite then
                        letrasDescobertas[i] = true
                        acertou = true
                    end

                end

                if acertou then
                    print("Boa! A letra '" .. palpite .. "' existe na palavra.")
                else
                    errosCometidos = errosCometidos + 1

                    print(
                        "Que pena! A letra '" ..
                        palpite ..
                        "' não existe na palavra."
                    )
                end

            end

        else
            print("Entrada inválida. Digite apenas uma única letra.")
        end

    end

    if errosCometidos >= errosMaximos then
        print("\nGame Over! Você atingiu o limite de " ..
            errosMaximos .. " erros.")

        print("A palavra correta era: " .. palavraEscolhida)
    end

    print("\n================================")

    io.write("Deseja jogar novamente? (s/n): ")
    local resposta = io.read()

    if resposta then
        resposta = resposta:lower()
    end

    if resposta == "s" then
        jogarNovamente = true
        print("\nIniciando uma nova partida...")

    else
        jogarNovamente = false
        print("\nObrigado por jogar! Até a próxima!")
    end

end
