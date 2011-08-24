module ShannonFano

    def shannon_fano(array, code)
      pivot = array.size / 2

      col_1 = array[0, pivot]
      col_2 = array[pivot..array.size - 1]

      debugger
      # Perform recursively until this column cannot be divided
      unless (col_1.size <= 2)

        # Set the code for the upper half of this column
        col_1.each do |val|
          temp = ""
          if (code[val[0]].nil?)
            code[val[0].to_s] = "0"
            temp = "0"
          end

          #temp = val[1].to_s
          temp = temp + "0"
          code[val[0].to_s] = temp
        end

        code = shannon_fano(col_1, code)
      end

      # Perform recursively until this column cannot be divided
      unless (col_2.size <= 2)
        # Set the code for the lower half of this column
        col_2.each do |val|
          temp = ""
          if (code[val[0]].nil?)
            code[val[0].to_s] = "1"
            temp = "1"
          end

          #temp = val[1].to_s
          temp = temp + "1"
          code[val[0].to_s] = temp
        end

        code = shannon_fano(col_2, code)
      end

      #debugger
      code
    end

end