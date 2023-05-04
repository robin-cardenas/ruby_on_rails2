require "test_helper"

class PayrollDetailsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @payroll_detail = payroll_details(:one)
  end

  test "should get index" do
    get payroll_details_url, as: :json
    assert_response :success
  end

  test "should create payroll_detail" do
    assert_difference('PayrollDetail.count') do
      post payroll_details_url, params: { payroll_detail: { concept: @payroll_detail.concept, payroll_id: @payroll_detail.payroll_id, percentage: @payroll_detail.percentage, type: @payroll_detail.type, valor: @payroll_detail.valor } }, as: :json
    end

    assert_response 201
  end

  test "should show payroll_detail" do
    get payroll_detail_url(@payroll_detail), as: :json
    assert_response :success
  end

  test "should update payroll_detail" do
    patch payroll_detail_url(@payroll_detail), params: { payroll_detail: { concept: @payroll_detail.concept, payroll_id: @payroll_detail.payroll_id, percentage: @payroll_detail.percentage, type: @payroll_detail.type, valor: @payroll_detail.valor } }, as: :json
    assert_response 200
  end

  test "should destroy payroll_detail" do
    assert_difference('PayrollDetail.count', -1) do
      delete payroll_detail_url(@payroll_detail), as: :json
    end

    assert_response 204
  end
end
