class ClassifierController < ApplicationController

	def index
		
	end

	def classifierpage
		gender = Classifier.classifier( classifier_params )
		@person = Person.new( gender: gender, height: params[:height], weight: params[:weight] )
	end
	
	def classifier_params
      params.permit( :height, :weight )
    end

	private :classifier_params
end
