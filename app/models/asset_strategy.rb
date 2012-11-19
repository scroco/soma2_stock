class AssetStrategy < ActiveRecord::Base
  attr_accessible :name, :strategy

  def investment_asset (options = Hash.new)
    # 일정한 돈 분배 case

    constant_asset = 100000
    if options[:constant_asset]
      constant_asset = options[:constant_asset]
    end

    return constant_asset
  end

  has_many    :asset_accounts
end
