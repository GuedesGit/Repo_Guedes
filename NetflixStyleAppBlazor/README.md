
# NetflixStyleAppServer

## Objetivo
Esta aplicação Blazor Server simula uma plataforma de streaming estilo Netflix.
Permite listar, visualizar e gerir filmes, séries, episódios e utilizadores, com dados armazenados numa base de dados SQL Server local.
Os modelos (`Movie`, `User`, `Episode`) e scripts SQL foram criados para facilitar a configuração e testes da base de dados.

## Como executar
1. Certifique-se que o SQL Server LocalDB está disponível e os scripts da BD (pasta `Scripts`) foram executados.
2. No terminal do VS Code, execute:
   ```powershell
   dotnet run
   ```
3. Aceda ao endereço apresentado (ex: http://localhost:5000) no browser.

## Estrutura do projeto
- Componentes Razor, layouts e páginas migrados do projeto original
- Modelos e DbContext para acesso à base de dados
- Configuração de SQL Server via Entity Framework Core
- Scripts SQL para criar e popular a BD local

## Estado das páginas
- **Home, Counter, Weather**: Páginas base presentes, mas ainda não mostram conteúdo da base de dados
- **Modelos e DbContext**: Prontos para acesso à BD
- **Layouts e navegação**: Prontos e funcionais
- **Scripts SQL**: Permitem criar e popular a BD local

## Próximos passos
- Implementar páginas e componentes para listar e mostrar filmes, séries, episódios e utilizadores diretamente da base de dados
- Integrar funcionalidades de pesquisa, favoritos e detalhes

## Notas
- O acesso à base de dados é feito diretamente no servidor
- Não é necessário backend adicional para consumir dados
- Scripts SQL para criar e popular a BD estão na pasta `Scripts` do projeto
