class Array

  def search_double(b = 0, e = self.size - 1)
    m = (e-b)/2.ceil + b

    return case self[m] - m
      when 1 # both results are right
        unless b == m # corrects results of ceil
          self.search_double(m,e)
        else
          r1 = self[m]+1
          r2 = self.search_bin(m+1, e, 1)
          [r1, r2]
        end
      when 2 # results are right and left
        r1 = self.search_bin(b, m, 0)
        # when find first - c corrects delta for second number
        r2 = self.search_bin(m, e, 1)
        [r1, r2]
      when 3 # both results are left
        self.search_double(b,m)
    end
  end

  def search_bin (b, e, c=0)
    # b = index of first element 
    # e = index of last element 
    # m = index of middle element
    
    found = false
    until (b > e || found)
      m = (e-b)/2.ceil + b 
      found = true if b == e
      
      if self[m] == m+2+c # c =0 for first search, c=1 for second search
        e = m - 1
        corr = -1
      else
        b = m + 1
        corr = 1
      end
    end
    self[m]+corr
  end

end
