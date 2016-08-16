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

about = <<EOD
<h2>SafeSpace</h2>

<p>An anonymous, peer-led chat service for UC Berkeley undergraduate students to comfortably share their similar mental health issues in a virtual environment.</p>

<h3>The Issue</h3>

<p>Poor mental health is a widespread issue plaguing college students across the country. According to a national survey, 85 % of University mental health center directors reported an increase in "severe psychological problems over the last five years.” Nearly one in six college students has been diagnosed or treated for anxiety within the last 12 months. Half of all college students in the US report feeling so depressed at some point in time that they “have trouble functioning.” A UC Berkeley report had similar if not more drastic results.  Because prioritization of mental health improves school performance, reduces school withdrawals, and diminishes adverse life-course consequences, its significance should not be neglected.</p>

<p>Currently, Tang’s Counseling and Psychological Services (CPS) has 50 counselors for 36,000 students (ratio 1:720). According to an ASUC Senate Bill from 2014’s Mental Health Action Plan, there were approximately 5,700 students who had records at Tang Center’s CPS services, which is only about 16% of the 36,000 students. A UC Berkeley Graduate Survey confirms that students wish there were more mental health programs on campus.</p>

<h3>Our Solution</h3>

<p>SafeSpace is a website for UC Berkeley undergraduates to anonymously be paired with others similar to themselves and provide each other peer support; it is an anonymous, peer led chat. Our goal is to improve the overall mental health for undergraduates at UC Berkeley. The definition of “mental health” we use refers to any psychological distress and emotional well-being. Studies show that psychological distress in college peaks during freshman year and then declines for most because it is the transition to college life that is particularly challenging. Sharing with peers can reduce anxiety and support the development of coping strategies that reduce psychological distress and increase emotional well-being.</p>

<p>A UC Berkeley e-mail address is required to sign up for two main reasons: to avoid anonymous “internet trolls” (malicious users) so that only UC Berkeley students can sign up and to permanently delete users from SafeSpace if they are blocked three times. In addition, we’ve partnered with the campus club “Student to Student Peer Counseling” which will have their own general account for users to talk to other trained peers. By keeping it anonymous, students would not have to worry about being stigmatized, while still having that one friend (or several friends) available to confide in, who personally understand(s) their issues.</p>

<p>For example, a premed Latina with social anxiety would find other premed Latinas who also have social anxiety. SafeSpace initially targets first year students, transfers, and minorities, although it would not be exclusive to these populations. SafeSpace would NOT serve as a replacement for therapy or counseling, but rather a means for students to adapt to the challenges associated with attending a large university, understand that there is a community of people out there like themselves, and have a comfortable space to share their issues with someone who is able to relate to their struggles.</p>
EOD

slide_one = <<EOD
<h1>What is SafeSpace?</h1>

<p>This is both a place for people to:</p>
<ul>
	<li>chat with like-minded peers who come from similar and/or different backgrounds</li>
	<li>share their experiences with other UC-Berkeley students when pursuing mental wellness</li>
</ul>
EOD

slide_two = <<EOD
<h1>Support Techniques: LDVSB</h3>

<h3>Lovely Dolphins Venture, Swim, and Bathe</h3>


        	
<p><strong>LISTEN</strong> to your SafeSpace Buddy. Give them space to talk about their concerns first. The focus should be on them, before it is on you.</p>
            
<p><strong>DON’T JUDGE.</strong> No matter how minimal a person’s problems seem to you, their pain is very real to them. You have not been in that person’s shoes, so it is NOT helpful to question their past decisions, current behavior, or way of thinking.</p>
            
<p><strong>VALIDATE</strong> their feelings. Comments like “you’re right to feel this way” or “it’s totally reasonable to think that” or “it’s ok, you’re not alone. X also happened to me” are helpful.</p>
EOD

slide_three = <<EOD
<h1>Support Techniques Continued:</h1>

<h3>LDVSB Lovely Dolphins Venture, Swim, and Bathe</h3>

<p><strong>SUPPORT.</strong> When someone tells you about a particular struggle, show them you care, that you are present and want to help. Part of being supportive is being empathetic and open-minded.</p>

<p><strong>BRAINSTORM SOLUTIONS!</strong> This may seem challenging, but that’s why we have a “Resource List” on SafeSpace. If someone needs real help, tell them Counseling and Psychological Services at Tang make referrals. Help them find a local clinic. In less drastic situations, however, feel free to give your buddy unbiased, sincere advice on what has worked for you when it comes to mental wellness. SafeSpace is but a transitory tool for you to realize the benefits of talking things out. <strong>If, however, SafeSpace is not enough of a solution for you, help yourself and your buddies by connecting them or yourself with the right resources.</strong></p>
EOD

slide_four = <<EOD
<h1>Suicidal Ideation</h1>

<p>Lastly, we will discuss the Emergency Button. If someone mentions suicidal ideation, <span style="color:red;">click on the big red protocol button</span> to copy paste the Alameda County Crisis Hotline Number in their chat.</p>

<p><strong>Any topics falling under suicide are NOT to be discussed in SafeSpace solely for safety reasons. Do not feel ashamed of discussing suicidal ideation or self-harm with a professional or call a Suicide Prevention Hotline.</strong></p>
EOD

terms_of_service = ""

Content.create(about: about, slide_one: slide_one, slide_two: slide_two, slide_three: slide_three, slide_four: slide_four, terms_of_service: terms_of_service)


