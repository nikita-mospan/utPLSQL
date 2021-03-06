--Arrange
declare
  l_actual   &&1 := &&2;
  l_expected &&1 := &&3;
  l_result   integer;
begin
--Act
  ut.expect(l_actual).to_equal(l_expected);
  l_result :=  ut_expectation_processor.get_status();
--Assert
  if nvl(:test_result, ut_utils.gc_success) = ut_utils.gc_success and l_result = &&4 then
    :test_result := ut_utils.gc_success;
  else
    dbms_output.put_line('expected: '''||&&4||''', got: '''||l_result||'''' );
  end if;
end;
/
