# Testes

## Visao geral
A validacao automatizada do projeto esta centralizada em `test/`, com foco principal na regra de negocio de habitos e no fluxo de estado da camada de apresentacao.

Estrutura atual:

- `test/feature/habits/domain/usecases`: testes unitarios dos casos de uso.
- `test/feature/habits/presentation/cubit`: teste do `HabitsCubit`.
- `test/mocks`: doubles de repositorio, datasource e modelos de apoio.

Nao ha pasta `integration_test/` nem arquivos de teste de widget dedicados na base atual.

## Estrutura por tipo

### Unit
Predominante no projeto.

Cobertura existente:
- `GetHabitsUsecase`
- `InsertHabitUseCase`
- `UpdateHabitUsecase`
- `DeleteHabitUsecase`

Abordagem:
- Mock de `HabitRepository` com `mocktail`.
- Simulacao de retorno `Success` e `Error` (via `Result<T>`).
- Validacao de comportamento nominal (sucesso) e falha (erro).

Objetivo tecnico:
- Garantir que cada caso de uso delega corretamente ao contrato de repositorio.
- Garantir propagacao correta do envelope de resultado (`Success`/`Error`).

### Widget
Estado atual: **nao implementado** como suite dedicada.

Observacao:
- O teste de `HabitsCubit` emula transicoes de estado com `expectLater(... emitsInOrder(...))`, mas nao renderiza arvore de widgets com `pumpWidget`.
- Portanto, a camada visual (paginas/widgets) ainda nao tem validacao automatizada de renderizacao/interacao.

### Integration
Estado atual: **nao implementado**.

Evidencias:
- Nao existe pasta `integration_test/`.
- Nao ha cenarios end-to-end cobrindo navegacao, banco real e fluxo completo de UI.

## Como a logica de habitos e validada
A validacao atual ocorre em dois niveis principais:

1. **Dominio (UseCases)**
- Cada operacao de habito (buscar, criar, atualizar, remover) e testada isoladamente.
- O repositorio e mockado para controlar respostas de sucesso e erro.
- O teste confirma que o caso de uso retorna o tipo esperado (`Success` ou `Error`).

2. **Apresentacao (Cubit)**
- O `HabitsCubit` e exercitado com pipeline real de dominio/data, usando datasource mockado.
- Cenarios cobrem:
  - estado inicial (`HabitsInitial`)
  - carregamento de habitos (`HabitsLoading -> HabitsLoaded`)
  - insercao seguida de recarga de lista
  - edicao seguida de recarga de lista

## Mocks e isolamento
Suporte de testes em `test/mocks/`:

- `repository_mocks.dart`: mock de `HabitRepository` (unit de usecases).
- `datasource_mocks.dart`: mock de `HabitLocalDatasource` (teste de cubit com repositorio real).
- `models_mocks.dart`: massa de dados (`HabitModel`) para cenarios repetiveis.

Esse desenho reduz acoplamento com infraestrutura real (sqflite) e torna os testes deterministas.

## Limites atuais de cobertura
- Sem testes de widget: nao valida renderizacao de estados (`loading`, `erro`, `vazio`, lista) nas telas.
- Sem testes de integracao: nao valida o fluxo ponta a ponta (UI -> Cubit -> UseCase -> Repository -> Datasource -> banco local).
- Sem teste direto da implementacao de `HabitRepositoryImpl` e `HabitLocalDatasourceImpl` contra banco real em ambiente de teste.

## Conclusao tecnica
A estrategia atual valida bem o nucleo da logica de habitos (casos de uso e transicoes de estado do cubit), com boa isolacao por mocks. A cobertura ainda e parcial para confiabilidade de interface e fluxo end-to-end, por ausencia de suites de Widget e Integration.