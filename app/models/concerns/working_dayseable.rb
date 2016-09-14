module WorkingDayseable
  def working_days_ago(count)
    date = Time.now

    while weekday?(date) do
      date = date - 1.day
    end

    while count > 0
      date = date - 1.day
      count -= 1 unless weekday?(date)
    end

    date
  end

  def weekday?(date)
    date.saturday? || date.sunday?
  end
end