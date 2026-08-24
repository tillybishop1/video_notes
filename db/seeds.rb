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
  title: "Big Buck Bunny",
  description: "A large and lovable rabbit deals with three tiny bullies, led by a flying squirrel, who are determined to squelch his happiness.",
  mux_playback_id: "EcHgOK9coz5K4rjSwOkoE7Y7O01201YMIC200RI6lNxnhs",
  duration: 596
)

video2 = Video.create!(
  title: "Tears of Steel",
  description: "A group of warriors and scientists battle to protect their city's future in this sci-fi short film.",
  mux_playback_id: "qxb01i6T202018GFS02vp9RIe01icTcDCjVzQpmaB00CUisJ4",
  duration: 734
)

video3 = Video.create!(
  title: "Sample Demo Video",
  description: "A sample video for testing the video notes feature. This demonstrates how the application works.",
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
