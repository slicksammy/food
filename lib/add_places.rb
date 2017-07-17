require 'csv'

class AddPlaces

  def initialize(csv_path)
    @csv = CSV.read(csv_path, headers: true)
  end

  def add!
    @csv.each do |row|
      params = {
        address: "#{row["ADDRESS"]}, #{row["CITY"]}, #{row["STATE"]}, #{row["ZIP CODE"]}",
        name: row["DOING BUSINESS AS NAME"],
        place_type_id: 3,
        latitude: row["LATITUDE"],
        longitude: row["LONGITUDE"],
      }

      p = Place.create!(params)
      p.notes.create!(note_text: row["LICENSE DESCRIPTION"])
    end
  end
end
