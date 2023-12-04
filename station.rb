class Station
  attr_reader :trains, :name

  def initialize(name)
    @name = name
    @trains = []
  end

  def take_train(train)
    trains << train
  end

  def send_train(train)
    trains.delete(train)
  end

  def trains_by_type(type)
    trains.select {|train| train.type == type}
  end
end

class Route
  attr_reader :stations

  def initialize(start_station, finish_station)
    @stations = [start_station, finish_station]
  end

  def add_tintermediate_station(station)
    stations.insert(-2, station)
  end

  def remove_tintermediate_station
    if stations.size > 2
      stations.delete_at(-2)
    else
      stations
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
    self.speed += speed
  end

  def brake
    self.speed = 0
  end

  def add_number_of_wagons
    self.number_of_wagons += 1 if speed == 0
  end

  def remove_number_of_wagons
    self.number_of_wagons -= 1 if speed == 0
  end

  def set_route(route)
    @route = route
    @current_station = @route.stations.first
  end

  def move_forward
    current_station_index = station_index(@current_station)
    if current_station_index == @route.stations.size - 1
      stations
    else
      @current_station = @route.stations[current_station_index + 1]
    end
  end

  def move_backward
    current_station_index = station_index(@current_station)
    if current_station_index.zero?
      stations
    else
      @current_station = @route.stations[current_station_index - 1]
    end
  end

  def station_index(station)
    @route.stations.index(station)
  end

  def next_station
    @current_station = @route.stations[current_station_index + 1]
  end

  def previous_station
    @current_station = @route.stations[current_station_index - 1]
  end
end
