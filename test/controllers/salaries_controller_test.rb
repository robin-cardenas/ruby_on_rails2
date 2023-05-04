require "test_helper"

class SalariesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @salary = salaries(:one)
  end

  test "should get index" do
    get salaries_url, as: :json
    assert_response :success
  end

  test "should create salary" do
    assert_difference('Salary.count') do
      post salaries_url, params: { salary: { base_salary: @salary.base_salary, employee_id: @salary.employee_id, final_date: @salary.final_date, initial_date: @salary.initial_date } }, as: :json
    end

    assert_response 201
  end

  test "should show salary" do
    get salary_url(@salary), as: :json
    assert_response :success
  end

  test "should update salary" do
    patch salary_url(@salary), params: { salary: { base_salary: @salary.base_salary, employee_id: @salary.employee_id, final_date: @salary.final_date, initial_date: @salary.initial_date } }, as: :json
    assert_response 200
  end

  test "should destroy salary" do
    assert_difference('Salary.count', -1) do
      delete salary_url(@salary), as: :json
    end

    assert_response 204
  end
end
