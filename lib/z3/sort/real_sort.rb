module Z3
  class RealSort < Sort
    def initialize
      super LowLevel.mk_real_sort
    end

    def expr_class
      RealExpr
    end

    def from_const(val)
      if val.is_a?(Integer) or (val.is_a?(Float) and val.finite?) or val.is_a?(Rational)
        new LowLevel.mk_numeral(val.to_s, self)
      else
        raise Z3::Exception, "Cannot convert #{val.class} to #{self.class}"
      end
    end

    def from_value(val)
      if val.is_a?(IntExpr)
        new LowLevel.mk_int2real(val)
      elsif val.is_a?(RealExpr)
        val
      else
        raise Z3::Exception, "Cannot convert #{val.class} to #{self.class}"
      end
    end

    def >(other)
      raise ArgumentError unless other.is_a?(Sort)
      other.is_a?(IntSort)
    end

    public_class_method :new
  end
end
