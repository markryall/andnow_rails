module SessionsHelper
  def time s
    return '' unless s
    Time.zone.at(s).strftime '%a %d %b %H:%M:%S'
  end

  def duration from, to
    return '' unless from and to
    s = to - from
    minutes,s=s/60,s%60
    hours,minutes=minutes/60,minutes%60
    return "#{hours} hours #{minutes} minutes" if hours > 0
    return "#{minutes} minutes #{s} seconds" if minutes > 0
    "#{s} seconds"
  end

  def cost c
    return '' unless c
    d,c=c/100,c%100
    "$#{d}.#{c}"
  end
end
