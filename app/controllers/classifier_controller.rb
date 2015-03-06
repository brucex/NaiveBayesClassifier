require 'classifier'

class ClassifierController < ApplicationController

	def index
	end

	def classifierresults
	  if Person.where(gender: 'male').count < 2 || Person.where(gender: 'female').count < 2
		redirect_to :back, :notice => "Must have 2 males and 2 females in databases"
	  elsif params[:height].blank? || params[:weight].blank?
		redirect_to :back, :notice => "Fields cannot be blank"
	  else
		gender = Classifier.classify(classifier_params)
		@person = Person.new(gender: gender, height: params[:height], weight: params[:weight])
	  end
	end

	private
		# Never trust parameters from the scary internet, only allow the white list through.
	  def classifier_params
    	params.permit(:height, :weight)
      end
end
