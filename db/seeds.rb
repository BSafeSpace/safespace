# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

annie = User.create(email: "annielo@berkeley.edu", password: "password", password_confirmation: "password", username: "Annie Lo")
minh = User.create(email: "mnguyen@berkeley.edu", password: "password", password_confirmation: "password", username: "Minh Nguyen")
u1 = User.create( email: "user1@berkeley.edu", password: "password", password_confirmation: "password", username: "user1")
u2 = User.create( email: "user2@berkeley.edu", password: "password", password_confirmation: "password", username: "user2")
u3 = User.create( email: "user3@berkeley.edu", password: "password", password_confirmation: "password", username: "user3")
u4 = User.create( email: "user4@berkeley.edu", password: "password", password_confirmation: "password", username: "user4")
u5 = User.create( email: "user5@berkeley.edu", password: "password", password_confirmation: "password", username: "user5")
u6 = User.create( email: "user6@berkeley.edu", password: "password", password_confirmation: "password", username: "user6")

mental_health = ["Depression" , "Feelings of Isolation/Loneliness" , "General Anxiety/Stress" , "Social Anxiety" , 
				"Autistic" , "Bipolar Disorder" , "Eating Disorder" , "Have Been Sexually Assaulted" , "Grieving", 
				"Other/Prefer to omit from personal profile"]

gender = ["Male", "Female", "Transgender", "Intersex", "Gender Queer", "Gender Nonconforming", "Questioning", "Other/Prefer to omit from personal profile"]

ethnicity = ["African/ African American", "Chinese/ Chinese American", "Filipino/ Filipino American", "Vietnamese/ Vietnamese American",
	"Mexican/ Mexican American/ Chicano", "American Indian/ Alaska Native", "East Indian/ Pakistani","Japanese/ Japanese American","Korean/ Korean American","Pacific Islander","MIddle Eastern","White/ Caucasian","Latino/ Spanish American","Asian","Hispanic","Other/Prefer to omit from personal profile"]

academic_focus = ["Undecided","Arts & Humanities","Biological Sciences","Business","Design","Economic Development & Sustainability",
	"Education","Engineering & Computer Science","Mathematics","Multi-Disciplinary","Natural Resources & Environment",
	"Physical Sciences","Pre-Health/Medicine","Pre-Law","Social Sciences","Other/Prefer to omit from personal profile"]

religion = ["Baha’i","Buddhism","Christianity","Hinduism","Islam","Jainism","Judaism","Shinto","Sikhism","Taoism","Atheist",
	"Agnostic","Other/Prefer to omit from personal profile"]

questions = [mental_health, gender, ethnicity, academic_focus, religion]

questions.each do |question|
   question.each do |el|
	   Characteristic.create(name: el, created_at: "2016-04-15 12:00:00")
	end
end



