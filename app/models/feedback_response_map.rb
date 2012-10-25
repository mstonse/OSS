class FeedbackResponseMap < ResponseMap
  belongs_to :reviewee, :class_name => 'Participant', :foreign_key => 'reviewee_id'
  belongs_to :review, :class_name => 'Response', :foreign_key => 'reviewed_object_id'
  belongs_to :reviewer, :class_name => 'AssignmentParticipant'

  def assignment
    self.review.map.assignment
  end  
  
  def show_review()
=begin
    if self.review
      return self.review.display_as_html()+"<BR/><BR/><BR/>"
    else
      return "<I>No review was performed.</I><BR/><BR/><BR/>"
    end
=end

    type = getIfReview
    review1 = showGivenReview(type)
    return review1
  end   
  
  def get_title
    return "Feedback"
  end  
  
  def questionnaire
    self.assignment.questionnaires.find_by_type('AuthorFeedbackQuestionnaire')
  end
  
  def contributor
    self.review.map.reviewee
  end

  def showGivenReview(type)
    if type == 'myReview'
      #a= new ReviewFeedback
      #review1 = a.showGivenReview(type)
      return self.review.display_as_html()+"<BR/><BR/><BR/>"
      #return review1
    else
      #b=new NoReviewFeedback
      #review1 = b.showGivenReview(type)
      return "<I>No review was performed.</I><BR/><BR/><BR/>"
      #return review1
    end
  end

  def getIfReview
    if self.review
      type = 'myReview'
    else
      type = 'noReview'
    end

  end
end

class ReviewFeedback < FeedbackResponseMap
  def showGivenReview(type)
    self.review.display_as_html()+"<BR/><BR/><BR/>"
  end
end

class NoReviewFeedback < FeedbackResponseMap
  def showGivenReview(type)
    "<I>No review was performed.</I><BR/><BR/><BR/>"
  end
end