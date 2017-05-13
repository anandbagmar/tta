class SanitizeErrorMessages < ActiveRecord::Migration
  def change
    execute "select * from test_step_records where error_msg like '%\"%'"
    execute "select * from test_case_records where error_msg like '%\"%'"
    execute "update test_step_records set error_msg = replace(concat(\"\",error_msg,\"\"), '\"', '\\'');"
    execute "update test_case_records set error_msg = replace(concat(\"\",error_msg,\"\"), '\"', '\\'');"
  end
end
