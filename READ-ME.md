# Gestão Inteligente de Dados Industriais para Decisões em Tempo Real

Scripts SQL utilizados no trabalho de conclusão de curso de pós-graduação MBA em Engenharia de Software — USP/ESALq.

## Contexto

Este repositório reúne os scripts utilizados para implementação e avaliação das otimizações para gerenciamento de banco de dados. O estudo foi realizado em uma tabela PostgreSQL utilizada para coleta de dados de API's de dados industriais com aproximadamente 3 milhões de registros e mais de 5 GB de utilização de disco.

O estudo avaliou três cenários, sendo eles:

- 1 - Tabela Original: Tabela comum do PostgreSQL sem índices e sem políticas de compressão;
- 2 - Tabela Indexada: Tabela comum com adição de índices do tipo B-Tree para as principais colunas filtradas;
- 3 - Hypertable: Tabela convertida para Hypertable utilizando a função TimescaleDB com compressão e retenção automática de dados.

## Como utilizar

O estudo pode ser replicado a partir da execução das seguintes rotinas:

- 1 - Criação das estruturas de dados: Disponível em '/ddls';
- 2 - Implementação de otimizações: Disponível em '/optimizations';
- 3 - Análise de Performances: Disponível em 'performance/evaluation';
- 4 - Análise de Armazenamento: Disponível em 'storage/evaluation'.

## Observações

Apesar de todos os scripts terem sido testados e implementados, ainda assim é necessário a configuração de rotinas que preencham as tabelas para que o material de estudo possa ser de fato investigado, avaliando sua progressão no uso de armazenamento e análise de performance de consulta de dados.

## Referências

- Ramu, V.B. (2023). Optimizing database performance: strategies for efficient query execution and resource utilization. IJCTT, 71(7), 15-21.
- PostgreSQL Documentation (2024). Chapter 11: Indexes. https://www.postgresql.org/docs/current/indexes.html
- Timescale Inc. (2023). TimescaleDB vs. PostgreSQL for time-series data. https://www.timescale.com/blog/timescaledb-vs-6a696248104e/
