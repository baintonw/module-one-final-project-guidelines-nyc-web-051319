# Should these have more info than name, how are they connected to Show?
# How do you connect episode instances and user instances through View? Should watch_episode method take in an episode instance? 
episode_1 = Episode.create(name: "Winter is Coming")
episode_2 = Episode.create(name: "The Kingsroad")
episode_3 = Episode.create(name: "Lord Snow")
episode_4 = Episode.create(name: "Cripples, Bastards, and Broken Things")

user_1 = User.create(name: "Mary")
user_2 = User.create(name: "Will")
user_3 = User.create(name: "Buddy Holly")
user_4 = User.create(name: "Mary Tyler Moore")

view_1 = user_1.watch_episode
view_2 = user_1.watch_episode
view_3 = user_2.watch_episode
view_4 = user_2.watch_episode
view_5 = user_3.watch_episode
view_6 = user_4.watch_episode



# binding.pry
# view_1 = View.create(user_id, episode_id)########
