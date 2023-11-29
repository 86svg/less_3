class Station
  attr_reader :trains, :name

  def initialize(name)
    @name = name
    @trains_list = []
  end

  def take_train(train)
    @trains_list << train
  end

  def send_train(train)
    @trains_list.delete(train)
  end

  def number_of_trains
    number_of_pass = 0
    number_of_cargo = 0

    @trains_list.each do |train|
      if train.type == 'cargo'
        number_of_cargo += 1
      else
        number_of_pass += 1
      end
    end

    puts "количество пассажирских вагонов #{number_of_pass}"
    puts "количество грузовых вагонов #{number_of_cargo}"
  end

  def trains_list
    if @trains_list.empty?
      puts “На станции нет поездов”
    else
      @trains_list.each do |train|
        puts train.name
      end
    end
  end
end

class Route
  attr_reader :stations

  def initialize(start_station, finish_station)
    @stations = [start_station, finish_station]
  end

  def station_list
    @stations
  end

  def add_tintermediate_station(station)
    @stations.insert(-2, station)
  end

  def remove_tintermediate_station
    if @stations.size > 2
      @stations.delete_at(-2)
    else
      puts 'Промежуточных станций нет'
    end
  end
end

class Train
  attr_reader :number, :type, :number_of_wagons

  def initialize(number, type, number_of_wagons)
    @number = number
    @type = type
    @number_of_wagons = number_of_wagons
    @speed = 0
  end

  def speed_up(speed)
    @speed += speed
  end

  def brake
    @speed = 0
  end

  def number_of_wagons_list(number_of_wagons)
    @number_of_wagons = number_of_wagons
  end

  def add_number_of_wagons
    @number_of_wagons += 1 if speed == 0
  end

  def remove_number_of_wagons
    @number_of_wagons -= 1 if speed == 0
  end

  def set_route(route)
    @route = route
    @current_station = @route.stations_list.first
  end

  def next_station
    current_station_index = @route.station_list.index(@current_station)
    if current_station_index == @route.station_list.size - 1
      puts 'Вы на конечной, движение вперед невозможно'
    else
      @current_station = @route.stations_list[current_station_index + 1]
    end
  end

  def previous_station
    current_station_index = @route.station_list.index(@current_station)
    if current_station_index.zero?
      puts 'Вы на начальной, движение назад невозможно'
    else
      @current_station = @route.stations_list[current_station_index - 1]
    end
  end
end
