class FirmDatum < ActiveRecord::Base
  attr_accessible :date, :period, :workingCapital, :quickAssets, :inventories,
                  :prepaidIncomeTaxes, :otherCurrentAssets, :nonCurrentAssets, :investmentAssets,
                  :tangibleAssets, :intangibleAssets, :biologicalAssets, :investmentRealAssets,
                  :assetsHeldForSale, :deferredIncomeTaxAssets, :otherNonCurrentAssets,
                  :totalAssets, :totalAssetsUTEM, :floatingDebt, :nonCurrentLiabilities,
                  :liabilities, :liabilitiesUTEM, :controllingShareHoldersEquity,
                  :capital, :capitalSurplus, :otherCapital, :accumulatedOtherComprehensiveIncome,
                  :retainedEarning, :totalStockholdersEquity, :totalStockholdersEquityUTEM, :bps,

                  :sales, :costOfGoodsSold, :grossProfit, :sellingExpenses, :otherOperationIncome,
                  :otherOperatingRevenue, :otherOperationExpense, :operatingProfit, :operatingProfitKgaap,
                  :financialIncome, :financialRevenue, :financialExpense, :otherNonOperatingIncome,
                  :otherIncome, :otherCosts, :subsidiariesIncome, :profitBeforeIncomeTax, :incomeTax,
                  :netIncome, :controllingInterestsInNetIncome, :nonControllingInterestInNetIncome,
                  :consolidatedNetControllingStake, :netIncomeUTEM, :otherComprehensiveIncome,
                  :totalComprehensiveIncome,

                  :cashflowsFromOperating, :expensesWithoutCashOutflow, :incomeWithoutCashInflow,
                  :operatingAssetsLiabilitiesFluctuations, :cashflowFromInvesting, :cashInflowFromInvesting,
                  :cashOutflowFromInvesting, :cashflowFromFinancing, :cashInflowFromFinancing,
                  :cashOutflowFromFinancing, :changeInCash, :beginningCash, :endCash,

                  :eps, :epsUTEM, :per, :bpsUTEM, :pbr, :cfps, :pcr, :sps, :psr, :roe, :ros, :sa, :ae,
                  :roa, :netProfitMargin, :netProfitMarginGAAP, :operatingProfitMargin, :salesGrowth,
                  :operatingProfitGrowthGAAP, :operatingProfitGrowth, :netProfitGrowth,
                  :equityGrowth, :debtToEquityRatio, :currentRatio, :InterestCoverageRatio,

                  :stock_code

  belongs_to :stock_code

end
