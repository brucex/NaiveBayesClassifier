class Classifier < ActiveRecord::Base

	def self.classifier heightTxt, weightTxt	
	#calculating probability of males, females, and posterior
		height = heightTxt.to_i
		weight = weightTxt.to_i
		m_posterior = posterior('male', height, weight)
		f_posterior = posterior('female', height, weight)
		
		#determining if a female or male
		if f_posterior > m_posterior
			gender = "female"
		else 
			gender = "male"
		end
		puts m_posterior
		puts f_posterior
		gender
	end


	def self.arrayOfWeights gender
		weights_arr=Person.where(gender: gender).pluck(:weight)
		puts "weight array: #{weights_arr.to_s}"
		weights_arr
	end

	def self.arrayOfHeights gender
		heights_arr=Person.where(gender: gender).pluck(:height)
		puts "height array: #{heights_arr.to_s}"
		heights_arr
	end
	

	def self.mean attribute_arr
		puts attribute_arr.to_s
		mean = attribute_arr.inject(0.0){|sum,x| sum + x } / attribute_arr.size
	end

	def self.variance attribute_arr
		mean = mean(attribute_arr)
		variance = (attribute_arr.inject(0.0){|s,x| s + (x - mean)**2}) / (attribute_arr.size - 1) 
	end

	#return probability 
	def self.attr_probability attribute, attribute_arr
		mean = mean(attribute_arr)
		variance = variance(attribute_arr)
		prob = (1 / Math.sqrt( 2 * Math::PI * variance )) * (Math::E**(-((attribute - mean)**2)/(2* variance)))
	end

	def self.probability gender
		ppl_total = Person.count
		gender_count = (Person.where(gender: gender).count).to_f
		puts "the gender count is #{gender_count}"
		puts "the ppl count is #{ppl_total}"
		prob = gender_count / ppl_total
	end

	def self.posterior_numerator gender, height, weight
		prob = probability(gender)
		puts "the prob is #{prob}"
		height_prob = attr_probability(height,arrayOfHeights(gender))
		puts "the height_prob is #{height_prob}"
		weight_prob = attr_probability(weight,arrayOfWeights(gender))
		puts "the weight_prob is #{weight_prob}"
		prob * height_prob * weight_prob
	end

	def self.evidence height, weight
		m_prob = posterior_numerator('male', height, weight)
		f_prob = posterior_numerator('female', height, weight)
		puts "the m_prob is #{m_prob}"
		puts "the f_prob is #{f_prob}"
		evid = m_prob + f_prob;
	end

	def self.posterior gender, height, weight
		posterior_numerator(gender, height, weight)/ evidence(height, weight)
	end

end
