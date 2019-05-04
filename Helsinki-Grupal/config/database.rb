DataMapper.logger = logger
DataMapper::Property::String.length(255)

ENV['DATABASE_URL'] = "postgres://#{ENV['DB_USER']}:#{ENV['DB_PASSWORD']}@#{ENV['DB_HOST']}/#{ENV['DB_NAME']}" unless ENV['DATABASE_URL']

case Padrino.env
  when :development then DataMapper.setup(:default, 'postgres://jobvacancy:jobvacancy@localhost/jobvacancy_development')
  when :test        then DataMapper.setup(:default, 'postgres://jobvacancy:jobvacancy@localhost/jobvacancy_test')
  when :ci      then DataMapper.setup(:default, 'postgres://jobvacancy:jobvacancy@postgres/jobvacancy')
  when :staging 		then DataMapper.setup(:default, ENV['DATABASE_URL'])
  when :production  then DataMapper.setup(:default, ENV['DATABASE_URL'])
end
