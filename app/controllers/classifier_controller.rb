class ClassifierController < ApplicationController

	def index
		
	end

	def classifierpage
		@gender = Classifier.classifier(params[:height_field], params[:weight_field])
	end
end
