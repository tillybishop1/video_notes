# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

puts "🌱 Seeding database..."

# Clear existing data
Note.destroy_all
Video.destroy_all
User.destroy_all

# Create test users
puts "Creating users..."
user1 = User.create!(
  email: "demo@example.com",
  password: "password123",
  password_confirmation: "password123"
)

user2 = User.create!(
  email: "test@example.com",
  password: "password123",
  password_confirmation: "password123"
)

# Create sample videos with real Mux playback IDs
# Note: These are example Mux playback IDs - you'll need to replace with your own
puts "Creating videos..."

video1 = Video.create!(
  title: "Designing with Salvaged and Reclaimed Materials",
  description: "
          In her first ever course acclaimed interior designer and founder of renowned architectural salvage and design firm Retrouvius, Maria Speake shares her philosophy of reuse and shows how to bring warmth, character, and sustainability to any home.",
  mux_playback_id: "rR8P8mSaKDzz02TsftugTUdI00cQPJX00oy",
  duration: 596
)

video2 = Video.create!(
  title: "Learn the Magic of Decorating",
  description: "Discover the secret to creating magical, personal, and timeless interiors with celebrated American designer Michael S. Smith.",
  mux_playback_id: "qxb01i6T202018GFS02vp9RIe01icTcDCjVzQpmaB00CUisJ4",
  duration: 734
)

video3 = Video.create!(
  title: "The Art of Paper Lampshade Making",
  description: "Fill your home with artful handmade lampshades using Rosi de Ruig's practical techniques.",
  mux_playback_id: "ER01HKs502EEHGPwnSyJYxj00n7sLy3j18J25CQuVRXtbE",
  duration: 120
)


puts "✅ Created #{User.count} users"
puts "✅ Created #{Video.count} videos"
puts ""
puts "Test credentials:"
puts "Email: demo@example.com"
puts "Password: password123"
puts ""
puts "🎉 Seeding complete!"
