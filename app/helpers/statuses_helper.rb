module StatusesHelper
	def markdownify(content)
      pipeline_context = { gmf: true, asset_root: "http://localhost:3000/images/" }
      pipeline = HTML::Pipeline.new [
        HTML::Pipeline::MarkdownFilter,
        HTML::Pipeline::EmojiFilter,
        #HTML::Pipeline::SanitizationFilter,
      ], pipeline_context
      pipeline.call(content)[:output].to_s.html_safe
	end
	
	def linked_users(body)
		body.gsub /@([\w]+[\-][\w]+)/ do |match|
			link_to match, user_path($1)
		end.html_safe
	end

	def link_preview(string)
		if(URI.extract(string)[0].present?)
			if URI.extract(string)[0].include?("youtube")
				video_id = URI.extract(string)[0].split("v=")[1]
				frame = "<div><iframe src='https://www.youtube.com/embed/#{video_id}'></iframe></div>"
				string.gsub!(URI.extract(string)[0], frame)
			else
				string.gsub!(URI.extract(string)[0], "<div><img id='status-image-preview' src='" + URI.extract(string)[0] + "'></div>")
			end
		else
			string
		end
	end
end
