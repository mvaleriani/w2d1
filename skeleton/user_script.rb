require_relative 'super_useful'

puts "'five' == #{convert_to_int('five')}"

feed_me_a_fruit
begin
  sam = BestFriend.new('', 5, '')
rescue ArgumentError
  puts "Based on input, you are NOT besties."
  sam = BestFriend.new()
end


sam.talk_about_friendship
sam.do_friendstuff
sam.give_friendship_bracelet
