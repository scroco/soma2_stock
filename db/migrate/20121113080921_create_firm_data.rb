class CreateFirmData < ActiveRecord::Migration
  def change
    create_table :firm_data do |t|

      t.datetime :date
      t.string  :period, :null=>true

      #재무상태표
      t.integer :working_capital, :null=>true
      t.integer :quick_assets, :null=>true
      t.integer :inventories, :null=>true
      t.integer :prepaid_incomeTaxes, :null=>true
      t.integer :other_current_assets, :null=>true
      t.integer :non_current_assets, :null=>true
      t.integer :investment_assets, :null=>true
      t.integer :tangible_assets, :null=>true
      t.integer :intangible_assets, :null=>true
      t.integer :biological_assets, :null=>true
      t.integer :investment_real_assets, :null=>true
      t.integer :assets_held_for_sale, :null=>true
      t.integer :deferred_income_tax_assets, :null=>true
      t.integer :other_non_current_assets, :null=>true
      t.integer :total_assets, :null=>true
      t.integer :total_assets_utem, :null=>true
      t.integer :floating_debt, :null=>true
      t.integer :non_current_liabilities, :null=>true
      t.integer :liabilities, :null=>true
      t.integer :liabilities_utem, :null=>true
      t.integer :controlling_shareholders_equity, :null=>true
      t.integer :capital, :null=>true
      t.integer :capital_surplus, :null=>true
      t.integer :other_capital, :null=>true
      t.integer :accumulated_other_comprehensive_income, :null=>true
      t.integer :retained_earning, :null=>true
      t.integer :total_stockholders_equity, :null=>true
      t.integer :total_stockholders_equity_utem, :null=>true
      t.integer :bps, :null=>true

      #손익계산서
      t.integer :sales, :null=>true
      t.integer :cost_of_goods_sold, :null=>true
      t.integer :gross_profit, :null=>true
      t.integer :selling_expenses, :null=>true
      t.integer :other_operation_income, :null=>true
      t.integer :other_operating_revenue, :null=>true
      t.integer :other_operation_expense, :null=>true
      t.integer :operating_profit, :null=>true
      t.integer :operating_profit_kgaap, :null=>true
      t.integer :financial_income, :null=>true
      t.integer :financial_Revenue, :null=>true
      t.integer :financial_expense, :null=>true
      t.integer :other_non_operating_income, :null=>true
      t.integer :other_income, :null=>true
      t.integer :other_costs, :null=>true
      t.integer :subsidiaries_income, :null=>true
      t.integer :profit_before_income_tax, :null=>true
      t.integer :income_tax, :null=>true
      t.integer :net_income, :null=>true
      t.integer :controlling_interests_in_net_income, :null=>true
      t.integer :non_controlling_interest_in_net_income, :null=>true
      t.integer :consolidated_net_controlling_stake, :null=>true
      t.integer :net_income_utem, :null=>true
      t.integer :other_comprehensive_income, :null=>true
      t.integer :total_comprehensive_income, :null=>true

      #현금흐름표
      t.integer :cashflows_from_operating, :null=>true
      t.integer :expenses_without_cash_outflow, :null=>true
      t.integer :income_without_cash_inflow, :null=>true
      t.integer :operating_assets_liabilities_fluctuations, :null=>true
      t.integer :cashflow_from_investing, :null=>true
      t.integer :cash_inflow_from_investing, :null=>true
      t.integer :cash_outflow_from_investing, :null=>true
      t.integer :cashflow_from_financing, :null=>true
      t.integer :cash_inflow_from_financing, :null=>true
      t.integer :cash_outflow_from_financing, :null=>true
      t.integer :change_in_cash, :null=>true
      t.integer :beginning_cash, :null=>true
      t.integer :end_cash, :null=>true



      #재무비율/가치평가
      #가치평가 지표
      t.integer :eps, :null=>true
      t.integer :eps_utem, :null=>true
      t.float   :per, :null=>true
      t.integer :bps_utem, :null=>true
      t.float   :pbr, :null=>true
      t.integer :cfps, :null=>true
      t.float   :pcr, :null=>true
      t.integer :sps, :null=>true
      t.float   :psr, :null=>true

      #수익성 지표
      t.float   :roe, :null=>true
      t.float   :ros, :null=>true
      t.float   :sa, :null=>true
      t.float   :ae, :null=>true
      t.float   :roa, :null=>true
      t.float   :net_profit_margin, :null=>true
      t.float   :operating_profit_margin_gaap, :null=>true
      t.float   :operating_profit_margin, :null=>true

      #성장성 지표                                                                2010-10-04
      t.float   :sales_growth, :null=>true
      t.float   :operating_profit_growth_gaap, :null=>true
      t.float   :operating_profit_growth, :null=>true
      t.float   :net_profit_growth, :null=>true
      t.float   :equity_growth, :null=>true

      #안전성 지표
      t.float   :debt_to_equity_ratio, :null=>true
      t.float   :current_ratio, :null=>true
      t.float   :interest_coverage_ratio, :null=>true

      t.timestamps
    end

    add_column('firm_data', 'stock_code_id', :integer, :index => true)

  end
end
