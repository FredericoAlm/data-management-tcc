CREATE TABLE tcc.api_data (
	created_at timestamptz DEFAULT CURRENT_TIMESTAMP NOT NULL,
	"path" text NOT NULL,
	request text NOT NULL,
	response jsonb NULL,
	status_code numeric NULL,
	heat_number text NULL
);

CREATE TRIGGER ts_insert_blocker BEFORE
INSERT
    ON
    tcc.api_data FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.insert_blocker();

SELECT set_chunk_time_interval('tcc.api_data', INTERVAL '1 day');

ALTER TABLE tcc.api_data SET (
  timescaledb.compress,
  timescaledb.compress_orderby = 'created_at DESC',
  timescaledb.compress_segmentby = 'path'
);