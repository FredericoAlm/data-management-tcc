SELECT add_compression_policy(
    'tcc.api_data',
    INTERVAL '1 day',
    schedule_interval => INTERVAL '1 day',
    initial_start => TIMESTAMPTZ '2025-10-15 09:00:00'
);

SELECT add_retention_policy(
    'tcc.api_data',
    INTERVAL '7 days',
    schedule_interval => INTERVAL '1 day',
    initial_start => TIMESTAMPTZ '2025-10-15 08:00:00'
);