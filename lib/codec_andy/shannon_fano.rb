module ShannonFano

    def shannon_fano(array, code)
      pivot = array.size / 2

      col_1 = array[0, pivot]
      col_2 = array[pivot..array.size - 1]

      # Perform recursively until this column cannot be divided
      unless (col_1.size <= 2)

        # Set the code for the upper half of this column
        temp = ""
        col_1.each do |val|
          if (code[val[0]].nil?)
            code[val[0].to_s] = "0"
            temp = "0"
          else
            temp = temp + "0"
            code[val[0].to_s] = code[val[0].to_s] + temp
            #code[val[0].to_s] = temp
          end
        end

        code = shannon_fano(col_1, code)
      end

      # Perform recursively until this column cannot be divided
      temp = ""
      unless (col_2.size <= 2)
        # Set the code for the lower half of this column
        col_2.each do |val|
          if (code[val[0]].nil?)
            code[val[0].to_s] = "1"
            temp = "1"
          else
            temp = temp + "1"
            code[val[0].to_s] = code[val[0].to_s] + temp
            #code[val[0].to_s] = temp
          end
        end

        code = shannon_fano(col_2, code)
      end

      code
    end

end