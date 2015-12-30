namespace :dummy_api do

  FIXED_ENDPOINTS = [
    "/homepage",
  ]

  TARGET_DIRECTORY = File.join(File.dirname(Rails.root), 'dummy-api')

  def routes
    Rails.application.routes.url_helpers
  end

  desc "Wipe and regenerate API fixtures in /dummy-api from development mode endpoints"
  task :regenerate => [ 'db:sample_data:reload', :wipe_dummy_directory, :generate ]

  task :wipe_dummy_directory do
    sh "rm -rf #{TARGET_DIRECTORY}"
  end

  desc "Generate API fixtures in /dummy-api from development mode endpoints"
  task :generate => :environment do
    require 'fileutils'

    endpoints = FIXED_ENDPOINTS
    puts "Making public pages"
    endpoints += Page.all.map     { |page| routes.page_path(page) }
    puts "Making admin pages"
    endpoints += Page.all.map     { |page| routes.admin_page_path(page) }
    puts "Making admin menus"
    endpoints += Menu.list.map    { |menu| routes.admin_menu_path(menu) }
    puts "Making admin menu items"
    endpoints += MenuItem.where('parent_id IS NOT NULL').map { |item| routes.admin_menu_item_path(item) }

    endpoints.each do |endpoint|
      filename = File.join(TARGET_DIRECTORY, endpoint + ".json")
      FileUtils.mkdir_p(File.dirname(filename))

      begin
        response = `curl -H 'Accept: application/json' http://localhost:3000#{endpoint}`
        json_hash = JSON.parse(response)
      rescue JSON::ParserError => ex
        puts ex.backtrace
        puts "A parser error occurred on endpoint #{endpoint}:  please see error.html"
        File.open('error.html', 'w') do |file|
          file.write response
        end
        exit
      end

      File.open(filename, 'w') do |file|
        file.write JSON.pretty_generate(json_hash)
      end
    end
  end

end
