class Version

	MAYOR = 1
	MINOR = 1
  BUILD = 3

	def self.current
		"#{MAYOR}.#{MINOR}.#{BUILD}"
	end
end