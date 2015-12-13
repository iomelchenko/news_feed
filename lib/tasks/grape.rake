namespace :grape do
  desc "routes"
  task :routes => :environment do
    V1::Api::AllApi.routes.each do |api|
      method = api.route_method.ljust(10)
      path = api.route_path.gsub(":version", api.route_version)
      puts "     #{method} #{path}"
    end
  end
end
