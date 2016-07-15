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

    required
    allow_multiple_selections
  end

  field :number do
    ask "How old are you?"
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

    required
    allow_multiple_selections
    can_specify_other
  end

  field :multiple_choice do
    ask "Ethnicity: Which of these best describes you?"

    choice "Prefer to omit from personal profile"
    choice "African or African-American"
    choice "Alaskan Native"
    choice "American Indian"
    choice "Asian"
    choice "Chinese or Chinese American"
    choice "Filipino or Filipino American"
    choice "Hispanic or Latino"
    choice "Middle Eastern"
    choice "White or Caucasian"
    choice "Native Hawaiian"
    choice "Pacific Islander"

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

    can_specify_other
  end

  field :multiple_choice do
    ask "Socioeconomic Status: Which of these best describe you?"

    choice "Prefer to omit from personal profile"
    choice "I am of low socioeconomic status"
    choice "I am of middle socioeconomic status"
    choice "I am of high socioeconomic status"

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
    
    can_specify_other
  end

  field :multiple_choice do
    ask "Living Situation: Which of these best describes you?"

    choice "Prefer to omit from personal profile"
    choice "Dorm"
    choice "Apartment"
    choice "Co-op"
    choice "Greek Housing"

    can_specify_other
  end

  field :statement do
    say "You're almost done! Please *bear* with us and answer some quick yes/no questions."
    button_text "Okay, let's do this."
  end

  field :yes_no do
    ask "Are you a transfer student"
  end

  field :yes_no do
    ask "Are you a first generation college student?"
  end

  field :yes_no do
    ask "Are you physically disabled?"
  end

  field :yes_no do
    ask "Are you a parent?"
  end

  field :yes_no do
    ask "Are you a single parent?"
  end

  field :yes_no do
    ask "Will you marry me?"
  end

  field :yes_no do
    ask "Have you ever been in foster care?"
  end

  field :yes_no do
    ask "Are you an intercollegiate athlete?"
  end

  field :yes_no do
    ask "Have you ever served in the military?"
  end

  field :yes_no do
    ask "Are you an out-of-state student?"
  end

  field :yes_no do
    ask "Are you an international student?"
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