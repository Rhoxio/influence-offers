class String
  def not_blank?
    !self.blank?
  end

  def colorize(color_code)
    "\e[#{color_code}m#{self}\e[0m"
  end

  def green
    colorize(32)
  end

  def red
    colorize(31)
  end  

  def light_blue
    colorize(36)
  end

  def yellow
    colorize(33)
  end

  def blue
    colorize(34)
  end  
end