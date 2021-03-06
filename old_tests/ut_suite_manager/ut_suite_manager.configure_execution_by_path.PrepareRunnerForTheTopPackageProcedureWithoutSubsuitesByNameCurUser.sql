PROMPT Prepare runner for the top package procedure without sub-suites by package name for current user

--Arrange
declare
  c_path varchar2(100) := 'test_package_2.test2';
  l_objects_to_run ut_suite_items;

  l_test0_suite ut_logical_suite;
  l_test1_suite ut_logical_suite;
  l_test_proc ut_test;
begin
--Act
  l_objects_to_run := ut_suite_manager.configure_execution_by_path(ut_varchar2_list(c_path));

--Assert
  ut.expect(l_objects_to_run.count).to_equal(1);
  l_test0_suite := treat(l_objects_to_run(1) as ut_logical_suite);

  ut.expect(l_test0_suite.name).to_equal('tests');
  ut.expect(l_test0_suite.items.count).to_equal(1);
  l_test1_suite :=  treat(l_test0_suite.items(1) as ut_logical_suite);

  ut.expect(l_test1_suite.name).to_equal('test_package_3');
  ut.expect(l_test1_suite.items.count).to_equal(1);

  l_test_proc := treat(l_test1_suite.items(1) as ut_test);
  ut.expect(l_test_proc.name).to_equal('test2');
  ut.expect(l_test_proc.before_test_list.count).to_equal(1);
  ut.expect(l_test_proc.after_test_list.count).to_equal(1);

  if ut_expectation_processor.get_status = ut_utils.gc_success then
    :test_result := ut_utils.gc_success;
  end if;

end;
/
