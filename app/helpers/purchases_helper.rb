module PurchasesHelper
  def money_format(float)
    float = float.to_s
    dollars = ''
    cents = ''
    if float.include? '.'
      arr = float.split('.')
      dollars = arr[0]
      cents = arr[1]
      if cents.length == 1
        cents = "#{cents}0"
      end
    else
      dollars = float
      cents = '00'
    end
    "#{dollars}.#{cents}"
  end
end
