CREATE TABLE tcc.performance_evaluation_data (
    run_id serial primary key,
    query_text text,
    execution_time_ms numeric,
    planning_time_ms numeric,
    rows_returned bigint,
    rows_removed bigint,
    buffers_hit bigint,
    buffers_read bigint,
    buffers_dirtied bigint,
    buffers_written bigint,
    scan_type text,
    created_at timestamp default now()
);