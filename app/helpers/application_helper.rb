module ApplicationHelper
  def simple_date_format date
    date.try(:strftime, "%Y/%m/%d")
  end
end
