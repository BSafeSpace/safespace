module ProfilesHelper

	# Parses answers from Typeform
	def parse_answers(answers)
		answers.each do |field|
			@tags = field[:tags]
			if @tags[0] == "characteristic"
				if @tags[1] == "single"
					@label = field[:value][:label]
					@category = @tags[2]
					push_char_id(@label, @category)
				else
					@labels = field[:value][:labels]
					@category = @tags[2]
					@labels.each do |label|
						push_char_id(label, @category)
					end
				end
			elsif @tags[0] == "profile_string"
				@label = field[:value][:label]
				@attr_name = @tags[1]
				params[:profile][:"#{@attr_name}"] = @label
			elsif @tags[0] == "profile_boolean"
				@attr_name = @tags[1]
				params[:profile][:"#{@attr_name}"] = field[:value]
			else
				params[:profile][:age] = field[:value]
			end
		end
	end

	def push_char_id(label, category)
		@char = Characteristic.find_name_and_category(label, category)
		if @char
			@char_id = @char.id
			params[:profile][:characteristic_ids] ||= []
			params[:profile][:characteristic_ids].push @char_id
		end
	end

end
