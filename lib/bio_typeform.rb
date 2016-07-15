require "ask_awesomely"
class BioTypeform

  include AskAwesomely::DSL

  title "Anonymous Bio"

  tags "awesome", "hehe"

  field :statement do
    say "what you want to say"
    button_text "Okay, next question"
  end

  field :multiple_choice do
    ask "What is your favourite language?"
    choice "Ruby"
    choice "Python"
    choice "Javascript"
    choice "COBOL"

    can_specify_other
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