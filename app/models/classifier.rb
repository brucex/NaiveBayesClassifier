class Classifier < ActiveRecord::Base
	
	Fields = Struct.new :height, :weight

	def self.classifier params	
		
		fields = Fields.new
		
		#add all params into the struct (assuming all values are numeric)
		fields.each_pair { | name, value | 
			fields[name] = params[name].to_i 
		}

		m_posterior = posterior('male', fields)
		f_posterior = posterior('female', fields)
		
		#determining if a female or male
		if f_posterior > m_posterior
			gender = "female"
		else 
			gender = "male"
		end
		
		gender
	end

	private
		#return array of values from a specified column selected in db filtered by gender
		def self.arrayOfAttributes gender, attribute
			arr=Person.where(gender: gender).pluck(attribute)
		end

		def self.mean attribute_arr
			#puts "mean array is #{attribute_arr.to_s }"
			#puts "mean array  size is #{attribute_arr.size }"
			
			mean = attribute_arr.inject(0.0){ |sum,x| sum + x } / attribute_arr.size

			#puts "mean is #{mean}"
			
			
		end

		def self.variance attribute_arr, mean
			#puts "variance array is #{attribute_arr.to_s }"
			#puts "variance array  size is #{attribute_arr.size }"
			variance = (attribute_arr.inject(0.0){ |s,x| s + (x - mean)**2 }) / ( attribute_arr.size - 1 )
			#puts "variance is #{variance}"
		end

		#return probability 
		def self.attr_probability attribute, attribute_arr
			mean = mean( attribute_arr )
			variance = variance( attribute_arr, mean )
			prob = ( 1 / Math.sqrt( 2 * Math::PI * variance )) * (Math::E**(-(( attribute - mean )**2) / ( 2 * variance )))
		end

		def self.probability gender
			ppl_total = Person.count
			gender_count = ( Person.where( gender: gender ).count ).to_f
			prob = gender_count / ppl_total
		end


		def self.posterior gender, fields

			num = probability( gender )

			fields.each_pair { | name, value | 
				num *= attr_probability( value, arrayOfAttributes( gender, name ) ) 
			}

			#num = posterior_numerator(gender, height, weight)
			
			denom = 0

			for i in ['male', 'female']
				num2 = probability( gender )
				
				fields.each_pair { | name, value | 
					num2 *= attr_probability( value, arrayOfAttributes( i, name ) ) 
				}

				denom += num2
			end

			num / denom

		end
end
