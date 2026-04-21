CREATE INDEX idx_api_production_data_created_at ON tcc.api_data USING btree (created_at DESC);
CREATE INDEX idx_api_production_data_path_created_at ON tcc.api_data USING btree (path, created_at DESC);
CREATE INDEX idx_api_production_data_path_heat_number_created_at ON tcc.api_data USING btree (path, heat_number, created_at DESC);