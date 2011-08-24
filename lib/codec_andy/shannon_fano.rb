module ShannonFano

    def shannon_fano(array, code)
      num_pix = array.collect{|a| a[1]}.inject{|total, n| total + n}
      pivot = num_pix / 2
      sum = 0
      col_1 = []
      col_2 = []

      # Determine if the pixel value belongs in column 1 or column 2
      array.each do |pixel|
        if(sum < pivot)
          col_1 << pixel
        else
          col_2 << pixel
        end

        sum += pixel[1]
      end

      # Perform recursively until this column cannot be divided
      # Set the code for the upper half of this column
      temp = "0"
      col_1.each do |val|
        # If this is a new value, set it to "0"
        if (code[val[0]].nil?)
          code[val[0].to_s] = "0"
          temp = "0"
        else
          # Otherwise, append a "0"
          code[val[0].to_s] = code[val[0].to_s] += temp
        end
      end

      # Don't call the recursion if there is only one element in the column
      unless (col_1.size == 1)
        code = shannon_fano(col_1, code)
      end

      # Perform recursively until this column cannot be divided
      # Set the code for the lower half of this column
      temp = "1"
      col_2.each do |val|
        # If this is a new value, set it to "1"
        if (code[val[0]].nil?)
          code[val[0].to_s] = "1"
          temp = "1"
        else
          # Otherwise, append a "1"
          code[val[0].to_s] = code[val[0].to_s] += temp
        end
      end

      # Don't call the recursion if there is only one element in the column
      unless (col_2.size == 1)
        code = shannon_fano(col_2, code)
      end

      # Return the hash of codes
      code
    end

end