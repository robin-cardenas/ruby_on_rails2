require "test_helper"

class PayrollsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @payroll = payrolls(:one)
  end

  test "should get index" do
    get payrolls_url, as: :json
    assert_response :success
  end

  test "should create payroll" do
    assert_difference('Payroll.count') do
      post payrolls_url, params: { payroll: { company_id: @payroll.company_id, deductions: @payroll.deductions, employee_id: @payroll.employee_id, employee_pay: @payroll.employee_pay, income: @payroll.income, parafiscal_contributions: @payroll.parafiscal_contributions, social_benefits: @payroll.social_benefits, social_security: @payroll.social_security, total_cost: @payroll.total_cost } }, as: :json
    end

    assert_response 201
  end

  test "should show payroll" do
    get payroll_url(@payroll), as: :json
    assert_response :success
  end

  test "should update payroll" do
    patch payroll_url(@payroll), params: { payroll: { company_id: @payroll.company_id, deductions: @payroll.deductions, employee_id: @payroll.employee_id, employee_pay: @payroll.employee_pay, income: @payroll.income, parafiscal_contributions: @payroll.parafiscal_contributions, social_benefits: @payroll.social_benefits, social_security: @payroll.social_security, total_cost: @payroll.total_cost } }, as: :json
    assert_response 200
  end

  test "should destroy payroll" do
    assert_difference('Payroll.count', -1) do
      delete payroll_url(@payroll), as: :json
    end

    assert_response 204
  end
end
