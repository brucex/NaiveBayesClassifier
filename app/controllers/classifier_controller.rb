class ClassifierController < ApplicationController

	def index
		
	end

	def classifierpage
		gender = Classifier.classifier( params[:height_field], params[:weight_field] )
		#@person = Person.new( gender: gender, height: params[:height_field], weight: params[:weight_field] )
	end
end
