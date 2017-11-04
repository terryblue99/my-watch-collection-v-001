# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
@user = User.create(email: "terry@terry.com", password: "terry123")
@watch = Watch.create(name: "Terry Subaqua Noma III", maker: "Terry Watches", movement: "Ronda Z60 Quartz Chronograph", band: "Leather", model_number: "SN-1234", water_resistance: "500 meters", date_bought: "2017-09-23")
@user.watches << @watch
@watch.save
@cw = ComplicationsWatch.create(watch_id: "#{@watch.id}", complication_id: 10, complication_quantity: 1)
@watch = Watch.create(name: "Blue Zeus Magnum", maker: "Terry Watches", movement: "Swiss Ronda 7003.L Quartz", band: "Stainless Steel", model_number: "M-5678", water_resistance: "200 meters", date_bought: "2016-10-03")
@user.watches << @watch
@watch.save
@cw = ComplicationsWatch.create(watch_id: "#{@watch.id}", complication_id: 1, complication_quantity: 1)

@user = User.create(email: "blue@blue.com", password: "blue123")
@watch = Watch.create(name: "TerryBlue Pro Diver", maker: "TerryBlue Watches", movement: "Japanese SII NH35A Automatic w/ 24 Jewels", band: "Rubber Strap", model_number: "PD-9123", water_resistance: "300 meters", date_bought: "2017-11-31")
@user.watches << @watch
@watch.save
@cw = ComplicationsWatch.create(watch_id: "#{@watch.id}", complication_id: 14, complication_quantity: 1)

complications = [{name: "Date: Date Window", description: "The window is also referred to as an aperture"},
         {name: "Date: Big Date", description: "Allows a much larger view of the date"},
         {name: "Date: Pointer Date", description: "A center hand points to the date along the outside periphery"},
         {name: "Date: Subsidiary Dial", description: "Around the World"},
         {name: "Date: Day-Date", description: "Adds the day of the week to the date"},
         {name: "Date: Triple Calendar", description: "Date, Day & Month"},
         {name: "Date: Perpetual Calendar", description: "Date, Day, Month, Year, and Leap Year"},
         {name: "Chronograph: One Button", description: "Cannot measure interrupted time spans"},
         {name: "Chronograph: Flyback", description: "When 2nd button pushed while running, counters reset & start from zero"},
         {name: "Chronograph: Split-Seconds", description: "Has three pushers and two second hands"},
         {name: "Chronograph: Tachymeter", description: "Measures units per hour, generally miles or kilometers"},
         {name: "Dual Time Zone: Dual Movement", description: "Two separate movements with their own power source"},
         {name: "Dual Time Zone: Dual Time", description: "Both displays are powered by the same movement"},
         {name: "Dual Time Zone: GMT", description: "Greenwich Mean Time that displays two or more time zones"},
         {name: "Dual Time Zone: GMT with Independent Hour Hand", description: "The regular hour hand is set independently of the 24-hour hand"},
         {name: "Dual Time Zone: GMT with Fixed Hour Hand", description: "Its unique additional hour hand makes one revolution per day"},
         {name: "Dual Time Zone: World Time Zone", description: "Has a rotating inner bezel with 24-hour display and an outer bezel, listing the major cities in each of the 24 time zones"},
         {name: "Misc: Moon Phase", description: "Shows if it is a full, half, quarter, or new moon"},
         {name: "Misc: Power Reserve", description: "Measures the amount of power remaining in the watch"},
         {name: "Misc: Alarm", description: "The alarm time is set independently of the main time"},
         {name: "Misc: Tourbillon", description: "Improves the balance of the watch, eliminating timekeeping errors caused by gravity and changing watch positions"}]

complications.each do |complication|
  Complication.create(complication)
end
