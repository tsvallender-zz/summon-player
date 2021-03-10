# Create main user
user = User.new
user.email = "user@summonplayer.com"
user.password = 'foobar'
user.password_confirmation = 'foobar'
user.username = 'user'
user.description = 'I am not a real person'
user.skip_confirmation!
user.save!

# Generate more users
10.times do |n|
    user = User.new
    user.email = "example-#{n+1}@summonplayer.com"
    user.password = "password"
    user.password_confirmation = "password"
    user.username = Faker::Name.unique.name.gsub!(/[^\w_]/i, '').first(20)
    user.description = "I am Example #{n+1}"
    user.skip_confirmation!
    user.save!
end

# Create categories
rpg = Category.create!(name: "RPG", description: "Tabletop Roleplaying Games")
ccg = Category.create!(name: "CCG", description: "Collectible card games")
wargame = Category.create!(name: "Wargame", description: "Wargames")
boardgame = Category.create!(name: "Board game", description: "Modern Board Games")
traditional = Category.create!(name: "Traditional", description: "Traditional Games")
larp = Category.create!(name: "LARP", description: "Live-Action Roleplaying Games")

# Generate tags
dnd = Tag.create!(name: "dnd", description: "Dungeons & Dragons")
kob = Tag.create!(name: "kidsonbikes", description: "Kids on Bikes")
warhammer = Tag.create!(name: "40k", description: "Warhammer 40000")

users_subset = User.order(:created_at).take(6)

# Generate ads
users_subset.each do |user|
    ad = user.ads.build(title: Faker::Lorem.sentence(word_count: 3).first(30),
        text: Faker::Lorem.sentence(word_count: 30))
    ad.category = rpg
    ad.save!
    AdTag.create!(ad_id: ad.id, tag_id: dnd.id)
    AdTag.create!(ad_id: ad.id, tag_id: kob.id)
    ad = user.ads.build(title: Faker::Lorem.sentence(word_count: 3).first(30),
        text: Faker::Lorem.sentence(word_count: 30))
    ad.category = rpg
    ad.save!
    AdTag.create!(ad_id: ad.id, tag_id: kob.id)
    ad = user.ads.build(title: Faker::Lorem.sentence(word_count: 3).first(30),
        text: Faker::Lorem.sentence(word_count: 30))
    ad.category = wargame
    ad.save!
    AdTag.create!(ad_id: ad.id, tag_id: warhammer.id)
end