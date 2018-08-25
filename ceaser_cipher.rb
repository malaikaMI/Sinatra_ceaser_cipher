require 'sinatra'
if development?
	require "sinatra/reloader"
end

get '/' do
  plain = params["plain"]
  offset = params["offset"].to_i
  # offset = 1 if offset.nil?
  cipher = plain.to_s.caesar_cipher(offset)
  erb :index, :locals => {:cipher => cipher , :plain => plain , :offset => offset}
end


class String
  def caesar_cipher(shift = 1)
    abc = ("a".."z").to_a
    temp = self.split("").map do |i|
      if /[a-zA-Z]/ =~ i #abc.include?(i.downcase)
        if i != i.downcase
          abc[(abc.index(i.downcase).to_i + shift)%26].upcase
        else
          abc[(abc.index(i).to_i + shift)%26]
        end
      else
        i
      end
     end
     temp.join
  end
end
