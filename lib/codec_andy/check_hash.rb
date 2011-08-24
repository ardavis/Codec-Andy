module CheckHash

  def check_hash(builder, code_hash)
    value = 0
    code_array = code_hash.to_a

    code_array.each do |index|
      if (index[1] == builder)
        return index[0].to_s
      else
        value = 0
      end
    end

    value
  end
end