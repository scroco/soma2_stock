class CreateFirmData < ActiveRecord::Migration
  def change
    create_table :firm_data do |t|

      t.datetime :date
      t.string  :period, :null=>true

      #재무상태표
      t.integer :workingCapital, :null=>true
      t.integer :quickAssets, :null=>true
      t.integer :inventories, :null=>true
      t.integer :prepaidIncomeTaxes, :null=>true
      t.integer :otherCurrentAssets, :null=>true
      t.integer :nonCurrentAssets, :null=>true
      t.integer :investmentAssets, :null=>true
      t.integer :tangibleAssets, :null=>true
      t.integer :intangibleAssets, :null=>true
      t.integer :biologicalAssets, :null=>true
      t.integer :investmentRealAssets, :null=>true
      t.integer :assetsHeldForSale, :null=>true
      t.integer :deferredIncomeTaxAssets, :null=>true
      t.integer :otherNonCurrentAssets, :null=>true
      t.integer :totalAssets, :null=>true
      t.integer :totalAssetsUTEM, :null=>true
      t.integer :floatingDebt, :null=>true
      t.integer :nonCurrentLiabilities, :null=>true
      t.integer :liabilities, :null=>true
      t.integer :liabilitiesUTEM, :null=>true
      t.integer :controllingShareHoldersEquity, :null=>true
      t.integer :capital, :null=>true
      t.integer :capitalSurplus, :null=>true
      t.integer :otherCapital, :null=>true
      t.integer :accumulatedOtherComprehensiveIncome, :null=>true
      t.integer :retainedEarning, :null=>true
      t.integer :totalStockholdersEquity, :null=>true
      t.integer :totalStockholdersEquityUTEM, :null=>true
      t.integer :bps, :null=>true

      #손익계산서
      t.integer :sales, :null=>true
      t.integer :costOfGoodsSold, :null=>true
      t.integer :grossProfit, :null=>true
      t.integer :sellingExpenses, :null=>true
      t.integer :otherOperationIncome, :null=>true
      t.integer :otherOperatingRevenue, :null=>true
      t.integer :otherOperationExpense, :null=>true
      t.integer :operatingProfit, :null=>true
      t.integer :operatingProfitKgaap, :null=>true
      t.integer :financialIncome, :null=>true
      t.integer :financialRevenue, :null=>true
      t.integer :financialExpense, :null=>true
      t.integer :otherNonOperatingIncome, :null=>true
      t.integer :otherIncome, :null=>true
      t.integer :otherCosts, :null=>true
      t.integer :subsidiariesIncome, :null=>true
      t.integer :profitBeforeIncomeTax, :null=>true
      t.integer :incomeTax, :null=>true
      t.integer :netIncome, :null=>true
      t.integer :controllingInterestsInNetIncome, :null=>true
      t.integer :nonControllingInterestInNetIncome, :null=>true
      t.integer :consolidatedNetControllingStake, :null=>true
      t.integer :netIncomeUTEM, :null=>true
      t.integer :otherComprehensiveIncome, :null=>true
      t.integer :totalComprehensiveIncome, :null=>true

      #현금흐름표
      t.integer :cashflowsFromOperating, :null=>true
      t.integer :expensesWithoutCashOutflow, :null=>true
      t.integer :incomeWithoutCashInflow, :null=>true
      t.integer :operatingAssetsLiabilitiesFluctuations, :null=>true
      t.integer :cashflowFromInvesting, :null=>true
      t.integer :cashInflowFromInvesting, :null=>true
      t.integer :cashOutflowFromInvesting, :null=>true
      t.integer :cashflowFromFinancing, :null=>true
      t.integer :cashInflowFromFinancing, :null=>true
      t.integer :cashOutflowFromFinancing, :null=>true
      t.integer :changeInCash, :null=>true
      t.integer :beginningCash, :null=>true
      t.integer :endCash, :null=>true



      #재무비율/가치평가
      #가치평가 지표
      t.integer :eps, :null=>true
      t.integer :epsUTEM, :null=>true
      t.float   :per, :null=>true
      t.integer :bpsUTEM, :null=>true
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
      t.float   :netProfitMargin, :null=>true
      t.float   :operatingProfitMarginGAAP, :null=>true
      t.float   :operatingProfitMargin, :null=>true

      #성장성 지표                                                                2010-10-04
      t.float   :salesGrowth, :null=>true
      t.float   :operatingProfitGrowthGAAP, :null=>true
      t.float   :operatingProfitGrowth, :null=>true
      t.float   :netProfitGrowth, :null=>true
      t.float   :equityGrowth, :null=>true

      #안전성 지표
      t.float   :debtToEquityRatio, :null=>true
      t.float   :currentRatio, :null=>true
      t.float   :InterestCoverageRatio, :null=>true

      t.timestamps
    end

    add_column('firm_data', 'stock_code_id', :integer, :index => true)
  end
end
