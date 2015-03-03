class ClassifierController < ApplicationController

	def index
		
	end

	def classifierpage
		if ( Person.where(gender: 'male').count < 2 || Person.where(gender: 'female').count < 2 )
				redirect_to :back, :notice => "Must have 2 males and 2 females in databases"
		else
			gender = Classifier.classifier( classifier_params )
			@person = Person.new( gender: gender, height: params[:height], weight: params[:weight] )
		end
	end
	
	def classifier_params
      params.permit( :height, :weight )
    end

	private :classifier_params
end
