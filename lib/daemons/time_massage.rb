class TimeMassage

  attr_accessor :year, :month, :day, :hour, :minute, :second, :offset

  def initialize( bad_time )
    @year   = bad_time[0..3]
    @month  = bad_time[5..6]
    @day    = bad_time[8..9]
    
    @hour   = bad_time[11..12]
    @minute = bad_time[14..15]
    @second = bad_time[17..18]
    
    @offset = bad_time[19..24]
  end
  
  def fix_nytimes_time()
    good_time = Time.new( @year.to_i, @month.to_i, @day.to_i, @hour.to_i, @minute.to_i, @second.to_i, "#{@offset}" )
  end
  
end