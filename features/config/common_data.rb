#Site Url
HOMEPAGE="http://localhost:3000"
ADMIN_STATS_PAGE="http://localhost:3000/stats"

#Button_name for different pages
UPLOAD_PAGE_BUTTON="SUBMIT"
COMPARATIVE_PAGE_BUTTON="Plot"
DEFECT_PAGE_BUTTON="Submit"
TEST_PYRAMID_PAGE_BUTTON="Plot"
COMPARE_PAGE_BUTTON="compare_runs"
#page names
UPLOAD_PAGE="UPLOAD TEST DATA"
COMPARATIVE_PAGE="COMPARATIVE ANALYSIS"
DEFECT_PAGE="FAILURE ANALYSIS"
TEST_PYRAMID_PAGE="TEST PYRAMID VIEW"
COMPARE_RUNS_PAGE="COMPARE RUNS"

#Upload Page  element

UPLOAD_PRODUCT_NAME = 'product_name'
UPLOAD_PLATFORM_NAME='platform_name'
UPLOAD_CI_JOB_NAME='ci_job_name'
UPLOAD_OS='os'
UPLOAD_TEST_EXECUTION_MACHINE_NAME='test_execution_machine_name'
UPLOAD_BROWSER_OR_DEVICE='browser_or_device'
UPLOAD_ENV='environment'
UPLOAD_EXEC_DAY='date_day'
UPLOAD_EXEC_MONTH="date_month"
UPLOAD_EXEC_YEAR= "date_year"
UPLOAD_EXEC_HOUR= "date_hour"
UPLOAD_EXEC_MIN="date_minute"
UPLOAD_FILENAME='logDirectory'
UPLOAD_TEST_TYPE="test_category"
UPLOAD_TEST_SUB_TYPE="test_sub_category"
UPLOAD_TEST_REPORT_TYPE ="test_report_type"

UPLOAD_SUCCESS="Product Successfully Saved!!"

#comparative Page ELEMENT

COMPARATIVE_PRODUCT_DROPDOWN = "product_id"
COMPARATIVE_PLATFORM_DROPDOWN = "platform_select"
COMPARATIVE_START_DATE = "comparative_analysis_start_date"
COMPARATIVE_END_DATE = "comparative_analysis_end_date"
COMPARATIVE_PLOT_BUTTON = "form-submit"

COMPARATIVE_GRAPH_ID = "#comparative_analysis"

#Defect Analysis Graph ELEMENTS
DEFECT_PRODUCT_DROPDOWN="product_select"
DEFECT_PLATFORM_DROPDOWN="platform_select"
DEFECT_TEST_CATEGORY_DROPDOWN="test_category_select"
DEFECT_GRAPH_ID="#defect-analysis"

#PYRAMID ELEMENT
TEST_PYRAMID_PLATFORM_DROPDOWN="platform_id"
PYRAMID_ID="#block_pyramid"
PYRAMID_TABLE_ID="#pyramidTable"

#ERROR_SCREENSHOT_PATH
SCREENSHOT_FILE_PATH=$PROJECT_ROOT +"/log/feature/screenshots/"

# COMPARE RUN ELEMENTS

COMPARE_RUN_PRODUCT_DROPDOWN="product_select"
COMPARE_RUN_PLATFORM_DROPDOWN="platform_select"
COMPARE_RUN_TEST_TYPE_DROPDOWN="test_category_select"
COMPARE_RUN_TEST_DATE1="date_one_select"
COMPARE_RUN_TEST_DATE2="date_two_select"
COMPARE_RUN_TABLE_ID="#result_table"
