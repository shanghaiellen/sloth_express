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

  def estimate_to_money(float)
    float = float.to_s
    if float.length > 2
      float.insert(-3, '.')
    elsif float.length == 2
      float.insert(0, '0.')
    else
      float.insert(0, '0.0')
    end
  end
end
