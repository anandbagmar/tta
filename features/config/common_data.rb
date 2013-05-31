#Site Url
HOMEPAGE="http://localhost:3000"

#Button_name for different pages
UPLOAD_PAGE_BUTTON="SUBMIT"
COMPARATIVE_PAGE_BUTTON="Plot"
DEFECT_PAGE_BUTTON="Plot"
TEST_PYRAMID_PAGE_BUTTON="Plot"
COMPARE_PAGE_BUTTON="compare_runs"
#page names
UPLOAD_PAGE="UPLOAD TEST DATA"
COMPARATIVE_PAGE="COMPARATIVE ANALYSIS"
DEFECT_PAGE="FAILURE ANALYSIS"
TEST_PYRAMID_PAGE="TEST PYRAMID VIEW"
COMPARE_RUNS_PAGE="COMPARE RUNS"

#Upload Page  element

UPLOAD_PROJECT_NAME = 'project_name'
UPLOAD_SUB_PROJECT_NAME='sub_project_name'
UPLOAD_CI_JOB_NAME='ci_job_name'
UPLOAD_OS_NAME='os_name'
UPLOAD_HOST_NAME='host_name'
UPLOAD_BROWSER='browser'
UPLOAD_ENV='type_of_environment'
UPLOAD_EXEC_DAY='date_day'
UPLOAD_EXEC_MONTH="date_month"
UPLOAD_EXEC_YEAR= "date_year"
UPLOAD_EXEC_HOUR= "date_hour"
UPLOAD_EXEC_MIN="date_minute"
UPLOAD_FILENAME='logDirectory'
UPLOAD_TEST_TYPE="test_category"
UPLOAD_TEST_REPORT_TYPE ="test_report_type"

UPLOAD_SUCCESS="Project Successfully Saved!!"

#comparative Page ELEMENT

COMPARATIVE_PROJECT_DROPDOWN = "project_id"
COMPARATIVE_START_DATE =  "comparative_analysis_start_date"
COMPARATIVE_END_DATE =  "comparative_analysis_end_date"
COMPARATIVE_PLOT_BUTTON = "form-submit"

COMPARATIVE_GRAPH_ID = "#comparative_analysis"

#Defect Analysis Graph ELEMENTS
DEFECT_SUBPROJECT_DROPDOWN="sub_project_id"
DEFECT_FORM_DATE="defect_analysis_analysis_date"
DEFECT_GRAPH_ID="#defect-analysis"

#PYRAMID ELEMENT
TEST_PYRAMID__PROJECT_DROPDOWN="sub_project_id"
PYRAMID_ID="#block_pyramid"
PYRAMID_TABLE_ID="#pyramidTable"

#ERROR_SCREENSHOT_PATH
SCREENSHOT_FILE_PATH=$PROJECT_ROOT +"/log/feature/screenshots/"

# COMPARE RUN ELEMENTS

COMPARE_RUN_PROJECT_DROPDOWN="project_select"
COMPARE_RUN_SUB_PROJECT_DROPDOWN="sub_project_select"
COMPARE_RUN_TEST_TYPE_DROPDOWN="test_types_select"
COMPARE_RUN_TEST_DATE1="date_one_select"
COMPARE_RUN_TEST_DATE2="date_two_select"
COMPARE_RUN_TABLE_ID="#result_table"
