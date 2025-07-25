# Diagnóstico Probabilístico de Diabetes - Prolog 

Este projeto foi desenvolvido como parte da disciplina de **Programação em Lógica (Prolog)**.
O objetivo é criar um sistema interativo capaz de realizar um diagnóstico **probabilístico de diabetes** com base nas informações fornecidas pelo usuário.

## Funcionalidades

* Cadastro de pacientes com dados médicos e pessoais.
* Cálculo de IMC e pontuação de risco.
* Diagnóstico automático: "Tem Diabetes" ou "Não Tem Diabetes".
* Edição, listagem e remoção de pacientes.
* Sistema de pontuação baseado em critérios clínicos e banco de dados.

## Lógica de Diagnóstico

A pontuação é atribuída conforme os seguintes critérios:

| Critério           | Pontuação |
| ------------------ | --------- |
| Hemoglobina > 6.7  | 300 pts   |
| Glicose > 200      | 250 pts   |
| IMC > 30.0         | 300 pts   |
| Fumante = "sim"    | 50 pts    |
| Cardíaco = "sim"   | 50 pts    |
| Hipertenso = "sim" | 50 pts    |

> Diagnóstico:
>
> * Pontuação > 550 → **Tem Diabetes**
> * Pontuação ≤ 550 → **Não Tem Diabetes**

Se **duas ou mais respostas** de saúde forem omitidas, o sistema fará perguntas adicionais:

* Histórico de diabetes na família ("sim") → +50 pts
* Não praticar exercícios físicos ("não") → +50 pts

## Como Executar

1. **Abra o terminal** no diretório onde está o arquivo `.pl`.
2. **Inicie o programa** no interpretador Prolog com:

   ```prolog
   ?- programa.
   ```
3. Siga as instruções no terminal interagindo com o menu.

## Menu de Opções

```
01 - Adicionar Paciente
02 - Listar Pacientes
03 - Remover Paciente
04 - Editar Paciente
00 - Sair
```

## Exemplo de Uso

```
?- programa.
-------------- MENU --------------
01 - Adicionar Paciente
...
Digite o nome do paciente:
> João
Digite o peso:
> 85
...
IMC calculado: 30.2
Pontuação Total: 650
Diagnóstico: Tem Diabetes
```

## Observações

* O código é sensível à entrada correta de dados (evite campos em branco, exceto os opcionais).
* O banco de dados de pacientes é mantido na memória enquanto o Prolog estiver em execução.

## Tecnologias Utilizadas

* **Linguagem**: Prolog (SWI-Prolog recomendado)
* **Paradigma**: Programação Lógica
* **Técnicas**: Base de conhecimento dinâmica, inferência lógica, sistema de pontuação.
