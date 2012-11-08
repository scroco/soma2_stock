require 'rubygems'

#table안에 들어있는 text들을 array 형태로 반환
def get_data(doc, cssstr)

  temp = doc.css(cssstr)
  arr = Array.new
  for t in temp do
    #puts t.text + ' '
    arr.push(t.text)
  end
  return arr
end

#숫자 표현된 string을 숫자로 바꿈(콤마 제거)
def strtoint(str)
  strlist = str.split(',')

  tot = ''
  for tmp in strlist
    tot = tot + tmp
  end
  return tot.to_f
end

#
def valuname_traslator(ko, value, rec_value)
  if ko == "유동자산" then
    rec_value[:workingCapital] = value
  elsif ko == "당좌자산" then
    rec_value[:quickAssets] = value
  end

end
