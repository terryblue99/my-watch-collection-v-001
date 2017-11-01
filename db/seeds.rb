# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
@user = User.create(email: "terry@terry.com", password: "terry123")
@watch = Watch.create(name: "Terry Subaqua Noma III", maker: "Terry Watches", movement: "Ronda Z60 Quartz Chronograph", band: "Leather", model_number: "SN-1234", water_resistance: "500 meters", date_bought: "2017-09-23")
@watch.user_id = @user.id
@watch.save
@watch = Watch.create(name: "Blue Zeus Magnum", maker: "Terry Watches", movement: "Swiss Ronda 7003.L Quartz", band: "Stainless Steel", model_number: "M-5678", water_resistance: "200 meters", date_bought: "2016-10-03")
@watch.user_id = @user.id
@watch.save

@user = User.create(email: "blue@blue.com", password: "blue123")
@watch = Watch.create(name: "TerryBlue Pro Diver", maker: "TerryBlue Watches", movement: "Japanese SII NH35A Automatic w/ 24 Jewels", band: "Rubber Strap", model_number: "PD-9123", water_resistance: "300 meters", date_bought: "2017-11-31")
@watch.user_id = @user.id
@watch.save

complications = Hash[[
"Date: Date Window",
"Date: Big Date",
"Date: Pointer Date",
"Date: Subsidiary Dial",
"Date: Day-Date",
"Date: Triple Calendar (date, Day & month)",
"Date: Perpetual Calendar (date, day, month, year, and leap year)",
"Chronograph: One Button (cannot measure interrupted time spans)",
"Chronograph: Flyback (can reset counters and start again from zero)",
"Chronograph: Split-Seconds (has three pushers and two second hands)",
"Chronograph: Tachymeter (measures units per hour, generally miles or kilometers)",
"Dual Time Zone: Dual Movement",
"Dual Time Zone: Dual Time (both displays powered by the same movement)",
"Dual Time Zone: GMT (Greenwich Mean Time)",
"Dual Time Zone: GMT with Independent Hour Hand",
"Dual Time Zone: GMT with Fixed Hour Hand",
"Dual Time Zone: World Time Zone",
"Misc: Moon Phase",
"Misc: Power Reserve",
"Misc: Power Reserve",
"Misc: Tourbillon"
].map { |complication| [complication, Complication.create(name: complication)] }]