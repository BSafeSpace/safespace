require "ask_awesomely"
class BioTypeform

  include AskAwesomely::DSL

  title "Profile Typeform"

  tags "awesome", "hehe"

  field :statement do
    say "what you want to say"
    button_text "Okay, next question"
    show_quotation_marks
  end

  field :multiple_choice do
    ask "What is your favourite language?"
    choice "Ruby"
    choice "Python"
    choice "Javascript"
    choice "COBOL"

    can_specify_other
  end

  send_responses_to "http://safespace-dev.herokuapp.com/profiles"

end