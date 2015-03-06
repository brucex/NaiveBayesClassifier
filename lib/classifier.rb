# Classifier class includes methods that helps implements the Naive Bayes classifier.
# The classifier takes in a parameters of attributes entered by a user, calculates the 
# probability of a person being a male or female, and returns the gender back to the user.
# This library makes an assumption that the values of the attributes are in a table
# called Person.
# 
# Author:: Bruce Xu

# Structure to hold all the attributes and their values. Add new attributes to this structure when
# adding more attributes to the Person table.
Fields = Struct.new :height, :weight
 
class Classifier
  class << self
	  # Takes in all the values of the attributes of a person from the user
	  # Returns gender of sample
	  def classify(params)
	  	fields = Fields.new
		
		# Add all params entered by user into a structure (assuming all values are numeric)
		# This will allow us to easily add more attributes in the future if we want 
		fields.each_pair { | name, value | fields[name] = params[name].to_i }

		# Calculating the posterior for a female and a male
		m_posterior = posterior('male', fields)
		f_posterior = posterior('female', fields)
		
		# Greater posterior will determine if the sample is a female or male
		gender = f_posterior > m_posterior ? "female" : "male"
	  end

	  private

		# Takes in a gender of 'male' or 'female' and a attribute of Person
		# Return array of values from a specified column selected in db filtered by gender
		def arrayOfAttributes(gender, attribute) #:doc:
		  array = Person.where(gender: gender).pluck(attribute)
		end

		# Takes in an array of values
		# Returns the mean
		def mean(attribute_arr) #:doc:
		  mean = attribute_arr.inject(0.0){ |sum,x| sum + x } / attribute_arr.size					
		end

		# Takes in an array of values and the mean
		# Takes in an array of mean so it doesnt have to be calculated twice in the attr_probability method
		# Returns the variance
		def variance(attribute_arr, mean) #:doc:
		  variance = (attribute_arr.inject(0.0){ |s,x| s + (x - mean)**2 }) / ( attribute_arr.size - 1 )
		end

		# Takes in the value of the attribute the user submitted and 
		# the array of values of an attribute in the Person table 
		# Returns the probability of the sample having similiar attributes
		def attr_probability(attribute, attribute_arr) #:doc:
		  mean = mean(attribute_arr)
		  variance = variance(attribute_arr, mean)
		  prob = (1 / Math.sqrt(2 * Math::PI * variance)) * (Math::E**(-((attribute - mean)**2) / (2 * variance)))
		end

		# Takes in a gender string of 'male' or 'female'
		# Returns the probability a gender based on values in Person table
		def probability(gender) #:doc:
		  ppl_total = Person.count
	  	  gender_count = (Person.where(gender: gender).count).to_f
		  prob = gender_count / ppl_total
		end

		# Takes in a gender 'male' or 'female'
		# Takes in a Field structure with the attributes we want to sample against
		# Returns the probability of the sample being a certain gender  
		def posterior(gender, fields) #:doc:
	      # Calculating the numerator for the posterior
		  numerator = probability(gender)

		  fields.each_pair { | name, value | 
    		numerator *= attr_probability(value, arrayOfAttributes(gender, name))
		  }
				
		  evidence = 0

		  # Calculating the evidence/denominator for the posterior
		  # Evidence is the male probability + the female probability
		  for i in ['male', 'female']
    		num = probability(i)
					
		    # Multiplying all the probability attributes of a gender
		    fields.each_pair { | name, value | 
			  num *= attr_probability(value, arrayOfAttributes(i, name))
		 	}

			evidence += num 
		  end
		  numerator / evidence
		end
  end
end