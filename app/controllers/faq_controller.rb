class FaqController < ApplicationController
  def show

    @first_question = Faq.new
    @first_question.question = "What is gCamp?"
    @first_question.answer = "gCamp is an awesome tool that is going to change your life. gCamp is your one stop shop to organize all your tasks. You'll also be able to track comments that you and others make. gCamp may eventually replace all need for paper and pens in the entire world. Well, maybe not, but it's going to be pretty cool."
    @first_question.slug = "first-question"

    @second_question = Faq.new
    @second_question.question = "How do I join gCamp?"
    @second_question.answer = "As soon as it's ready for the public, you'll see a signup link in the upper right. Once that's there, just click it and fill in the form!"
    @second_question.slug = "second-question"

    @third_question = Faq.new
    @third_question.question = "When will gCamp be finished?"
    @third_question.answer = "gCamp is a work in progress. That being said, it should be fully functional in the next few weeks. Functional. Check in daily for new features and awesome functionality. It's going to blow your mind. Organization is just a click away. Amazing!"
    @third_question.slug = "third-question"

    @questions = [@first_question, @second_question, @third_question]


  end
end
