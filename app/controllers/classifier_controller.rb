class ClassifierController < ApplicationController

	def index
		#@person = Classifier.new
	end

	def classifierpage

		if ( Person.where(gender: 'male').count < 2 || Person.where(gender: 'female').count < 2 )
			redirect_to :back, :notice => "Must have 2 males and 2 females in databases"
		
		elsif params[:height].blank? || params[:weight].blank?
			redirect_to :back, :notice => "Fields cannot be blank"
		else
			gender = Classifier.classifier( classifier_params )
			@person = Person.new( gender: gender, height: params[:height], weight: params[:weight] )
		end
	end
	
	def classifier_params
      #params.require(:person).permit( :height, :weight )
    	params.permit( :height, :weight )
    end

	private :classifier_params
end
