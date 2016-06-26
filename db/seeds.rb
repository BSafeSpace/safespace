# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

users = [User.create(email: "annielo@berkeley.edu", password: "password", password_confirmation: "password", username: "Annie Lo"),
         User.create(email: "mnguyen@berkeley.edu", password: "password", password_confirmation: "password", username: "Minh Nguyen"),
         User.create( email: "mscott2757@berkeley.edu", password: "password", password_confirmation: "password", username: "Mason Scott"),
         User.create( email: "swee@berkeley.edu", password: "password", password_confirmation: "password", username: "Sagang Wee"),
         User.create( email: "j-tang@berkeley.edu", password: "password", password_confirmation: "password", username: "Joy Tang"),
         User.create( email: "monica-casanova@berkeley.edu", password: "password", password_confirmation: "password", username: "Monica Casanova")]

for num in 1..50
	User.create(email: "user#{num}@berkeley.edu", password: "password", password_confirmation: "password", username: "user #{num}")
end

User.all.each do |u|
	u.profile.age = rand(16...60)
	u.profile.save
end

questions = {mental_health: ["No issue: Seeking out peers", "Depression", "General Anxiety" , "Social Anxiety", "ADHD", "OCD", "Autistic", "Bipolar Disorder", "Post-traumatic Stress Disorder (PTSD)", "Grieving", "Addiction", "Insomnia", "Other"],
			class_standing: ["Freshman", "Sophomore", "Junior", "Senior", "Other"],
			gender: ["Male", "Female", "Transgender", "Intersex", "Gender Queer", "Gender Nonconforming", "Questioning", "Other"],
			ethnicity: ["African/ African American", "Chinese/ Chinese American", "Filipino/ Filipino American", "Vietnamese/ Vietnamese American", "Mexican/ Mexican American/ Chicano", "American Indian/ Alaska Native", "East Indian/ Pakistani","Japanese/ Japanese American", "Korean/ Korean American","Pacific Islander","Middle Eastern","White/ Caucasian","Latino/ Spanish American","Asian","Hispanic", "Other"],
			academic_focus: ["Undecided","Arts & Humanities","Biological Sciences","Business","Design","Economic Development & Sustainability", "Education","Engineering & Computer Science","Mathematics","Multi-Disciplinary","Natural Resources & Environment", "Physical Sciences","Pre-Health/Medicine","Pre-Law","Social Sciences","Other"],
			socioeconomic_status: ["Of low socioeconomic status", "Of middle socioeconomic status", "Of high socioeconomic status", "Other"],
			sexual_orientation: ["Heterosexual", "Gay", "Bisexual", "Questioning", "Fluid", "Queer", "Asexual", "Other"],
			religion: ["Baha’i","Buddhism","Christianity","Hinduism","Islam","Jainism","Judaism","Shinto","Sikhism","Taoism","Atheist", "Agnostic","Other"]}

questions.each do |category, names|
   names.each do |name|
	   Characteristic.create(name: name, category: category, created_at: "2016-04-15 12:00:00")
	end
end




