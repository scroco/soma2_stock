class CreateFirmData < ActiveRecord::Migration
  def change
    create_table :firm_data do |t|

      t.datetime :date
      t.string  :period

      #재무상태표
      t.integer :workingCapital
      t.integer :quickAssets
      t.integer :inventories
      t.integer :prepaidIncomeTaxes
      t.integer :otherCurrentAssets
      t.integer :nonCurrentAssets
      t.integer :investmentAssets
      t.integer :tangibleAssets
      t.integer :intangibleAssets
      t.integer :biologicalAssets
      t.integer :investmentRealAssets
      t.integer :assetsHeldForSale
      t.integer :deferredIncomeTaxAssets
      t.integer :otherNonCurrentAssets
      t.integer :totalAssets
      t.integer :totalAssetsUTEM
      t.integer :floatingDebt
      t.integer :nonCurrentLiabilities
      t.integer :liabilities
      t.integer :liabilitiesUTEM
      t.integer :controllingShareHoldersEquity
      t.integer :capital
      t.integer :capitalSurplus
      t.integer :otherCapital
      t.integer :accumulatedOtherComprehensiveIncome
      t.integer :retainedEarning
      t.integer :totalStockholdersEquity
      t.integer :totalStockholdersEquityUTEM
      t.integer :bps

      #손익계산서
      t.integer :sales
      t.integer :costOfGoodsSold
      t.integer :grossProfit
      t.integer :sellingExpenses
      t.integer :otherOperationIncome
      t.integer :otherOperatingRevenue
      t.integer :otherOperationExpense
      t.integer :operatingProfit
      t.integer :operatingProfitKgaap
      t.integer :financialIncome
      t.integer :financialRevenue
      t.integer :financialExpense
      t.integer :otherNonOperatingIncome
      t.integer :otherIncome
      t.integer :otherCosts
      t.integer :subsidiariesIncome
      t.integer :profitBeforeIncomeTax
      t.integer :incomeTax
      t.integer :netIncome
      t.integer :controllingInterestsInNetIncome
      t.integer :nonControllingInterestInNetIncome
      t.integer :consolidatedNetControllingStake
      t.integer :netIncomeUTEM
      t.integer :otherComprehensiveIncome
      t.integer :totalComprehensiveIncome

      #현금흐름표
      t.integer :cashflowsFromOperating
      t.integer :expensesWithoutCashOutflow
      t.integer :incomeWithoutCashInflow
      t.integer :operatingAssetsLiabilitiesFluctuations
      t.integer :cashflowFromInvesting
      t.integer :cashInflowFromInvesting
      t.integer :cashOutflowFromInvesting
      t.integer :cashflowFromFinancing
      t.integer :cashInflowFromFinancing
      t.integer :cashOutflowFromFinancing
      t.integer :changeInCash
      t.integer :beginningCash
      t.integer :endCash



      #재무비율/가치평가
      #가치평가 지표
      t.integer :eps
      t.integer :epsUTEM
      t.float   :per
      t.integer :bpsUTEM
      t.float   :pbr
      t.integer :cfps
      t.float   :pcr
      t.integer :sps
      t.float   :psr

      #수익성 지표
      t.float   :roe
      t.float   :ros
      t.float   :sa
      t.float   :ae
      t.float   :roa
      t.float   :netProfitMargin
      t.float   :operatingProfitMarginGAAP
      t.float   :operatingProfitMargin

      #성장성 지표
      t.float   :salesGrowth
      t.float   :operatingProfitGrowthGAAP
      t.float   :operatingProfitGrowth
      t.float   :netProfitGrowth
      t.float   :equityGrowth

      #안전성 지표
      t.float   :debtToEquityRatio
      t.float   :currentRatio
      t.float   :InterestCoverageRatio

      t.timestamps
    end

    #add_column('firm_data', 'stock_codes_id', :integer, :references => 'stock_codes', :index => true)
  end
end
