require "ask_awesomely"
class BioTypeform

  include AskAwesomely::DSL

  title "Anonymous Bio"

  tags "awesome", "hehe"

  field :multiple_choice do
    ask "Mental Wellness: Which of these best describe you?"

    choice "Prefer to omit from personal profile"
    choice "No specifics: seeking out peers"
    choice "Depression"
    choice "General Anxiety"
    choice "Social Anxiety"
    choice "ADHD"
    choice "OCD"
    choice "Autistic"
    choice "Bipolar Disorder"
    choice "Post Traumatic Stress Disorder (PTSD)"
    choice "Grieving"
    choice "Addiction"
    choice "Insomnia"
    choice "Other"

    tags "characteristic", "multiple", "mental_health"
    required
    allow_multiple_selections
  end

  field :number do
    ask "How old are you?"

    tags "age"
    required
  end

  field :multiple_choice do
    ask "Academic Focus: Which of these best describe you?"

    choice "Prefer to omit from personal profile"
    choice "Undecided"
    choice "Arts & Humanities"
    choice "Biological Sciences"
    choice "Business"
    choice "Design"
    choice "Economic Development & Sustainability"
    choice "Education"
    choice "Engineering & Computer Science"
    choice "Mathematics"
    choice "Multi-Disciplinary"
    choice "Natural Resources & Environment"
    choice "Physical Sciences"
    choice "Pre-Health/Medicine"
    choice "Pre-Law"
    choice "Social Sciences"

    tags "characteristic", "single", "academic_focus"
    required
    can_specify_other
  end

  field :multiple_choice do
    ask "What is your class standing?"

    choice "Prefer to omit from personal profile"
    choice "Freshman"
    choice "Sophomore"
    choice "Junior"
    choice "Senior"

    tags "profile_string", "class_rank"
    required
    can_specify_other
  end

  field :multiple_choice do
    ask "Gender: Which of these best describes you?"

    choice "Prefer to omit from personal profile"
    choice "Male"
    choice "Female"
    choice "Transgender"
    choice "Intersex"
    choice "Gender queer"
    choice "Gender nonconforming"
    choice "Questioning"

    tags "characteristic", "multiple", "gender"
    required
    allow_multiple_selections
    can_specify_other
  end

  field :multiple_choice do
    ask "Ethnicity: Which of these best describes you?"
    
    choice "Prefer to omit from personal profile"
    choice "African/African American"
    choice "Alaskan Native"
    choice "American Indian"
    choice "Asian"
    choice "Chinese/Chinese American"
    choice "East Indian or Pakistani"
    choice "Filipino/Filipino American"
    choice "Hispanic or Latino"
    choice "Japanese/Japanese American"
    choice "Korean/Korean American"
    choice "Mexican/Mexican American/Chicano"
    choice "Middle Eastern"
    choice "Native American"
    choice "Native Hawaiian"
    choice "Pacific Islander"
    choice "Vietnamese/Vietnamese American"
    choice "White or Caucasian"

    tags "characteristic", "single", "ethnicity"
    required
    can_specify_other
  end

  field :multiple_choice do
    ask "Sexual Orientation: Which of these best describes you?"

    choice "Prefer to omit from personal profile"
    choice "Heterosexual"
    choice "Gay"
    choice "Bisexual"
    choice "Questioning"
    choice "Fluid"
    choice "Queer"
    choice "Asexual"

    tags "characteristic", "single", "sexual_orientation"
    can_specify_other
  end

  field :multiple_choice do
    ask "Socioeconomic Status: Which of these best describe you?"

    choice "Prefer to omit from personal profile"
    choice "I am of low socioeconomic status"
    choice "I am of middle socioeconomic status"
    choice "I am of high socioeconomic status"

    tags "profile_string", "socioeconomic_status"
    can_specify_other
  end

  field :multiple_choice do
    ask "Religion: Which of these best describes you?"

    choice "Prefer to omit from personal profile"
    choice "Baha’i"
    choice "Buddhism"
    choice "Christianity"
    choice "Hinduism"
    choice "Islam"
    choice "Jainism"
    choice "Judaism"
    choice "Shinto"
    choice "Sikhism"
    choice "Taoism"
    choice "Atheist"
    choice "Agnostic"
    
    tags "characteristic", "single", "religion"
    can_specify_other
  end

  field :multiple_choice do
    ask "Living Situation: Which of these best describes you?"

    choice "Prefer to omit from personal profile"
    choice "Dorm"
    choice "Apartment"
    choice "Co-op"
    choice "Greek Housing"

    tags "profile_string", "living_situation"
    can_specify_other
  end

  field :statement do
    say "You're almost done! Please *bear* with us and answer some quick yes/no questions."
    button_text "Okay, let's do this."
  end

  field :yes_no do
    ask "Are you a transfer student"
    tags "profile_boolean", "is_transfer_student"
  end

  field :yes_no do
    ask "Are you a first generation college student?"
    tags "profile_boolean", "is_first_generation_college_student"
  end

  field :yes_no do
    ask "Are you physically disabled?"
    tags "profile_boolean", "is_physically_disabled"
  end

  field :yes_no do
    ask "Are you a parent?"
    tags "profile_boolean", "is_parent"
  end

  field :yes_no do
    ask "Are you a single parent?"
    tags "profile_boolean", "is_single_parent"
  end

  field :yes_no do
    ask "Have you ever been in foster care?"
    tags "profile_boolean", "from_foster_care"
  end

  field :yes_no do
    ask "Are you an intercollegiate athlete?"
    tags "profile_boolean", "is_intercollegiate_athlete"
  end

  field :yes_no do
    ask "Have you ever served in the military?"
    tags "profile_boolean", "is_military"
  end

  field :yes_no do
    ask "Are you an out-of-state student?"
    tags "profile_boolean", "is_out_of_state_student"
  end

  field :yes_no do
    ask "Are you an international student?"
    tags "profile_boolean", "is_international_student"
  end

  design do
    question_color "#000000"
    button_color "#000000"
    answer_color "#4E4E4E"
    background_color "#FCD68A"

    font "Oswald"
  end

  send_responses_to "http://safespace-dev.herokuapp.com/profiles.json"

end