class NominaService
  attr_reader :health_deduction, :pension_deduction, :solidarity_fund, :subsistence_account,
              :health_security, :pension_security, :arl, :compensation_box, :icbf, :sena,
              :layoffs, :interest_layoffs, :premium_services, :vacation

  TRANSPORT_ALLOWANCE = 117172
  MINIMUN_SALARY = 1000000

  def salary(base_salary, days)
    (base_salary * days) / 30
  end

  def total_social_benefits(total_ss_parafiscal, base_salary, days)
    if (base_salary.to_f / MINIMUN_SALARY) <= 2
      @total_social_benefits = total_ss_parafiscal + (TRANSPORT_ALLOWANCE * days) / 30
    else
      @total_social_benefits = total_ss_parafiscal
    end

    @total_social_benefits
  end

  def total_income(non_salaries, total_social_benefits)
    non_salaries + total_social_benefits
  end

  def deductions(total_ss_parafiscal, other_deductions)
    @health_deduction = total_ss_parafiscal * 0.04
    @pension_deduction = total_ss_parafiscal * 0.04
    @solidarity_fund = 0
    @subsistence_account = 0
    
    percentage = (total_ss_parafiscal.to_f / MINIMUN_SALARY)

    if percentage >= 4
      @solidarity_fund = total_ss_parafiscal * 0.01
    end

    
    if percentage < 16
      @subsistence_account = 0

    elsif percentage < 17
      @subsistence_account = total_ss_parafiscal * 0.002
        
    elsif percentage < 18
      @subsistence_account = total_ss_parafiscal * 0.004
        
    elsif percentage < 19
      @subsistence_account = total_ss_parafiscal * 0.006
        
    elsif percentage < 20
      @subsistence_account = total_ss_parafiscal * 0.008
        
    else
      @subsistence_account = total_ss_parafiscal * 0.01
        
    end

    @health_deduction + @pension_deduction + @solidarity_fund + @subsistence_account + other_deductions
  end

  def social_security(total_ss_parafiscal)
    @health_security = 0
    @pension_security = total_ss_parafiscal * 0.12
    @arl = total_ss_parafiscal * 0.06960

    if (total_ss_parafiscal.to_f / MINIMUN_SALARY) > 10
      @health = total_ss_parafiscal * 0.085
    end

    @health_security + @pension_security + @arl
  end

  def parafiscal_contributions(total_ss_parafiscal)
    @compensation_box = total_ss_parafiscal * 0.04
    @icbf = 0
    @sena = 0

    if (total_ss_parafiscal.to_f / MINIMUN_SALARY) > 10
      @icbf = total_ss_parafiscal * 0.03
      @sena = total_ss_parafiscal * 0.02
    end

    @compensation_box + @icbf + @sena
  end

  def social_benefits(total_ss_parafiscal)
    @layoffs = @total_social_benefits * (30.0/360)
    @interest_layoffs = @layoffs * 0.12
    @premium_services = @total_social_benefits * (30.0/360)
    @vacation = total_ss_parafiscal * (15.0/360)

    @layoffs + @interest_layoffs + @premium_services + @vacation
  end

end