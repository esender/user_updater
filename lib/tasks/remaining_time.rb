class RemainingTime
  def initialize(start_time, object_quantity)
    @start_time = start_time
    @object_quantity = object_quantity
  end

  def humanized_count(processed_objects)
    humanize count(processed_objects)
  end

  def count(processed_objects)
    seconds = (@object_quantity - processed_objects) / (processed_objects / passed_time)
    seconds.to_i
  end

  def humanize(seconds)
    hours = seconds / 3600
    minutes = seconds % 3600 / 60
    seconds = seconds % 3600 % 60

    stringify(hours) + ':' + stringify(minutes) + ':' + stringify(seconds)
  end

  def stringify(number)
    number = "0#{number}" if number < 10
    number.to_s
  end

  def passed_time
    Time.now - @start_time
  end
end
