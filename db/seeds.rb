# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

users = [User.create( email: "masoncscott@berkeley.edu", password: "password", password_confirmation: "password", username: "Peer Counselor", peer_counselor: true, signed_liability: true, sign_in_count: 2, done_tut_filter: true, done_tut_add_friend: true), 
		 User.create( email: "annielo@berkeley.edu", password: "password", password_confirmation: "password", username: "Annie Lo", sign_in_count: 2, done_tut_filter: true, done_tut_add_friend: true, signed_liability: true),
         User.create( email: "mnguyen@berkeley.edu", password: "password", password_confirmation: "password", username: "Minh Nguyen", signed_liability: true),
         User.create( email: "mscott2757@berkeley.edu", password: "password", password_confirmation: "password", username: "Mason Scott"),
         User.create( email: "swee@berkeley.edu", password: "password", password_confirmation: "password", username: "Sagang Wee"),
         User.create( email: "j-tang@berkeley.edu", password: "password", password_confirmation: "password", username: "Joy Tang"),
         User.create( email: "monica-casanova@berkeley.edu", password: "password", password_confirmation: "password", username: "Monica Casanova"),
         User.create( email: "user@berkeley.edu", password: "password", password_confirmation: "password", username: "User", showcase: true)
         ]

for num in 1..50
	User.create(email: "user#{num}@berkeley.edu", password: "password", password_confirmation: "password", username: "user #{num}")
end

User.create_friendship(users[1], users[2])
User.create_friendship(users[1], users[3])
User.create_friendship(users[3], users[7])

omit_message = "Prefer to omit from personal profile"
questions = {mental_health: ["No specifics: seeking out peers", "Depression", "General Anxiety" , "Social Anxiety", "ADHD", "OCD", "Autistic", "Bipolar Disorder", "Post-Traumatic Stress Disorder (PTSD)", "Grieving", "Addiction", "Insomnia", "Other"],
			class_rank: [omit_message, "Freshman", "Sophomore", "Junior", "Senior", "Other"],
			gender: [omit_message, "Male", "Female", "Transgender", "Intersex", "Gender Queer", "Gender Nonconforming", "Questioning", "Other"],
			ethnicity: [omit_message, "African/African American", "Alaskan Native", "Asian", "Chinese/Chinese American", "Filipino/Filipino American", "Vietnamese/Vietnamese American", "Mexican/Mexican American/Chicano", "Native American", "East Indian or Pakistani","Japanese/Japanese American", "Korean/Korean American","Pacific Islander","Middle Eastern","White/Caucasian", "Hispanic/Latino", "Other"],
			academic_focus: [omit_message, "Undecided","Arts & Humanities","Biological Sciences","Business","Design","Economic Development & Sustainability", "Education","Engineering & Computer Science","Mathematics","Multi-Disciplinary","Natural Resources & Environment", "Physical Sciences", "Pre-Health/Medicine","Pre-Law","Social Sciences","Other"],
			socioeconomic_status: [omit_message, "Of low socioeconomic  status", "Of middle socioeconomic status", "Of high socioeconomic status", "Other"],
			living_situation: [omit_message, "Dorm", "Apartment", "Co-op", "Greek Housing", "Other"],
			sexual_orientation: [omit_message, "Heterosexual", "Gay", "Bisexual", "Questioning", "Fluid", "Queer", "Asexual", "Other"],
			religion: [omit_message, "Baha’i","Buddhism","Christianity","Hinduism","Islam","Jainism","Judaism","Shinto","Sikhism","Taoism","Atheist", "Agnostic","Other"]}

questions.each do |category, names|
   names.each do |name|
	   Characteristic.create(name: name, category: category, created_at: "2016-04-15 12:00:00")
	end
end

User.all.each do |u|
	u.profile.age = rand(16...60)
	if !u.showcase
		u.signed_liability = true
		u.completed_bio = true
		u.save
	end
	u.profile.save
end

User.all.reject { |u| u.peer_counselor }.each do |u|
	rand_characteristic = Characteristic.find(rand(1..Characteristic.all.count))
	u.profile.add_characteristic(rand_characteristic)

	rand_characteristic = Characteristic.find(rand(1..Characteristic.all.count))
	u.profile.add_characteristic(rand_characteristic)

	rand_user = User.find(rand(2..User.all.count))
	User.create_friendship(u, rand_user)

	rand_user = User.find(rand(2..User.all.count))
	User.create_friendship(u, rand_user)
end

slide_one = <<EOD
h1. What is SafeSpace?

This is both a place for people to:
* chat with like-minded peers who come from similar and/or different backgrounds
* share their experiences with other UC-Berkeley students when pursuing mental wellness
EOD

slide_two = <<EOD
h1. Support Techniques: LDVSB

h3. Lovely Dolphins Venture, Swim, and Bathe


        	
*LISTEN* to your SafeSpace Buddy. Give them space to talk about their concerns first. The focus should be on them, before it is on you.
            
*DON’T JUDGE.* No matter how minimal a person’s problems seem to you, their pain is very real to them. You have not been in that person’s shoes, so it is NOT helpful to question their past decisions, current behavior, or way of thinking.
            
*VALIDATE* their feelings. Comments like “you’re right to feel this way” or “it’s totally reasonable to think that” or “it’s ok, you’re not alone. X also happened to me” are helpful.
EOD

slide_three = <<EOD
h1. Support Techniques Continued:

h3. LDVSB Lovely Dolphins Venture, Swim, and Bathe

*SUPPORT.* When someone tells you about a particular struggle, show them you care, that you are present and want to help. Part of being supportive is being empathetic and open-minded.

*BRAINSTORM SOLUTIONS!* This may seem challenging, but that’s why we have a “Resource List” on SafeSpace. If someone needs real help, tell them Counseling and Psychological Services at Tang make referrals. Help them find a local clinic. In less drastic situations, however, feel free to give your buddy unbiased, sincere advice on what has worked for you when it comes to mental wellness. SafeSpace is but a transitory tool for you to realize the benefits of talking things out. *If, however, SafeSpace is not enough of a solution for you, help yourself and your buddies by connecting them or yourself with the right resources.*
EOD

slide_four = <<EOD
h1. Suicidal Ideation

Lastly, we will discuss Emergency Protocol. If someone mentions suicidal ideation, click on the big red protocol button to copy paste the Alameda County Crisis Hotline Number in their chat. *Suicidal ideation and self-harm are serious topics to be discussed with a professional. Any topics falling under suicide are prohibited on SafeSpace.*

A large school can feel very isolating and struggling with an additional layer of difficulty, such as poor mental health, can further distance you from the very thing you need: motivation to get professional help or finding a support network. And remember: *don’t be discouraged, not everyone will immediately find a perfect match. We hope you’ll find a supportive community here at Berkeley by using SafeSpace.* 
EOD

terms_of_service = ""

Content.create(slide_one: slide_one, slide_two: slide_two, slide_three: slide_three, slide_four: slide_four, terms_of_service: terms_of_service)


