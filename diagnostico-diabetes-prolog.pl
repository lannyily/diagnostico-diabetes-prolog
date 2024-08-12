% -----------------------------------------------------------------------
% -------------- Para executar o programa, siga estas etapas -----------
% ----------------------------------------------------------------------
% Inicie o Programa: No terminal , digite 'programa.' e pressione Enter.
% ----------------------------------------------------------------------
% Interajir com o progama: apenas digitado a resposta e dando Enter.
% ----------------------------------------------------------------------
% O programa vai avaliar se a pessoa tem diabetes com base nas
% informa��es dadas pelo usu�rio, cada informa��o tem uma pontua��o:
% ----------------------------------
% | Hemoglobina > 6.7 | 300 pontos |
% |Glicose > 200      | 250 pontos |
% |IMC > 30.0         | 300 pontos |
% |Fumante "sim"      | 50 pontos  |
% |Card�aco "sim"     | 50 pontos  |
% |Hipertenso "sim"   | 50 pontos  |
% ----------------------------------
% -----------------------------------------------------------------------
% ------------- Valor que define o status do paciente ------------------
% Pontua��o > 550 = "Tem Diabetes"
% Pontua��o < 550 = "N�o Tem Diabetes"
% -----------------------------------------------------------------------
% Se n�o preencher duas ou mais perguntas sobre sa�de, o programa far�
% duas perguntas adicionais:
% Se tem hist�rico de diabetes na fam�lia "sim" = 50
% Se praticar exerc�cios f�sicos "nao" = 50
% ----------------------------------------------------------------------
% Cada pontua��o foi determinada pela relev�ncia da pergunta a partir de
% uma an�lise feita no banco de dados fornecido.
% ----------------------------------------------------------------------
% --------------------- Menu de Op��es ---------------------------------
% Adicionar Paciente (adicionar_paciente): Cadastra um novo paciente.
% Listar Pacientes (listar_pacientes e listar_todos_pacientes): Exibe a
% lista de todos os pacientes cadastrados e suas informa��es.
% Remover Paciente (remover_paciente): Remove um paciente do banco de
% dados.
% Editar Paciente (editar_paciente e editar_opcao): Permite atualizar as
% informa��es de um paciente existente.
% Sair (programa): Encerra o programa.
% ----------------------------------------------------------------------

:- dynamic paciente/10.

calcular_IMC(Peso, Altura, IMC) :-
    (   Altura =:= 0 ->
        write('Altura n�o pode ser zero para calcular o IMC!'), nl, fail
    ;   IMC is Peso / (Altura * Altura)
    ).

diagnosticar_diabetes(Hemoglobina, Glicose, IMC, Fumante, Cardiaco, Hipertensao, Pontuacao, Diagnostico) :-
    (   Hemoglobina > 6.7 -> HemoglobinaPontos is 300
    ;   HemoglobinaPontos is 100
    ),
    (   Glicose > 200 -> GlicosePontos is 250
    ;   GlicosePontos is 100
    ),
    (   IMC > 30.0 -> IMCPontos is 300
    ;   IMCPontos is 100
    ),
    (   Fumante = 'sim' -> FumantePontos is 50
    ;   FumantePontos is 0
    ),
    (   Cardiaco = 'sim' -> CardiacoPontos is 50
    ;   CardiacoPontos is 0
    ),
    (   Hipertensao = 'sim' -> HipertensaoPontos is 50
    ;   HipertensaoPontos is 0
    ),
    Pontuacao is HemoglobinaPontos + GlicosePontos + IMCPontos + FumantePontos + CardiacoPontos + HipertensaoPontos,
    (   Pontuacao > 550 -> Diagnostico = 'Tem Diabetes'
    ;   Diagnostico = 'N�o Tem Diabetes'
    ).

adicionar_paciente :-
    write('Digite o nome do paciente:'), nl,
    read_line_to_string(user_input, Nome),
    (   Nome = "" ->
        write('Nome � obrigat�rio!'), nl, fail
    ;   true
    ),
    write('Digite o sexo do paciente:'), nl,
    read_line_to_string(user_input, Sexo),
    (   Sexo = "" ->
        write('Sexo � obrigat�rio!'), nl, fail
    ;   true
    ),
    write('Digite a idade do paciente:'), nl,
    read_line_to_string(user_input, IdadeStr),
    (   IdadeStr = "" ->
        write('Idade � obrigat�ria!'), nl, fail
    ;   (   atom_number(IdadeStr, Idade) ->
            true
        ;   write('Idade deve ser um n�mero!'), nl, fail
        )
    ),
    write('Digite o peso do paciente:'), nl,
    read_line_to_string(user_input, PesoStr),
    (   PesoStr = "" ->
        write('Peso � obrigat�rio!'), nl, fail
    ;   (   atom_number(PesoStr, Peso) ->
            true
        ;   write('Peso deve ser um n�mero!'), nl, fail
        )
    ),
    write('Digite a altura do paciente:'), nl,
    read_line_to_string(user_input, AlturaStr),
    (   AlturaStr = "" ->
        write('Altura � obrigat�ria!'), nl, fail
    ;   (   atom_number(AlturaStr, Altura) ->
            true
        ;   write('Altura deve ser um n�mero!'), nl, fail
        )
    ),
    write('Digite a hemoglobina do paciente:'), nl,
    read_line_to_string(user_input, HemoglobinaStr),
    (   HemoglobinaStr = "" -> Hemoglobina = 0; atom_number(HemoglobinaStr, Hemoglobina)
    ),
    write('Digite a glicose do paciente:'), nl,
    read_line_to_string(user_input, GlicoseStr),
    (   GlicoseStr = "" -> Glicose = 0; atom_number(GlicoseStr, Glicose)
    ),
    write('O paciente tem hipertens�o? (opcional, pressione Enter para pular):'), nl,
    read_line_to_string(user_input, HipertensaoStr),
    (   HipertensaoStr = "" -> Hipertensao = 'n�o informado'; Hipertensao = HipertensaoStr
    ),
    write('O paciente tem problema card�aco? (opcional, pressione Enter para pular):'), nl,
    read_line_to_string(user_input, CardiacoStr),
    (   CardiacoStr = "" -> Cardiaco = 'n�o informado'; Cardiaco = CardiacoStr
    ),
    write('O paciente � fumante? (opcional, pressione Enter para pular):'), nl,
    read_line_to_string(user_input, FumanteStr),
    (   FumanteStr = "" -> Fumante = 'n�o informado'; Fumante = FumanteStr
    ),
    findall(X, (member(X, [Hipertensao, Cardiaco, Fumante]), X = 'n�o informado'), PerguntasEmBranco),
    length(PerguntasEmBranco, QuantidadeEmBranco),
    (   QuantidadeEmBranco >= 2 ->
        write('O paciente tem hist�rico de diabetes na fam�lia? (sim/n�o):'), nl,
        read_line_to_string(user_input, DiabetesHistorico),
        (   DiabetesHistorico = "sim" -> DiabetesPontos is 50; DiabetesPontos is 0
        ),
        write('O paciente pratica exerc�cio f�sico? (sim/n�o):'), nl,
        read_line_to_string(user_input, ExerciciosFisicos),
        (   ExerciciosFisicos = "n�o" -> ExerciciosPontos is 50; ExerciciosPontos is 0
        )
    ;   DiabetesPontos = 0, ExerciciosPontos = 0
    ),
    calcular_IMC(Peso, Altura, IMC),
    assertz(paciente(Nome, Sexo, Idade, Peso, Altura, Hemoglobina, Glicose, Hipertensao, Cardiaco, Fumante)),
    diagnosticar_diabetes(Hemoglobina, Glicose, IMC, Fumante, Cardiaco, Hipertensao, Pontuacao, Diagnostico),
    Pontuacao is Pontuacao + DiabetesPontos + ExerciciosPontos,
    write('Paciente adicionado com sucesso!'), nl,
    write('IMC calculado: '), write(IMC), nl,
    write('Pontua��o Total: '), write(Pontuacao), nl,
    write('Diagn�stico: '), write(Diagnostico), nl.



listar_pacientes :-
    (   \+ paciente(_, _, _, _, _, _, _, _, _, _) ->
        write('Nenhum paciente cadastrado.'), nl
    ;   listar_todos_pacientes
    ).

listar_todos_pacientes :-
    paciente(Nome, Sexo, Idade, Peso, Altura, Hemoglobina, Glicose, Hipertensao, Cardiaco, Fumante),
    write('Nome: '), write(Nome), nl,
    write('Sexo: '), write(Sexo), nl,
    write('Idade: '), write(Idade), nl,
    write('Peso: '), write(Peso), nl,
    write('Altura: '), write(Altura), nl,
    (   Altura =:= 0 ->
        write('IMC: Altura inv�lida para c�lculo.'), nl
    ;   IMC is Peso / (Altura * Altura),
        format('IMC: ~2f', [IMC]), nl
    ),
    write('Hemoglobina: '), write(Hemoglobina), nl,
    write('Glicose: '), write(Glicose), nl,
    write('Hipertensao: '), write(Hipertensao), nl,
    write('Cardiaco: '), write(Cardiaco), nl,
    write('Fumante: '), write(Fumante), nl,
    write('----------------------------------'), nl,
    fail.
listar_todos_pacientes.

editar_paciente :-
    write('Digite o nome do paciente a ser editado:'), nl,
    read_line_to_string(user_input, Nome),
    (   Nome = "" ->
        write('Nome � obrigat�rio!'), nl, fail
    ;   (   paciente(Nome, Sexo, Idade, Peso, Altura, Hemoglobina, Glicose, Hipertensao, Cardiaco, Fumante) ->
            write('Paciente encontrado!'), nl,
            write('Nome: '), write(Nome), nl,
            write('Sexo: '), write(Sexo), nl,
            write('Idade: '), write(Idade), nl,
            write('Peso: '), write(Peso), nl,
            write('Altura: '), write(Altura), nl,
            write('Hemoglobina: '), write(Hemoglobina), nl,
            write('Glicose: '), write(Glicose), nl,
            write('Hipertens�o: '), write(Hipertensao), nl,
            write('Card�aco: '), write(Cardiaco), nl,
            write('Fumante: '), write(Fumante), nl,
            write('Escolha o que deseja editar:'), nl,
            write('1 - Sexo'), nl,
            write('2 - Idade'), nl,
            write('3 - Peso'), nl,
            write('4 - Altura'), nl,
            write('5 - Hemoglobina'), nl,
            write('6 - Glicose'), nl,
            write('7 - Hipertens�o'), nl,
            write('8 - Card�aco'), nl,
            write('9 - Fumante'), nl,
            write('0 - Voltar ao Menu'), nl,
            read_line_to_string(user_input, OpcaoStr),
            (   atom_number(OpcaoStr, Opcao), integer(Opcao) ->
                editar_opcao(Nome, Opcao, Sexo, Idade, Peso, Altura, Hemoglobina, Glicose, Hipertensao, Cardiaco, Fumante)
            ;   write('Entrada inv�lida. Tente novamente.'), nl, fail
            )
        ;   write('Paciente n�o encontrado.'), nl
        )
    ).

editar_opcao(Nome, Opcao, Sexo, Idade, Peso, Altura, Hemoglobina, Glicose, Hipertensao, Cardiaco, Fumante) :-
    (   Opcao =:= 1 ->
        write('Digite o novo sexo do paciente:'), nl,
        read_line_to_string(user_input, NovoSexo),
        (   NovoSexo = "" -> NovoSexo = Sexo; true),
        editar_paciente_dados(Nome, NovoSexo, Idade, Peso, Altura, Hemoglobina, Glicose, Hipertensao, Cardiaco, Fumante)
    ;   Opcao =:= 2 ->
        write('Digite a nova idade do paciente:'), nl,
        read_line_to_string(user_input, NovaIdadeStr),
        (   NovaIdadeStr = "" -> NovaIdadeStr = Idade; true),
        (   atom_number(NovaIdadeStr, NovaIdade) ->
            editar_paciente_dados(Nome, Sexo, NovaIdade, Peso, Altura, Hemoglobina, Glicose, Hipertensao, Cardiaco, Fumante)
        ;   write('Idade deve ser um n�mero!'), nl, fail
        )
    ;   Opcao =:= 3 ->
        write('Digite o novo peso do paciente:'), nl,
        read_line_to_string(user_input, NovoPesoStr),
        (   NovoPesoStr = "" -> NovoPesoStr = Peso; true),
        (   atom_number(NovoPesoStr, NovoPeso) ->
            editar_paciente_dados(Nome, Sexo, Idade, NovoPeso, Altura, Hemoglobina, Glicose, Hipertensao, Cardiaco, Fumante)
        ;   write('Peso deve ser um n�mero!'), nl, fail
        )
    ;   Opcao =:= 4 ->
        write('Digite a nova altura do paciente:'), nl,
        read_line_to_string(user_input, NovaAlturaStr),
        (   NovaAlturaStr = "" -> NovaAlturaStr = Altura; true),
        (   atom_number(NovaAlturaStr, NovaAltura) ->
            editar_paciente_dados(Nome, Sexo, Idade, Peso, NovaAltura, Hemoglobina, Glicose, Hipertensao, Cardiaco, Fumante)
        ;   write('Altura deve ser um n�mero!'), nl, fail
        )
    ;   Opcao =:= 5 ->
        write('Digite a nova hemoglobina do paciente:'), nl,
        read_line_to_string(user_input, NovaHemoglobinaStr),
        (   NovaHemoglobinaStr = "" -> NovaHemoglobinaStr = Hemoglobina; true),
        (   atom_number(NovaHemoglobinaStr, NovaHemoglobina) ->
            editar_paciente_dados(Nome, Sexo, Idade, Peso, Altura, NovaHemoglobina, Glicose, Hipertensao, Cardiaco, Fumante)
        ;   write('Hemoglobina deve ser um n�mero!'), nl, fail
        )
    ;   Opcao =:= 6 ->
        write('Digite a nova glicose do paciente:'), nl,
        read_line_to_string(user_input, NovaGlicoseStr),
        (   NovaGlicoseStr = "" -> NovaGlicoseStr = Glicose; true),
        (   atom_number(NovaGlicoseStr, NovaGlicose) ->
            editar_paciente_dados(Nome, Sexo, Idade, Peso, Altura, Hemoglobina, NovaGlicose, Hipertensao, Cardiaco, Fumante)
        ;   write('Glicose deve ser um n�mero!'), nl, fail
        )
    ;   Opcao =:= 7 ->
        write('O paciente tem hipertens�o? (opcional, pressione Enter para pular):'), nl,
        read_line_to_string(user_input, NovaHipertensao),
        (   NovaHipertensao = "" -> NovaHipertensao = Hipertensao; true),
        editar_paciente_dados(Nome, Sexo, Idade, Peso, Altura, Hemoglobina, Glicose, NovaHipertensao, Cardiaco, Fumante)
    ;   Opcao =:= 8 ->
        write('O paciente tem problema card�aco? (opcional, pressione Enter para pular):'), nl,
        read_line_to_string(user_input, NovoCardiaco),
        (   NovoCardiaco = "" -> NovoCardiaco = Cardiaco; true),
        editar_paciente_dados(Nome, Sexo, Idade, Peso, Altura, Hemoglobina, Glicose, Hipertensao, NovoCardiaco, Fumante)
    ;   Opcao =:= 9 ->
        write('O paciente � fumante? (opcional, pressione Enter para pular):'), nl,
        read_line_to_string(user_input, NovoFumante),
        (   NovoFumante = "" -> NovoFumante = Fumante; true),
        editar_paciente_dados(Nome, Sexo, Idade, Peso, Altura, Hemoglobina, Glicose, Hipertensao, Cardiaco, NovoFumante)
    ;   Opcao =:= 0 ->
        !
    ;   write('Op��o inv�lida. Tente novamente.'), nl, fail
    ).

editar_paciente_dados(Nome, NovoSexo, NovaIdade, NovoPeso, NovaAltura, NovaHemoglobina, NovaGlicose, NovaHipertensao, NovoCardiaco, NovoFumante) :-
    retract(paciente(Nome, _, _, _, _, _, _, _, _, _)),
    (   NovoPeso \= -1, NovaAltura \= -1 ->
        calcular_IMC(NovoPeso, NovaAltura, NovoIMC)
    ;   NovoPeso = -1, NovaAltura = -1 ->
        NovoIMC = -1
    ),
    diagnosticar_diabetes(NovaHemoglobina, NovaGlicose, NovoIMC, NovoFumante, NovoCardiaco, NovaHipertensao, Pontuacao, Diagnostico),
    assertz(paciente(Nome, NovoSexo, NovaIdade, NovoPeso, NovaAltura, NovaHemoglobina, NovaGlicose, NovaHipertensao, NovoCardiaco, NovoFumante)),
    write('Paciente editado com sucesso!'), nl,
    (   NovoIMC \= -1 ->
        write('IMC recalculado: '), write(NovoIMC), nl
    ;   true
    ),
    write('Pontua��o Total: '), write(Pontuacao), nl,
    write('Diagn�stico: '), write(Diagnostico), nl.

remover_paciente :-
    write('Digite o nome do paciente a ser removido:'), nl,
    read_line_to_string(user_input, Nome),
    (   Nome = "" ->
        write('Nome � obrigat�rio!'), nl, fail
    ;   (   retract(paciente(Nome, _, _, _, _, _, _, _, _, _)) ->
            write('Paciente removido com sucesso!'), nl
        ;   write('Paciente n�o encontrado.'), nl
        )
    ).

menu :-
    write('-------------- MENU --------------'), nl,
    write('Escolha uma op��o:'), nl,
    write('01 - Adicionar Paciente'), nl,
    write('02 - Listar Pacientes'), nl,
    write('03 - Remover Paciente'), nl,
    write('04 - Editar Paciente'), nl,
    write('00 - Sair'), nl,
    write('----------------------------------'), nl.

processar_opcao(Opcao) :-
    (   Opcao =:= 1 -> adicionar_paciente
    ;   Opcao =:= 2 -> listar_pacientes
    ;   Opcao =:= 3 -> remover_paciente
    ;   Opcao =:= 4 -> editar_paciente
    ;   Opcao =:= 0 -> write('Saindo...'), nl, !
    ;   write('Op��o inv�lida. Tente novamente.'), nl, fail
    ).

programa :-
    repeat,
    menu,
    read_line_to_string(user_input, OpcaoStr),
    (   atom_number(OpcaoStr, Opcao), integer(Opcao) ->
        processar_opcao(Opcao)
    ;   write('Entrada inv�lida. Tente novamente.'), nl, fail
    ),
    Opcao =:= 0.

