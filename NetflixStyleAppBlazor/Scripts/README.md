# Scripts SQL - NetflixStyleApp

Esta pasta contém os scripts SQL necessários para configurar a base de dados da aplicação Netflix Style.

## 📁 Ficheiros Disponíveis

### 1. `01_CreateDatabase.sql`
- **Propósito**: Cria a base de dados `NetflixStyleAppDb`
- **Funcionalidade**: 
  - Verifica se a BD já existe e elimina-a se necessário
  - Cria uma nova base de dados limpa

### 2. `02_CreateTables.sql`
- **Propósito**: Cria todas as tabelas necessárias
- **Tabelas criadas**:
  - `Movies` - Filmes e séries
  - `Users` - Utilizadores da aplicação
  - `Episodes` - Episódios das séries
  - `UserFavorites` - Filmes favoritos dos utilizadores
- **Funcionalidades extras**:
  - Chaves estrangeiras e restrições
  - Índices para melhor performance
  - Campos de auditoria (CreatedDate, UpdatedDate)

### 3. `03_InsertSampleData.sql`
- **Propósito**: Insere dados de exemplo para testar a aplicação
- **Dados incluídos**:
  - 10 filmes populares
  - 8 séries conhecidas
  - 5 utilizadores de exemplo
  - Episódios para algumas séries
  - Filmes favoritos para os utilizadores

### 4. `04_RunAll.sql` ⭐ **RECOMENDADO**
- **Propósito**: Script completo que executa tudo de uma vez
- **Funcionalidade**: Combina os 3 scripts anteriores numa execução única
- **Vantagens**: 
  - Configuração completa em um só passo
  - Verificação final dos dados inseridos
  - Mensagens de progresso detalhadas

## 🔧 Como Executar

### Opção 1: Script Completo (Recomendado)
```sql
-- Execute apenas este ficheiro no SQL Server Management Studio (SSMS)
-- ou no Azure Data Studio
Scripts/04_RunAll.sql
```

### Opção 2: Scripts Individuais
```sql
-- Execute na seguinte ordem:
1. Scripts/01_CreateDatabase.sql
2. Scripts/02_CreateTables.sql
3. Scripts/03_InsertSampleData.sql
```

## 📋 Pré-requisitos

- SQL Server LocalDB (já configurado no appsettings.json)
- SQL Server Management Studio ou Azure Data Studio
- Permissões para criar bases de dados

## 🔍 Verificação

Após executar os scripts, pode verificar se tudo correu bem executando:

```sql
USE NetflixStyleAppDb;

-- Verificar tabelas criadas
SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_TYPE = 'BASE TABLE';

-- Verificar dados inseridos
SELECT 'Movies' as Tabela, COUNT(*) as Total FROM Movies
UNION ALL
SELECT 'Users', COUNT(*) FROM Users
UNION ALL  
SELECT 'Episodes', COUNT(*) FROM Episodes
UNION ALL
SELECT 'UserFavorites', COUNT(*) FROM UserFavorites;
```

## ⚠️ Notas Importantes

1. **Backup**: Os scripts eliminam a base de dados existente. Faça backup se necessário.
2. **Connection String**: Certifique-se que a connection string no `appsettings.json` está correta.
3. **LocalDB**: Se não tiver o SQL Server LocalDB instalado, pode alterar a connection string para usar outra instância do SQL Server.

## 🧪 Dados de Teste

Os scripts incluem dados realistas para testar a aplicação:
- Filmes clássicos e recentes
- Séries populares com episódios
- Utilizadores com diferentes preferências
- Relacionamentos entre utilizadores e filmes favoritos

Estes dados permitem testar todas as funcionalidades da aplicação sem precisar inserir dados manualmente.
