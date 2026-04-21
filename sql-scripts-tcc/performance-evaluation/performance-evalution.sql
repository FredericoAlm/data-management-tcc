SELECT tcc.performance_evaluation(
    'SELECT * FROM tcc.api_data WHERE created_at > now() - INTERVAL ''10 minutes''',
     1000
);

SELECT tcc.performance_evaluation(
    'SELECT * FROM tcc.api_data WHERE created_at > now() - INTERVAL ''10 minutes'' AND path = ''production/teste''',
     1000
);

SELECT tcc.performance_evaluation(
    'SELECT * FROM tcc.api_data WHERE created_at > now() - INTERVAL ''10 minutes'' AND path = ''production/teste'' AND heat_number = ''0001''',
     1000
);

SELECT tcc.performance_evaluation(
    'INSERT INTO tcc.api_data
	(created_at, "path", request, response, status_code, heat_number)
	VALUES(''2025-12-01 00:00:00.000'', ''production/teste'', ''http://localhost:8000/production/teste/0001'', ''[{"variable_1":87,"variable_2":"alpha","variable_3":452.9,"variable_4":"2025-12-01T00:00:00","variable_5":true,"variable_6":null,"variable_7":"grupo_X","variable_8":19,"variable_9":"execuction_ok","variable_10":3.14,"variable_11":"beta","variable_12":204,"variable_13":"N","variable_14":"Y","variable_15":"hash_987zyx","variable_16":72,"variable_17":1.08,"variable_18":63,"variable_19":"simulation_test","variable_20":"2025-12-01T00:00:00"}]''::jsonb, 200, ''0001'');',
    100
);

SELECT 
	query_text, 
	avg(execution_time_ms) AS execution_time_ms,
	avg(planning_time_ms) AS planning_time_ms,
	avg(rows_returned) AS rows_returned,
	avg(rows_removed_by_filter) AS rows_removed_by_filter,
	avg(buffers_hit) AS buffers_hit,
	avg(buffers_read) AS buffers_read,
	avg(buffers_dirtied) AS buffers_dirtied,
	avg(buffers_written) AS buffers_written,
	scan_type 
FROM 
	tcc.performance_evaluation_data adt 
WHERE created_at > '2025-12-15 12:00:00.000 -0300' 
GROUP BY query_text, scan_type