CREATE OR REPLACE FUNCTION tcc.performance_evaluation(query text, max_runs integer, warmup_runs integer DEFAULT 10)
 RETURNS void
 LANGUAGE plpgsql
AS $function$
DECLARE
    i    int;
    plan json;
    root json;
BEGIN
    
    FOR i IN 1..warmup_runs LOOP
        EXECUTE format('EXPLAIN (ANALYZE, BUFFERS, FORMAT JSON) %s', query)
        INTO plan;
    END LOOP;

    
    FOR i IN 1..max_runs LOOP
        EXECUTE format('EXPLAIN (ANALYZE, BUFFERS, FORMAT JSON) %s', query)
        INTO plan;

        root := plan->0->'Plan';

        INSERT INTO tcc.performance_evaluation_data (
            query,
            run_number,
            execution_time_ms,
            planning_time_ms,
            rows_returned,
            rows_removed_by_filter,
            buffers_hit,
            buffers_read,
            buffers_dirtied,
            buffers_written,
            scan_type,
            total_cost,
            startup_cost
        )
        VALUES (
            query,
            i,
            (plan->0->>'Execution Time')::numeric,
            (plan->0->>'Planning Time')::numeric,
            (root->>'Actual Rows')::bigint,
            COALESCE((root->'Plans'->0->>'Rows Removed by Filter')::bigint, (root->>'Rows Removed by Filter')::bigint, 0),
            (root->>'Shared Hit Blocks')::bigint,
            (root->>'Shared Read Blocks')::bigint,
            (root->>'Shared Dirtied Blocks')::bigint,
            (root->>'Shared Written Blocks')::bigint,
            CASE
                WHEN (root->>'Node Type') IN ('Aggregate','Sort','Limit','Hash')
                THEN COALESCE(root->'Plans'->0->>'Node Type', root->>'Node Type')
                ELSE root->>'Node Type'
            END,
            (root->>'Total Cost')::numeric,
            (root->>'Startup Cost')::numeric
        );

    END LOOP;
END;
$function$
;
