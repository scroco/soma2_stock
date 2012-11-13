class FirmDatum < ActiveRecord::Base
  attr_accessible :date, :period, :working_capital, :quick_assets, :inventories,
                  :prepaid_income_taxes, :other_current_assets, :non_current_assets, :investment_assets,
                  :tangible_assets, :intangible_assets, :biological_assets, :investment_real_assets,
                  :assets_held_for_sale, :deferred_income_tax_assets, :other_non_current_assets,
                  :total_assets, :total_assets_utem, :floating_debt, :non_current_liabilities,
                  :liabilities, :liabilities_utem, :controlling_shareholders_equity,
                  :capital, :capital_surplus, :other_capital, :accumulated_other_comprehensive_income,
                  :retained_earning, :total_stockholders_equity, :total_stockholders_equity_utem, :bps,

                  :sales, :cost_of_goods_sold, :gross_profit, :selling_expenses, :other_operation_income,
                  :other_operating_revenue, :other_operation_expense, :operating_profit, :operating_profit_kgaap,
                  :financial_income, :financial_revenue, :financial_expense, :other_non_operating_income,
                  :other_income, :other_costs, :subsidiaries_income, :profit_before_income_tax, :income_tax,
                  :net_income, :controlling_interests_in_net_income, :non_controlling_interest_in_net_income,
                  :consolidated_net_controlling_stake, :net_income_utem, :other_comprehensive_income,
                  :total_comprehensive_income,

                  :cashflows_from_operating, :expenses_without_cash_outflow, :income_without_cash_inflow,
                  :operating_assets_liabilities_fluctuations, :cashflow_from_investing, :cash_inflow_from_investing,
                  :cash_outflow_from_investing, :cashflow_from_financing, :cash_inflow_from_financing,
                  :cash_outflow_from_financing, :change_in_cash, :beginning_cash, :end_cash,

                  :eps, :eps_utem, :per, :bps_utem, :pbr, :cfps, :pcr, :sps, :psr, :roe, :ros, :sa, :ae,
                  :roa, :net_profit_margin, :net_profit_margin_gaap, :operating_profit_margin, :sales_growth,
                  :operating_profit_growth_gaap, :operating_profit_growth, :net_profit_growth,
                  :equity_growth, :debt_to_equity_ratio, :current_ratio, :interest_coverage_ratio,

                  :stock_code

  belongs_to :stock_code

end
