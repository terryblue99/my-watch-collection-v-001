
# @user = User.create(email: "john@john.com", password: "john123")
# @watch = Watch.create(watch_name: "Subaqua Noma III", watch_maker: "John Watches", movement: "Ronda Z60 Quartz Chronograph", band: "Leather", model_number: "SN-1234", water_resistance: "500 meters", date_bought: "2017-09-23", user_id: @user.id)
# @user.watches << @watch
# @user.save
# @cw = ComplicationsWatch.create(watch_id: "#{@watch.id}", complication_id: 10, complication_description: "Has three pushers and two second hands")
# @watch = Watch.create(watch_name: "Zeus Magnum", watch_maker: "John Watches", movement: "Swiss Ronda 7003.L Quartz", band: "Stainless Steel", model_number: "M-5678", water_resistance: "200 meters", date_bought: "2016-10-03", user_id: @user.id)
# @user.watches << @watch
# @user.save
# @cw = ComplicationsWatch.create(watch_id: "#{@watch.id}", complication_id: 1, complication_description: "The window is also referred to as an aperture")
#
# @user = User.create(email: "smith@smith.com", password: "smith123")
# @watch = Watch.create(watch_name: "Pro Diver", watch_maker: "Smith Watches", movement: "Japanese SII NH35A Automatic w/ 24 Jewels", band: "Rubber Strap", model_number: "PD-9123", water_resistance: "300 meters", date_bought: "2017-11-31", user_id: @user.id)
# @user.watches << @watch
# @user.save
# @cw = ComplicationsWatch.create(watch_id: "#{@watch.id}", complication_id: 14, complication_description: "Greenwich Mean Time that displays two or more time zones")

Complication.destroy_all

complications = [{complication_name: "Date - Date Window", complication_description: "The window is also referred to as an aperture"},
         {complication_name: "Date - Big Date", complication_description: "Allows a much larger view of the date"},
         {complication_name: "Date - Pointer Date", complication_description: "A center hand points to the date along the outside periphery"},
         {complication_name: "Date - Day-Date", complication_description: "Adds the day of the week to the date"},
         {complication_name: "Date - Triple Calendar", complication_description: "Date, Day & Month"},
         {complication_name: "Date - Perpetual Calendar", complication_description: "Date, Day, Month, Year, and Leap Year"},
         {complication_name: "Day - Retrograde", complication_description: "The hand travels along an arc, and when it gets to the end, it jumps back to the beginning"},
         {complication_name: "Chronograph - One Button", complication_description: "Cannot measure interrupted time spans"},
         {complication_name: "Chronograph - Flyback", complication_description: "When 2nd button pushed while running, counters reset & start from zero"},
         {complication_name: "Chronograph - Retrograde", complication_description: "The hand travels along an arc, and when it gets to the end, it jumps back to the beginning"},
         {complication_name: "Chronograph - Split-Seconds", complication_description: "Has three pushers and two second hands"},
         {complication_name: "Chronograph - Tachymeter", complication_description: "Measures units per hour, generally miles or kilometers"},
         {complication_name: "Dual Time Zone - Subsidiary Dial", complication_description: "Around the World"},
         {complication_name: "Dual Time Zone - Dual Movement", complication_description: "Two separate movements with their own power source"},
         {complication_name: "Dual Time Zone - Dual Time", complication_description: "Both displays are powered by the same movement"},
         {complication_name: "Dual Time Zone - GMT", complication_description: "Greenwich Mean Time that displays two or more time zones"},
         {complication_name: "Dual Time Zone - GMT with Independent Hour Hand", complication_description: "The regular hour hand is set independently of the 24-hour hand"},
         {complication_name: "Dual Time Zone - GMT with Fixed Hour Hand", complication_description: "Its unique additional hour hand makes one revolution per day"},
         {complication_name: "Dual Time Zone - World Time Zone", complication_description: "Has a rotating inner bezel with 24-hour display and an outer bezel, listing the major cities in each of the 24 time zones"},
         {complication_name: "Misc - Moon Phase", complication_description: "Shows if it is a full, half, quarter, or new moon"},
         {complication_name: "Misc - Power Reserve", complication_description: "Measures the amount of power remaining in the watch"},
         {complication_name: "Misc - Sun & Moon", complication_description: "The sun is shown in daytime hours and the moon in the night time"},
         {complication_name: "Misc - Stopwatch", complication_description: "Stopwatch"},
         {complication_name: "Misc - Alarm", complication_description: "The alarm time is set independently of the main time"},
         {complication_name: "Misc - Tourbillon", complication_description: "Improves the balance of the watch, eliminating timekeeping errors caused by gravity and changing watch positions"},
         {complication_name: "Multi Function - Day-Date-24HR", complication_description: "Day, Date & 24 Hour Sub-Dials"}]

complications.each do |complication|
  Complication.create(complication)
end
