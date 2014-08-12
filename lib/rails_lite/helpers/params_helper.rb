require 'uri'

module ParamsHelper
  # this should return deeply nested hash
  # argument format
  # user[address][street]=main&user[address][zip]=89436
  # should return
  # { "user" => { "address" => { "street" => "main", "zip" => "89436" } } }
  def parse_www_encoded_form(encoded_str)
    return {} if encoded_str.nil?
    result = {}
    decoded = URI.decode_www_form(encoded_str)
    decoded.each do |elem|
      parsed = parse_key(elem.first) << elem.last
      result[parsed.first] = {} unless result[parsed.first]
      if parsed.length == 2
        result[parsed.first] = parsed.last 
      else
        result[parsed.first].merge!(rec_map_nested(parsed[1..-1]))
      end
    end
    result
  end
  
  # this should return an array
  # user[address][street] should return ['user', 'address', 'street']
  def parse_key(key)
    key.split(/\]\[|\[|\]/)
  end
  
  def rec_map_nested(an_array)
    if an_array.length == 2
      return {an_array.first => an_array.last}
    else
      return {an_array.first => rec_map_nested(an_array[1..-1])}
    end
  end
end