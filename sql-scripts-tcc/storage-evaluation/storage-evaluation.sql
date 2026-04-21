SELECT
    pg_size_pretty(pg_relation_size(c.oid)) AS data,
    pg_size_pretty(pg_relation_size(c.reltoastrelid)) AS toast,
    pg_size_pretty(pg_indexes_size(c.oid)) AS indexes,
    pg_size_pretty(pg_total_relation_size(c.oid)) AS total
FROM pg_class c
JOIN pg_namespace n ON n.oid = c.relnamespace
WHERE c.relname = 'api_production_data';

SELECT 
        pg_size_pretty(table_bytes),
        pg_size_pretty(index_bytes),
        pg_size_pretty(toast_bytes),
        pg_size_pretty(total_bytes)
FROM hypertable_detailed_size('tcc.api_data')