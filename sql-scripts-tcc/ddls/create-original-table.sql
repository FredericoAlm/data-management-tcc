CREATE TABLE tcc.api_production_data (
	created_at timestamptz DEFAULT CURRENT_TIMESTAMP NOT NULL,
	"path" text NOT NULL,
	request text NOT NULL,
	response jsonb NULL,
	status_code numeric NULL,
	heat_number text NULL
);

CREATE OR REPLACE FUNCTION tcc.delete_old_api_data()
 RETURNS void
 LANGUAGE sql
AS $function$
	DELETE FROM tcc.api_data WHERE created_at < now() - '7 days'::INTERVAL;
$function$
;


SELECT add_job(
    proc => 'tcc.delete_old_api_data',
    schedule_interval => '7 days', 
    config => null,
    initial_start => now()
);
