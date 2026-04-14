# Arquitetura

## Visao geral
Este projeto aplica Clean Architecture no modulo de habitos, com separacao entre regras de negocio (Domain), implementacoes de acesso a dados (Data) e interface/estado de tela (Presentation).

A raiz tecnica esta em `lib/`:

- `lib/core`: infraestrutura compartilhada (DI, rotas, banco local, `Result`).
- `lib/feature/habits/domain`: entidades, contratos de repositorio e casos de uso.
- `lib/feature/habits/data`: datasource local, models e implementacao de repositorio.
- `lib/feature/habits/presentation`: Cubits, estados, paginas e widgets.

## Camadas

### Domain
Responsavel por regras de negocio e contratos estaveis.

Componentes principais:
- **Entities**: `Habit` define o modelo de dominio (`id`, `title`, `createdAt`).
- **Repositories (abstracao)**: `HabitRepository` define operacoes (`insert`, `get`, `update`, `delete`) sem detalhes de infraestrutura.
- **UseCases**:
  - `GetHabitsUsecase`
  - `InsertHabitUseCase`
  - `UpdateHabitUsecase`
  - `DeleteHabitUsecase`

Dependencias: Domain depende apenas de tipos internos e de `core/result`.

### Data
Responsavel por implementacoes concretas de persistencia e mapeamento.

Componentes principais:
- **Datasource**:
  - `HabitLocalDatasource` (contrato)
  - `HabitLocalDatasourceImpl` (usa `sqflite` via `AppDatabase`)
- **Model**: `HabitModel` faz conversao `Map <-> Model <-> Entity`.
- **Repository (implementacao)**: `HabitRepositoryImpl` implementa `HabitRepository`, delega ao datasource e converte `HabitModel` em `Habit`.

Infraestrutura usada:
- `AppDatabase` (singleton lazy de `Database`).
- Tabela `habits` em `core/database/tables/habits_table.dart`.
- Envelope de retorno `Result<T>` com `Success` e `Error`.

### Presentation
Responsavel por UI, navegacao e gerenciamento de estado.

Componentes principais:
- **State Management**:
  - `HabitsCubit` + `HabitsState` para listar/criar/editar.
  - `DeleteHabitCubit` + `DeleteHabitState` para exclusao.
- **Paginas**:
  - `HabitsPage`
  - `NewHabitFormPage`
- **Widgets de composicao**:
  - lista (`ListHabitsWidget`), card (`HabitCard`), estados de tela (`LoadingHabitsViewWidget`, `EmptyHabitViewWidget`, `ErrorHabitsViewWidget`).
- **Roteamento**:
  - `GoRouter` em `core/routes/app_router.dart`.

## Fluxo de dados
Fluxo principal (leitura e renderizacao):

1. UI chama metodo do `HabitsCubit` (ex.: `getHabits`).
2. `HabitsCubit` executa um UseCase (`GetHabitsUsecase`).
3. UseCase chama `HabitRepository` (abstracao de dominio).
4. `HabitRepositoryImpl` delega para `HabitLocalDatasourceImpl`.
5. Datasource executa operacao no `sqflite` (`AppDatabase`).
6. Resultado sobe como `Result<T>` (`Success`/`Error`).
7. Repository converte `HabitModel` para `Habit` quando necessario.
8. Cubit emite estado (`HabitsLoaded` ou `HabitsError`).
9. UI reage ao novo estado e renderiza.

Fluxo de escrita (insert/update/delete) segue o mesmo caminho, mudando apenas o UseCase e a operacao no datasource.

## Inversao de dependencia e composicao
A composicao ocorre em `core/di/injector_container.dart` com `GetIt`:

- registra `HabitLocalDatasourceImpl` como `HabitLocalDatasource`.
- registra `HabitRepositoryImpl` como `HabitRepository`.
- registra os UseCases.
- registra `HabitsCubit` com os casos de uso injetados.

Com isso, a Presentation depende de UseCases, UseCases dependem de contratos, e a implementacao concreta fica isolada na camada Data.

## Componentes-chave (Clean Architecture)

### Entities
- Representam o nucleo do dominio.
- Independentes de framework, banco e UI.
- No projeto: `Habit`.

### UseCases
- Encapsulam a acao de negocio da aplicacao.
- Orquestram acesso ao repositorio por intencao (buscar, inserir, atualizar, remover).
- Mantem a Presentation simples e desacoplada de detalhes de persistencia.

### Repositories
- Interface no Domain (`HabitRepository`) e implementacao no Data (`HabitRepositoryImpl`).
- Ponto de fronteira entre regra de negocio e infraestrutura.
- Permitem troca de fonte de dados sem impacto no dominio e na UI.

## Observacao estrutural
O modulo segue bem a separacao por camadas. Em termos de consistencia arquitetural, ha dois pontos de atencao:

- `DeleteHabitCubit` trata erros com `try/catch`, enquanto os demais fluxos usam `Result<T>` de forma explicita.
- `HabitCard` instancia `DeleteHabitCubit` diretamente no widget, em vez de prover via injeccao/escopo de estado.

Esses pontos nao quebram a arquitetura, mas reduzem a uniformidade entre os fluxos de estado.