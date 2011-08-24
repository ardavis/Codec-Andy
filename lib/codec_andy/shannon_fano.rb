module ShannonFano

    def shannon_fano(array, code)
      #num_pix = array.inject{|total,n| total + n[1]}
      num_pix = array.collect{|a| a[1]}.inject{|total, n| total + n}
      pivot = num_pix / 2
      sum = 0
      col_1 = []
      col_2 = []

      array.each do |pixel|
        if(sum < pivot)
          col_1 << pixel
        else
          col_2 << pixel
        end

        sum += pixel[1]
      end

      # Perform recursively until this column cannot be divided
      #unless (col_1.size <= 2)

        # Set the code for the upper half of this column
        temp = "0"
        col_1.each do |val|
          if (code[val[0]].nil?)
            code[val[0].to_s] = "0"
            temp = "0"
          else
            #temp = temp + "0"
            code[val[0].to_s] = code[val[0].to_s] += temp
          end
        end

        unless (col_1.size == 1)
          code = shannon_fano(col_1, code)
        end
      #end

      # Perform recursively until this column cannot be divided
      temp = "1"
      #unless (col_2.size <= 2)
        # Set the code for the lower half of this column
        col_2.each do |val|
          if (code[val[0]].nil?)
            code[val[0].to_s] = "1"
            temp = "1"
          else
            #temp = temp + "1"
            code[val[0].to_s] = code[val[0].to_s] += temp
          end
        end

        unless (col_2.size == 1)
          code = shannon_fano(col_2, code)
        end
      #end

      code
    end

end