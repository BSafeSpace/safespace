# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Seed the characteristics 
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

users = [User.new( email: "masoncscott@berkeley.edu", password: "password", password_confirmation: "password", username: "Cuddly Bear", peer_counselor: true, signed_liability: true, sign_in_count: 2, done_tut_filter: true, done_tut_add_friend: true),
		 User.new( email: "wilsonw926@berkeley.edu", password: "password", password_confirmation: "password", username: "Oski", peer_counselor: true, signed_liability: true, sign_in_count: 2, done_tut_filter: true, done_tut_add_friend: true),
		 User.new( email: "wilsonw@berkeley.edu", password: "password", password_confirmation: "password", username: "yee", peer_counselor: true, signed_liability: true, sign_in_count: 2, done_tut_filter: true, done_tut_add_friend: true), 
		 User.new( email: "monica-casanova@berkeley.edu", password: "peace&love2008", password_confirmation: "peace&love2008", username: "tralala", sign_in_count: 2, done_tut_filter: true, done_tut_add_friend: true, signed_liability: true),
         User.new( email: "user@berkeley.edu", password: "peace&love2008", password_confirmation: "peace&love2008", username: "User", showcase: true, signed_liability: true),
         User.new( email: "user1@berkeley.edu", password: "peace&love2008", password_confirmation: "peace&love2008", username: "User1", signed_liability: true)
         ]

users.each do |u|
	# Skip email confirmation for seeded users
	u.skip_confirmation!
	u.confirm
	u.save

	u.profile.age = rand(16...60)
	if !u.showcase
		u.signed_liability = true
		u.completed_bio = true
		u.done_tut_add_friend = true
		u.done_tut_filter = true
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

#Resources
Resource.create(name: "Counseling and Psychological Services (CPS) at UHS Tang Center", description: "CPS offers short term counseling for academic, career and personal issues. There is no charge to get started, and all registered students can access services regardless of their insurance plan.

The first five sessions are offered at no charge.", url: "https://uhs.berkeley.edu/counseling")
Resource.create(name: "Social Services at UHS Tang Center", description: "Social Services is comprised of a team of multidisciplinary and multicultural counselors and a dietitian. We provide confidential services and counseling to help students with changing behaviors, strengthening coping skills, problem solving, and identifying resources.

", url: "https://uhs.berkeley.edu/socialservices")
Resource.create(name: "Student to Student: Peer Counseling", description: "Student-to-Student Peer Counseling is a student-run organization on the Berkeley campus. Our counselors come from all backgrounds and are trained to provide empathetic and empowering counseling services to members of our campus community.", url: "https://sspc.berkeley.edu/")
Resource.create(name: "Suicide Prevention", description: "Suicide is a very real and very serious problem. If you are feeling suicidal, these resources are here to help you.

Crisis Support Services of Alameda County: 1800-309-2131

National Suicide Prevention Hotline:1-800-273-TALK (8255).

National Hopeline Network: 1.800.442.HOPE (4673)", url: "https://uhs.berkeley.edu/emergency#resources")
Resource.create(name: "Depression", description: "Counseling services: 

Counseling for Students/ Tang Center:

          M – W and F 8-4:30, Th 9-4:30

          www.uhs.berkeley.edu or Call 510-642-9494

Free depression screening hotline: 800-573-4433

American Psychiatric Association: www.psych.org

Online screening for depression: http://screening.mentalhealthscreening.org/locator

Facts about Depression:

National Institute of Mental Health Information Resources: www.nimh.nih.gov

National Mental Health Association: www.nmha.org or 800-969-6642

National Depressive and Manic Depressive Association: 800-82-NDMDA", url: "https://uhs.berkeley.edu/")
#Resource.create(name: "aaa", description: "aaa", url: "aaa")
Resource.create(name: "Disabled Students", description: "Cal Disabled Student’s Union website: https://dsp.berkeley.edu/

Disabled Students Graduate Support Group:

          Thu 1-2 PM / 3rd Floor Tang Center. Call 510-642-9494 for more information, or visit the DSP website at: https://dsp.berkeley.edu/", url: "https://dsp.berkeley.edu/")
Resource.create(name: "Sexual Health", description: "Learn more from a SHEP Counselor

Tang Center: Sexual Health and Sexuality page at the University Health Services website.", url: "https://uhs.berkeley.edu/sexuality")
Resource.create(name: "Stress and Anxiety", description: "Tang Center information on stress and anxiety and guide to Understanding and Managing Anxiety.

Tang’s Self-Care Resource Center.

Hotline: 1-800-829-3777

University Health Service: 642-2000

Counselor/Therapist: 642-9494

", url: "https://uhs.berkeley.edu/health-topics/mental-health/stress-and-anxiety")
Resource.create(name: "Clubs", description: "You Mean More: UC Berkeley's first mental health awareness and suicide prevention group. 

Red Tent: meetings and discussions on topics related to women's mental health. 

Half of Us: campaign to address the issue of mental health at Cal. 

Body Peace: promotion of body image positivity and raising awareness of body image issues and eating disorders. 

SoBears; Students for Recovery: support for students recovering from substance abuse and those in support of recovery. ", url: "")
Resource.create(name: "Resources in Oakland", description: "Asian Community Mental Health Services: 

310 8th Street, Suite 201, Oakland. 

510-451-6729

info@acmhs.org 

JFK Transpersonal and Holistic Counseling Center: 

2501 Harrison Street, Oakland 

510-444-3344

La Clinica De La Raza- Casa Del Sol: 

1501 Fruitvale Ave, Oakland 

510-535-6200

Lifelong Medical Care: 

Located throughout Berkeley and Oakland. 

510-981-4100 

Psychological Services Center: 

519 17th Street, Suite 210, Oakland. 

510-628-9065 

Sausal Creek Outpatient Stabilization Clinic: 

2620 26th Ave, Oakland. 

510-437-2363 

West Oakland Health Center: 

700 Adeline St, Oakland. 

510-835-9610 ", url: "")
Resource.create(name: "Resources in San Francisco", description: "Access Institute for Psychological Services: 

110 Gough St, 3rd Floor, SF. 

415-861-5449 

info@accessinst.org 

Chinatown North Beach Mental Health: 

729 Filbert Street, SF

415-352-2000

Insituto Familiar de la Raza- La clinica: 

2919 Mission St, SF

415-229-0500

laclinica@ifrsf.org

Marina Counseling Center: 

2317 Lombard St, SF

415-563-2137 

Richmond Area Multi-Services Inc (RAMS): 

3626 Balboa St, SF 

415-668-5955

info@ramsinc.org

UCSF Langley-Porter Psychiatric Hospital & Clinics:

401 Parnassus Ave, SF

415-476-7500 ", url: "")
Resource.create(name: "Other Resources", description: "2-1-1: crisis assistance and resource referrals. 

Alameda County Psycholocial Association Referral Line: 

510-433-9580

The Community Center for Health and Wellness: 

1057 East Meadow Circle, Palo Alto 

650-493-5006

counseling@sofia.edu 

Community Institute for Psychotherapy (CIP): 

1330 Lincoln Ave, Suite 201, San Rafael 

415-459-5999

CIPMarin@aol.com 

Feminist Therapy Referral Project: 

510-841-1269 

Sonoma County Mental Health Services: 

707-565-6900

800-870-8786

415-459-5999", url: "")

# Seed editable content
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

contact = <<EOD
<h2>Peer Counselor Location and Hours</h2>

<p class="peer-counselor-hours">
  Peer Counselor 1: MW 5-7pm at MLK
</p>
EOD

terms_of_service = ""

Content.create(about: about, slide_one: slide_one, slide_two: slide_two, slide_three: slide_three, slide_four: slide_four, terms_of_service: terms_of_service, contact: contact)


