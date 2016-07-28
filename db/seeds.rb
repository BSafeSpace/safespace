# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

users = [User.create( email: "masoncscott@berkeley.edu", password: "password", password_confirmation: "password", username: "Peer Counselor", peer_counselor: true, signed_liability: true, sign_in_count: 2, done_tut_filter: true, done_tut_add_friend: true), 
		 User.create( email: "annielo@berkeley.edu", password: "password", password_confirmation: "password", username: "Annie Lo", sign_in_count: 2, done_tut_filter: true, done_tut_add_friend: true, signed_liability: true),
         User.create( email: "mnguyen@berkeley.edu", password: "password", password_confirmation: "password", username: "Minh Nguyen"),
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
questions = {mental_health: [omit_message, "No specifics: seeking out peers", "Depression", "General Anxiety" , "Social Anxiety", "ADHD", "OCD", "Autistic", "Bipolar Disorder", "Post-Traumatic Stress Disorder (PTSD)", "Grieving", "Addiction", "Insomnia", "Other"],
			class_standing: [omit_message, "Freshman", "Sophomore", "Junior", "Senior", "Other"],
			gender: [omit_message, "Male", "Female", "Transgender", "Intersex", "Gender Queer", "Gender Nonconforming", "Questioning", "Other"],
			ethnicity: [omit_message, "African/African American", "Alaskan Native", "Asian", "Chinese/Chinese American", "Filipino/Filipino American", "Vietnamese/Vietnamese American", "Mexican/Mexican American/Chicano", "Native American", "East Indian or Pakistani","Japanese/Japanese American", "Korean/Korean American","Pacific Islander","Middle Eastern","White/Caucasian", "Hispanic/Latino", "Other"],
			academic_focus: [omit_message, "Undecided","Arts & Humanities","Biological Sciences","Business","Design","Economic Development & Sustainability", "Education","Engineering & Computer Science","Mathematics","Multi-Disciplinary","Natural Resources & Environment", "Physical Sciences", "Pre-Health/Medicine","Pre-Law","Social Sciences","Other"],
			socioeconomic_status: [omit_message, "Of low socioeconomic  status", "Of middle socioeconomic status", "Of high socioeconomic status", "Other"],
			sexual_orientation: [omit_message, "Heterosexual", "Gay", "Bisexual", "Questioning", "Fluid", "Queer", "Asexual", "Other"],
			religion: [omit_message, "Baha’i","Buddhism","Christianity","Hinduism","Islam","Jainism","Judaism","Shinto","Sikhism","Taoism","Atheist", "Agnostic","Other"]}

questions.each do |category, names|
   names.each do |name|
	   Characteristic.create(name: name, category: category, created_at: "2016-04-15 12:00:00")
	end
end

User.all.each do |u|
	u.profile.age = rand(16...60)
	u.profile.save
end

User.all.reject { |u| u.peer_counselor }.each do |u|
	rand_characterictic = Characteristic.find(rand(1..Characteristic.all.count))
	u.profile.add_characteristic(rand_characterictic)

	rand_characterictic = Characteristic.find(rand(1..Characteristic.all.count))
	u.profile.add_characteristic(rand_characterictic)

	rand_user = User.find(rand(2..User.all.count))
	User.create_friendship(u, rand_user)

	rand_user = User.find(rand(2..User.all.count))
	User.create_friendship(u, rand_user)
end


