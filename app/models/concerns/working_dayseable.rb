module WorkingDayseable
  def working_days_ago(count)
    date = Time.now

    while count > 0
      date = date - 1.day
      count -= 1 unless weekend?(date)
    end

    date
  end

  def weekend?(date)
    date.saturday? || date.sunday?
  end
end