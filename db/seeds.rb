
# @user = User.create(email: "john@john.com", password: "john123")
# @watch = Watch.create(name: "Subaqua Noma III", maker: "John Watches", movement: "Ronda Z60 Quartz Chronograph", band: "Leather", model_number: "SN-1234", water_resistance: "500 meters", date_bought: "2017-09-23", user_id: @user.id)
# @user.watches << @watch
# @user.save
# @cw = ComplicationsWatch.create(watch_id: "#{@watch.id}", complication_id: 10, complication_description: "Has three pushers and two second hands")
# @watch = Watch.create(name: "Zeus Magnum", maker: "John Watches", movement: "Swiss Ronda 7003.L Quartz", band: "Stainless Steel", model_number: "M-5678", water_resistance: "200 meters", date_bought: "2016-10-03", user_id: @user.id)
# @user.watches << @watch
# @user.save
# @cw = ComplicationsWatch.create(watch_id: "#{@watch.id}", complication_id: 1, complication_description: "The window is also referred to as an aperture")

# @user = User.create(email: "smith@smith.com", password: "smith123")
# @watch = Watch.create(name: "Pro Diver", maker: "Smith Watches", movement: "Japanese SII NH35A Automatic w/ 24 Jewels", band: "Rubber Strap", model_number: "PD-9123", water_resistance: "300 meters", date_bought: "2017-11-31", user_id: @user.id)
# @user.watches << @watch
# @user.save
# @cw = ComplicationsWatch.create(watch_id: "#{@watch.id}", complication_id: 14, complication_description: "Greenwich Mean Time that displays two or more time zones")

complications = [{name: "Date - Date Window", description: "The window is also referred to as an aperture"},
         {name: "Date - Big Date", description: "Allows a much larger view of the date"},
         {name: "Date - Pointer Date", description: "A center hand points to the date along the outside periphery"},
         {name: "Date - Subsidiary Dial", description: "Around the World"},
         {name: "Date - Day-Date", description: "Adds the day of the week to the date"},
         {name: "Date - Triple Calendar", description: "Date, Day & Month"},
         {name: "Date - Perpetual Calendar", description: "Date, Day, Month, Year, and Leap Year"},
         {name: "Chronograph - One Button", description: "Cannot measure interrupted time spans"},
         {name: "Chronograph - Flyback", description: "When 2nd button pushed while running, counters reset & start from zero"},
         {name: "Chronograph - Split-Seconds", description: "Has three pushers and two second hands"},
         {name: "Chronograph - Tachymeter", description: "Measures units per hour, generally miles or kilometers"},
         {name: "Dual Time Zone - Dual Movement", description: "Two separate movements with their own power source"},
         {name: "Dual Time Zone - Dual Time", description: "Both displays are powered by the same movement"},
         {name: "Dual Time Zone - GMT", description: "Greenwich Mean Time that displays two or more time zones"},
         {name: "Dual Time Zone - GMT with Independent Hour Hand", description: "The regular hour hand is set independently of the 24-hour hand"},
         {name: "Dual Time Zone - GMT with Fixed Hour Hand", description: "Its unique additional hour hand makes one revolution per day"},
         {name: "Dual Time Zone - World Time Zone", description: "Has a rotating inner bezel with 24-hour display and an outer bezel, listing the major cities in each of the 24 time zones"},
         {name: "Misc - Moon Phase", description: "Shows if it is a full, half, quarter, or new moon"},
         {name: "Misc - Power Reserve", description: "Measures the amount of power remaining in the watch"},
         {name: "Misc - Alarm", description: "The alarm time is set independently of the main time"},
         {name: "Misc - Tourbillon", description: "Improves the balance of the watch, eliminating timekeeping errors caused by gravity and changing watch positions"}]

complications.each do |complication|
  Complication.create(complication)
end
