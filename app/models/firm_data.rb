class FirmData < ActiveRecord::Base
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
                  :totalComprehensiveIncome


  belongs_to :StockCode, :class_name => "StockCode"
end
