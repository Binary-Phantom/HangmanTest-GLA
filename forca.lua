
-- Garante uma semente aleatória diferente a cada execução
math.randomseed(os.time())

-- 1. Definir uma lista com 5 palavras
local palavras = {
    "desenvolvimento",
    "logica",
    "algoritmo",
    "computador",
    "programa"
}

-- Variável que controla se o jogador deseja continuar jogando
local jogarNovamente = true

-- LOOP DAS PARTIDAS
while jogarNovamente do

    -- 2. Escolher uma palavra aleatoriamente
    local palavraEscolhida = palavras[math.random(#palavras)]

    -- Tabela para armazenar as letras que o usuário já acertou
    local letrasDescobertas = {}

    for i = 1, #palavraEscolhida do
        letrasDescobertas[i] = false
    end

    -- Tabela para armazenar as letras que o usuário já tentou
    local letrasTentadas = {}

    -- Configuração do limite de erros
    local errosMaximos = 5
    local errosCometidos = 0

    print("\n================================")
    print("         JOGO DA FORCA")
    print("================================")
    print("Dica: Todas as palavras estão em minúsculo e sem acentos.")

    -- 3. Loop principal da partida
    while errosCometidos < errosMaximos do

        -- Exibir a palavra com asteriscos nas letras não descobertas
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

        -- Verificar condição de vitória
        if ganhou then
            print("\nParabéns! Você descobriu a palavra: " .. palavraEscolhida)
            break
        end

        -- Pedir uma letra ao usuário
        io.write("Escolha uma letra: ")
        local palpite = io.read()

        -- Validação básica da entrada
        if palpite and #palpite == 1 then

            palpite = palpite:lower()

            -- Verificar se a letra já foi escolhida
            if letrasTentadas[palpite] then

                print("Atenção! A letra '" .. palpite .. "' já foi escolhida.")
                print("Escolha uma letra diferente.")

            else

                -- Registrar a letra como já tentada
                letrasTentadas[palpite] = true

                local acertou = false

                -- Verificar se a letra existe na palavra
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

    -- Condição de derrota
    if errosCometidos >= errosMaximos then
        print("\nGame Over! Você atingiu o limite de " ..
            errosMaximos .. " erros.")

        print("A palavra correta era: " .. palavraEscolhida)
    end

    -- Perguntar se o jogador deseja jogar novamente
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
