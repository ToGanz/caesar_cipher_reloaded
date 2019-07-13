require 'sinatra'
require 'erb'

enable :sessions

get '/' do
  @encoded_string = session.delete(:encoded_string)
  #@string_to_encode = params["string_to_encode"]
  #@encoded_string = params["encoded_string"]
  erb :index
end

post '/' do
    @string_to_encode = params["string_to_encode"]
    @shift = params["shift"].to_i
    @encoded_string = caesar_cipher(@string_to_encode, @shift)
    session[:encoded_string] = @encoded_string
    redirect "/"
end

def caesar_cipher(str, shift)
  if ((str.is_a? String ) && (shift.is_a? Integer))
      az_down = ('a'..'z').to_a
      az_up = ('A'..'Z').to_a
      az = az_down + az_up + [" "]
      str_array = str.split("")
      j = 0
      str_array.each { |c|
          ind = az.index(c)
          if (ind != nil && ind < 26)
              ind_shifted = ind+shift
              if ind_shifted > 25
                  ind_shifted -= 26
              elsif ind_shifted < 0
                  ind_shifted += 26
              end
              str_array[j] = az[ind_shifted]
          elsif (ind !=nil && ind < 52)
              ind_shifted = ind+shift
              if ind_shifted > 51
                  ind_shifted -= 26
              elsif ind_shifted < 25
                  ind_shifted += 26
              end
              str_array[j] = az[ind_shifted]        
          end
          j += 1         
      }
      return str_array.join("")
  else
      return 'Error'
  end
end

test_string = "AbC zZz!2"

puts caesar_cipher(test_string, -2)

#'a'.ord wäre gute Lösung ( umgekehrt: 97.chr)

